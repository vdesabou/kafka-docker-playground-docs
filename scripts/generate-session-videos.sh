#!/bin/bash
# Records the "Bite size sessions" videos (docs/videos/session-<name>.mp4): a tape narrated with comments typed in
# the terminal (tapes/session-<name>.tape), followed by a scroll through the HTML report that the tape generated.
#
# usage: KDP_DIR=/Users/Shared/kafka-docker-playground scripts/generate-session-videos.sh [session name...]
#        (default: all the sessions)
#
# requirements: vhs, ffmpeg, Google Chrome (headless screenshots of the HTML report), docker for the sessions that
# run an example (cfk-bundle, remote-debugging, dlq, smt-test, topic-produce, topic-consume, benchmark, connect-migration)
# connect-migration also needs Confluent Cloud (the [ccloud] details in the playground.ini of KDP_DIR, from a ccloud
# example run once in that clone, and the Cloud API key of the secrets store) and AWS credentials (~/.aws): it creates a
# fully managed connector, deleted after the recording
# Same isolation as scripts/generate-cli-videos.sh (neutral clone path, env -i, empty HOME except for the docker
# sessions, no-op open), but it does not change your playground config.
#
# ⚠️ the remote-debugging, dlq, smt-test, topic-produce, topic-consume, benchmark and connect-migration sessions start an example off camera: it stops the environment
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
#   teardown    function run after the recording, off camera, in KDP_DIR, also when the recording fails (resources
#               that cost money)
#   stills      images shown after the terminal part instead of a report (screenshots of an IDE...):
#               "<image>:<seconds>" items, each fitted to the frame on the background color of the terminal
ALL_SESSIONS=(thread-dump gc-logs flight-recorder oracle-xstream-report cfk-bundle sourcecode remote-debugging dlq smt-test topic-produce topic-consume benchmark connect-migration)
session_settings() {
  report="" scroll="" page_height=4100 docker="" setup="" teardown="" stills=""
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
    remote-debugging)
      docker=yes
      setup=setup_remote_debugging
      stills="docs/images/remote_debugging3.jpg:6 docs/images/remote_debugging4.jpg:5 docs/images/remote_debugging7.jpg:8"
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
    topic-consume)
      docker=yes
      setup=setup_topic_consume
      ;;
    benchmark)
      report="/tmp/benchmark/*-versions-*.html"
      scroll="6:0 7:900 6:1800"
      page_height=6000
      docker=yes
      setup=setup_jdbc_postgresql_sink
      ;;
    connect-migration)
      docker=yes
      setup=setup_connect_migration
      teardown=teardown_connect_migration
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
# the topics are created off camera: in the vhs terminal, the screen sometimes stops updating while 'topic produce'
# creates a topic
# a plaintext environment, the topic orders (3 partitions, 300 avro records, keys order-1 to order-300, the schema in
# /tmp/order.avsc for the records produced on camera) and the topic payments: 3 avro records, then 2 records that are not
# avro (a misconfigured producer)
setup_topic_consume() {
  playground start-environment --environment plaintext > /tmp/kdp-session-setup.log 2>&1
  echo '{"type": "record", "name": "Order", "fields": [{"name": "order_id", "type": "int"}, {"name": "product", "type": "string"}, {"name": "quantity", "type": "int"}]}' > /tmp/order.avsc
  playground topic produce -t orders --nb-partitions 3 --nb-messages 300 --key 'order-%g' < /tmp/order.avsc >> /tmp/kdp-session-setup.log 2>&1
  playground topic produce -t payments --nb-messages 3 < /tmp/order.avsc >> /tmp/kdp-session-setup.log 2>&1
  playground topic produce -t payments --nb-messages 2 --value-format raw --value 'not avro %g' >> /tmp/kdp-session-setup.log 2>&1
}

setup_topic_produce() {
  setup_jdbc_postgresql_sink
  echo '{"order_id": 1, "customer": "acme", "amount": 9.99, "paid": true}' > /tmp/payment.json
  for topic in leads payments trades big ticks
  do
    playground topic create --topic $topic >> /tmp/kdp-session-setup.log 2>&1
  done
}

# the JDBC PostgreSQL sink example, the avro schema of its orders topic for the record produced on camera, and no
# checkout of the connector code yet (the tape clones it)
setup_remote_debugging() {
  setup_jdbc_postgresql_sink
  sed -n "/topic produce -t orders --nb-messages 1 << 'EOF'/,/^EOF/p" connect/connect-jdbc-postgresql-sink/postgres-sink.sh | sed '1d;$d' > /tmp/orders.avsc
  rm -rf /tmp/connector-plugin-sourcecode/kafka-connect-jdbc-*
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

# the first half of ccloud/connect-migration-utility/cloudwatch-metrics-sink.sh (up to the discovery): a local worker
# connected to Confluent Cloud with the self-managed AWS CloudWatch Metrics sink, renamed OnPremCloudWatchMetricsSink_playground
# so that no login shows (USER itself cannot change: the connector install runs 'id -u $USER'). The full example would
# already migrate the connector, and it ends with a confirmation prompt.
# The tape runs under env -i: it gets what it needs from a private file it sources off camera (removed by the teardown): the
# [ccloud] details, exported so that discovery and migrate do not ask "Use previously used ccloud cluster", and the AWS
# keys for migrate --sensitive-property
connect_migration_env=/tmp/kdp-session-connect-migration.env
setup_connect_migration() {
  if [ -z "$(playground state get ccloud.CLUSTER_NAME 2> /dev/null)" ]
  then
    echo "❌ no [ccloud] details in $KDP_DIR/playground.ini: run a ccloud example once in that clone" | tee /tmp/kdp-session-setup.log
    return 1
  fi
  local example=ccloud/connect-migration-utility
  sed -e '/^playground connector connect-migration-utility discovery/,$d' \
    -e 's/^connector_name="OnPremCloudWatchMetricsSink_\$USER"/connector_name="OnPremCloudWatchMetricsSink_playground"/' \
    $example/cloudwatch-metrics-sink.sh > $example/session-setup.sh
  grep -q '^connector_name="OnPremCloudWatchMetricsSink_playground"' $example/session-setup.sh || { echo "❌ connector_name not found in $example/cloudwatch-metrics-sink.sh" | tee /tmp/kdp-session-setup.log; return 1; }
  chmod +x $example/session-setup.sh
  rm -rf connect-migration-utility-discovery-output
  (umask 077 && : > "$connect_migration_env")
  local name
  for name in ENVIRONMENT CLUSTER_NAME CLUSTER_CLOUD CLUSTER_REGION CLUSTER_CREDS SCHEMA_REGISTRY_CREDS
  do
    printf 'export %s=%q\n' "$name" "$(playground state get ccloud.$name)" >> "$connect_migration_env"
  done
  printf 'export AWS_ACCESS_KEY_ID=%q\n' "${AWS_ACCESS_KEY_ID:-$(aws configure get aws_access_key_id)}" >> "$connect_migration_env"
  printf 'export AWS_SECRET_ACCESS_KEY=%q\n' "${AWS_SECRET_ACCESS_KEY:-$(aws configure get aws_secret_access_key)}" >> "$connect_migration_env"
  # the exit code of 'playground run' is not enough: it can be 1 after a successful ccloud example (end of run summary)
  playground run -f "$PWD/$example/session-setup.sh" < /dev/null > /tmp/kdp-session-setup.log 2>&1
  grep -q "RESULT: SUCCESS" /tmp/kdp-session-setup.log
}

# the fully managed connector is billed: delete it, then the local environment, and everything that holds a secret
# (after migrate, the discovered configs hold the AWS keys)
teardown_connect_migration() {
  local ret=0
  (
    # the generator runs under set -e: nothing (a missing file, a failing switch) may end the teardown before the delete
    set +e
    source "$connect_migration_env" 2> /dev/null
    playground switch-ccloud
    playground connector delete --connector OnPremCloudWatchMetricsSink_playground
  ) < /dev/null > /tmp/kdp-session-teardown.log 2>&1 || ret=$?
  # nothing to delete when the recording stopped before migrate
  grep -q "resource not found" /tmp/kdp-session-teardown.log && ret=0
  cat /tmp/kdp-session-teardown.log >> /tmp/kdp-session-setup.log
  rm -f /tmp/kdp-session-teardown.log
  playground container kill-all >> /tmp/kdp-session-setup.log 2>&1
  rm -rf connect-migration-utility-discovery-output ccloud/connect-migration-utility/session-setup.sh "$connect_migration_env" \
    /tmp/discovery.log /tmp/migrate.log
  # the setup log holds the connector config printed by the example, AWS keys included: kept only to debug a failure
  [ $ret -eq 0 ] && rm -f /tmp/kdp-session-setup.log
  return $ret
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
    if ! (cd "$KDP_DIR" && PATH="$KDP_DIR/scripts/cli:$PATH" && $setup)
    then
      echo "❌ $setup failed, see /tmp/kdp-session-setup.log"
      if [ -n "$teardown" ]
      then
        echo "   🧹 off camera: $teardown"
        (cd "$KDP_DIR" && PATH="$KDP_DIR/scripts/cli:$PATH" && $teardown) || echo "⚠️ $teardown failed: clean up by hand"
      fi
      exit 1
    fi
  fi

  vhs_home="$work_dir/home"
  [ -n "$docker" ] && vhs_home="$HOME"
  vhs_env=(env -i HOME="$vhs_home" USER="$USER" SHELL=/bin/bash LANG="${LANG:-en_US.UTF-8}" TERM=xterm-256color
    PATH="$KDP_DIR/scripts/cli:$PATH" KDP_DIR="$KDP_DIR" VHS_BIN_DIR="$VHS_BIN_DIR")
  # the first start of ttyd sometimes fails (net::ERR_CONNECTION_REFUSED): retry once
  recorded=yes
  "${vhs_env[@]}" vhs "tapes/session-$session.tape" > /dev/null || "${vhs_env[@]}" vhs "tapes/session-$session.tape" > /dev/null || recorded=""
  if [ -n "$teardown" ]
  then
    echo "   🧹 off camera: $teardown (log in /tmp/kdp-session-setup.log)"
    (cd "$KDP_DIR" && PATH="$KDP_DIR/scripts/cli:$PATH" && $teardown) || echo "⚠️ $teardown failed, see /tmp/kdp-session-setup.log: clean up by hand"
  fi
  if [ -z "$recorded" ]
  then
    echo "❌ vhs failed for tapes/session-$session.tape"
    exit 1
  fi

  # poster: the end of the terminal part, where the comments sum up the session
  terminal_duration=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$terminal")
  poster_at=$(echo "$terminal_duration - 6" | bc)

  if [ -z "$report" ] && [ -z "$stills" ]
  then
    mv "$terminal" "docs/videos/session-$session.mp4"
  elif [ -n "$stills" ]
  then
    inputs=(-i "$terminal") filter="[0:v]fps=25,format=yuv420p,setsar=1[v0];" labels="[v0]" n=0
    for still in $stills
    do
      image=${still%%:*} hold=${still##*:}
      n=$((n + 1))
      ffmpeg -hide_banner -loglevel error -y -loop 1 -framerate 25 -i "$image" -t "$hold" \
        -vf "scale=1300:760:force_original_aspect_ratio=decrease,pad=1400:820:(ow-iw)/2:(oh-ih)/2:color=0x1e1e2e,format=yuv420p" \
        -c:v libx264 -r 25 "$work_dir/still-$n.mp4"
      inputs+=(-i "$work_dir/still-$n.mp4")
      filter+="[$n:v]fps=25,format=yuv420p,setsar=1[v$n];"
      labels+="[v$n]"
    done
    ffmpeg -hide_banner -loglevel error -y "${inputs[@]}" -filter_complex "${filter}${labels}concat=n=$((n + 1)):v=1[v]" \
      -map "[v]" -c:v libx264 -movflags +faststart "docs/videos/session-$session.mp4"
    rm -f "$terminal"
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

if [[ " ${sessions[*]} " =~ " "(remote-debugging|dlq|smt-test|topic-produce|topic-consume|benchmark|connect-migration)" " ]]
then
  echo "🛑 stopping the example"
  (cd "$KDP_DIR" && PATH="$KDP_DIR/scripts/cli:$PATH" playground stop > /dev/null 2>&1) || true
fi
ls -la docs/videos/session-*.mp4
