#!/bin/bash
# Records the "Bite size sessions" videos (docs/videos/session-<name>.mp4): a tape narrated with comments typed in
# the terminal (tapes/session-<name>.tape), followed by a scroll through the HTML report that the tape generated.
#
# usage: KDP_DIR=/Users/Shared/kafka-docker-playground scripts/generate-session-videos.sh [session name...]
#        (default: all the sessions)
#
# requirements: vhs, ffmpeg, Google Chrome (headless screenshots of the HTML report), docker for the sessions that
# run an example (cfk-bundle, dlq, smt-test, topic-produce, benchmark)
# Same isolation as scripts/generate-cli-videos.sh (neutral clone path, env -i, empty HOME except for the docker
# sessions, no-op open), but it does not change your playground config.
#
# ⚠️ the dlq, smt-test, topic-produce and benchmark sessions start an example off camera: it stops the environment
# that is running in that clone
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd "$DIR/.."

CHROME="${CHROME:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"
command -v google-chrome > /dev/null && CHROME=google-chrome

export KDP_DIR="${KDP_DIR:-/Users/Shared/kafka-docker-playground}"
if [ ! -x "$KDP_DIR/scripts/cli/playground" ]
then
  echo "❌ no kafka-docker-playground clone in KDP_DIR=$KDP_DIR"
  exit 1
fi
if [[ "$KDP_DIR" == "$HOME"* ]]
then
  echo "❌ KDP_DIR=$KDP_DIR is under your home folder, which would show in the videos: use a neutral path"
  exit 1
fi

# per session:
#   report      HTML report written by the tape (a glob: the newest file matching it), empty when there is none
#   scroll      the scroll through the report: "<seconds to hold>:<y in the 1400 px wide page>" steps, 3 s of
#               scrolling between two steps
#   page_height height of the headless browser window, at least the height of the report page
#   docker      yes when the tape needs docker (your HOME is then used, for the docker config)
#   setup       function run before the recording, off camera, in KDP_DIR
# topic-produce is not in the list yet: its producer hangs now and then in the vhs terminal (see the tape)
ALL_SESSIONS=(thread-dump gc-logs flight-recorder oracle-xstream-report cfk-bundle sourcecode dlq smt-test benchmark)
session_settings() {
  report="" scroll="" page_height=4100 docker="" setup=""
  case "$1" in
    thread-dump)
      report="/tmp/thread-dump/*-thread-report.html"
      scroll="4:0 7:960 6:2560"
      ;;
    gc-logs)
      report="/tmp/gc-logs/*-gc-report.html"
      scroll="5:0 8:1150"
      ;;
    flight-recorder)
      report="/tmp/flight-recorder/*-jfr-report.html"
      scroll="6:0 7:820"
      ;;
    oracle-xstream-report)
      report="/tmp/xstream/*-xstream-report.html"
      scroll="4:0 7:560 5:3350"
      page_height=4700
      ;;
    cfk-bundle)
      report="/tmp/cfk-bundle/*-cfk-report-*.html"
      scroll="5:0 6:800 6:1550"
      docker=yes
      ;;
    sourcecode)
      ;;
    dlq)
      docker=yes
      setup=setup_dlq
      ;;
    smt-test)
      report="/tmp/playground-smt-test/smt-test-chain-*.html"
      scroll="5:0 6:900 7:1640"
      docker=yes
      setup=setup_smt_test
      ;;
    topic-produce)
      docker=yes
      setup=setup_topic_produce
      ;;
    benchmark)
      report="/tmp/benchmark/*-versions-*.html"
      scroll="6:0 7:900 6:1800"
      page_height=6000
      docker=yes
      setup=setup_jdbc_postgresql_sink
      ;;
    *)
      echo "❌ unknown session $1 (known: ${ALL_SESSIONS[*]})"
      exit 1
      ;;
  esac
}

setup_jdbc_postgresql_sink() {
  playground run -f connect/connect-jdbc-postgresql-sink/postgres-sink.sh > /tmp/kdp-session-setup.log 2>&1
}

# the JDBC PostgreSQL sink example, and the transform chain of a "customer": a silent no-op step and a failing one
setup_smt_test() {
  setup_jdbc_postgresql_sink
  cat > /tmp/transforms.json << 'EOF'
{
  "value.converter": "io.confluent.connect.avro.AvroConverter",
  "value.converter.schema.registry.url": "http://schema-registry:8081",
  "transforms": "rename,addSource,route,createdAt,castProduct",
  "transforms.rename.type": "org.apache.kafka.connect.transforms.ReplaceField$Value",
  "transforms.rename.renames": "product:product_name",
  "transforms.addSource.type": "org.apache.kafka.connect.transforms.InsertField$Value",
  "transforms.addSource.static.field": "source",
  "transforms.addSource.static.value": "web",
  "transforms.route.type": "org.apache.kafka.connect.transforms.RegexRouter",
  "transforms.route.regex": "(.*)",
  "transforms.route.replacement": "$1_v2",
  "transforms.createdAt.type": "org.apache.kafka.connect.transforms.TimestampConverter$Value",
  "transforms.createdAt.field": "created_at",
  "transforms.createdAt.target.type": "string",
  "transforms.createdAt.format": "yyyy-MM-dd",
  "transforms.castProduct.type": "org.apache.kafka.connect.transforms.Cast$Value",
  "transforms.castProduct.spec": "product_name:int32"
}
EOF
}

# the JDBC PostgreSQL sink example (a broker and a schema registry), and the one JSON record "sent by a customer"
setup_topic_produce() {
  setup_jdbc_postgresql_sink
  echo '{"order_id": 1, "customer": "acme", "amount": 9.99, "paid": true}' > /tmp/payment.json
}

# the first part of other/reprocess-dlq-messages-with-sink-connector/replay-dlq-messages-with-playground.sh: 10 avro
# records, schema-registry killed, a FileStream sink with errors.tolerance=all sends them to the dlq topic
setup_dlq() {
  (
    cd other/reprocess-dlq-messages-with-sink-connector
    playground start-environment --environment plaintext --docker-compose-override-file "$PWD/docker-compose.plaintext.yml" > /tmp/kdp-session-setup.log 2>&1
    playground topic produce -t avro-topic --nb-messages 10 < ../../scripts/cli/predefined-schemas/avro/lead.avsc >> /tmp/kdp-session-setup.log 2>&1
    playground container kill --container schema-registry >> /tmp/kdp-session-setup.log 2>&1
    playground connector create-or-update --connector filestream-sink --wait >> /tmp/kdp-session-setup.log 2>&1 << 'EOF'
{
  "tasks.max": "1",
  "connector.class": "org.apache.kafka.connect.file.FileStreamSinkConnector",
  "topics": "avro-topic",
  "file": "/tmp/output.json",
  "errors.tolerance": "all",
  "errors.deadletterqueue.topic.name": "dlq",
  "errors.deadletterqueue.topic.replication.factor": "1",
  "errors.deadletterqueue.context.headers.enable": "true",
  "errors.log.enable": "true",
  "errors.log.include.messages": "true"
}
EOF
    playground topic wait-for-records --topic dlq --min-expected-messages 10 --max-wait 120 >> /tmp/kdp-session-setup.log 2>&1
  )
}

work_dir=/tmp/kdp-session-video
rm -rf "$work_dir"
export VHS_BIN_DIR="$work_dir/bin"
mkdir -p "$VHS_BIN_DIR" "$work_dir/home"
trap 'rm -rf "$work_dir"' EXIT
for cmd in open xdg-open
do
  printf '#!/bin/sh\nexit 0\n' > "$VHS_BIN_DIR/$cmd"
done
printf '#!/bin/sh\necho playground\n' > "$VHS_BIN_DIR/whoami"
chmod +x "$VHS_BIN_DIR"/*

sessions=("$@")
[ ${#sessions[@]} -eq 0 ] && sessions=("${ALL_SESSIONS[@]}")

mkdir -p docs/videos docs/images/sessions
for session in "${sessions[@]}"
do
  echo "🎬 $session"
  session_settings "$session"
  terminal="docs/videos/session-$session-terminal.mp4"

  # a report of a previous run must not be taken for the one of this run
  if [ -n "$report" ]
  then
    rm -rf "$(dirname "$report")"
  fi
  if [ -n "$setup" ]
  then
    echo "   ⏳ off camera: $setup (log in /tmp/kdp-session-setup.log)"
    (cd "$KDP_DIR" && PATH="$KDP_DIR/scripts/cli:$PATH" && $setup) || { echo "❌ $setup failed, see /tmp/kdp-session-setup.log"; exit 1; }
  fi

  vhs_home="$work_dir/home"
  [ -n "$docker" ] && vhs_home="$HOME"
  vhs_env=(env -i HOME="$vhs_home" USER="$USER" SHELL=/bin/bash LANG="${LANG:-en_US.UTF-8}" TERM=xterm-256color
    PATH="$KDP_DIR/scripts/cli:$PATH" KDP_DIR="$KDP_DIR" VHS_BIN_DIR="$VHS_BIN_DIR")
  # the first start of ttyd sometimes fails (net::ERR_CONNECTION_REFUSED): retry once
  "${vhs_env[@]}" vhs "tapes/session-$session.tape" > /dev/null || "${vhs_env[@]}" vhs "tapes/session-$session.tape" > /dev/null

  # poster: the end of the terminal part, where the comments sum up the session
  terminal_duration=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$terminal")
  poster_at=$(echo "$terminal_duration - 6" | bc)

  if [ -z "$report" ]
  then
    mv "$terminal" "docs/videos/session-$session.mp4"
  else
    report_file=$(ls -t $report 2> /dev/null | head -1)
    if [ -z "$report_file" ]
    then
      echo "❌ the tape did not write $report"
      exit 1
    fi
    if grep -qE "/Users/[a-z]|/home/[a-z]|/private/" "$report_file"
    then
      echo "❌ $report_file contains a local path, not publishing it"
      exit 1
    fi
    "$CHROME" --headless=new --disable-gpu --hide-scrollbars --window-size=1400,$page_height --virtual-time-budget=4000 \
      --screenshot="$work_dir/report.png" "file://$report_file" > /dev/null 2>&1

    # y position over time: hold, then 3 s of scrolling to the next step
    expr="" t=0 prev_y="" close=""
    for step in $scroll
    do
      hold=${step%%:*} y=${step##*:}
      if [ -n "$prev_y" ]
      then
        expr+="if(lt(t,$((t + 3))),$prev_y+(t-$t)/3*($y-$prev_y),"
        close+=")"
        t=$((t + 3))
      fi
      expr+="if(lt(t,$((t + hold))),$y,"
      close+=")"
      t=$((t + hold))
      prev_y=$y
    done
    expr+="$prev_y$close"
    ffmpeg -hide_banner -loglevel error -y -loop 1 -framerate 25 -i "$work_dir/report.png" -t "$t" \
      -vf "crop=1400:820:0:'$expr',format=yuv420p" -c:v libx264 -r 25 "$work_dir/report.mp4"

    ffmpeg -hide_banner -loglevel error -y -i "$terminal" -i "$work_dir/report.mp4" \
      -filter_complex "[0:v]fps=25,format=yuv420p[a];[1:v]fps=25,format=yuv420p[b];[a][b]concat=n=2:v=1[v]" \
      -map "[v]" -c:v libx264 -movflags +faststart "docs/videos/session-$session.mp4"
    rm -f "$terminal"
  fi
  ffmpeg -hide_banner -loglevel error -y -ss "$poster_at" -i "docs/videos/session-$session.mp4" -frames:v 1 "docs/images/sessions/$session.png"
done

if [[ " ${sessions[*]} " =~ " "(dlq|smt-test|topic-produce|benchmark)" " ]]
then
  echo "🛑 stopping the example"
  (cd "$KDP_DIR" && PATH="$KDP_DIR/scripts/cli:$PATH" playground stop > /dev/null 2>&1) || true
fi
ls -la docs/videos/session-*.mp4
