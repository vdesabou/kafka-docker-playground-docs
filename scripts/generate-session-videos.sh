#!/bin/bash
# Records the "Bite size sessions" videos (docs/videos/session-<name>.mp4): a tape narrated with comments typed in
# the terminal (tapes/session-<name>.tape), followed by a scroll through the HTML report that the tape generated.
#
# usage: KDP_DIR=/Users/Shared/kafka-docker-playground scripts/generate-session-videos.sh [session name...]
#        (default: all the sessions)
#
# requirements: vhs, ffmpeg, Google Chrome (headless screenshots of the HTML report)
# Same isolation as scripts/generate-cli-videos.sh (neutral clone path, env -i, empty HOME, no-op open), but it
# does not change your playground config.
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

# session name → HTML report written by its tape, and the scroll through it:
# "<seconds to hold>:<y in the 1400 px wide page>" steps, 3 s of scrolling between two steps, and the second of the
# video used as its poster (docs/images/sessions/<name>.png, shown before it plays)
ALL_SESSIONS=(thread-dump)
session_settings() {
  case "$1" in
    thread-dump)
      report="/tmp/thread-dump/jdk21-scenario-1-thread-report.html"
      scroll="4:0 7:960 6:2560"
      poster_at=104
      ;;
    *)
      echo "❌ unknown session $1 (known: ${ALL_SESSIONS[*]})"
      exit 1
      ;;
  esac
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

mkdir -p docs/videos
for session in "${sessions[@]}"
do
  echo "🎬 $session"
  session_settings "$session"
  terminal="docs/videos/session-$session-terminal.mp4"
  vhs_env=(env -i HOME="$work_dir/home" USER="$USER" SHELL=/bin/bash LANG="${LANG:-en_US.UTF-8}" TERM=xterm-256color
    PATH="$KDP_DIR/scripts/cli:$PATH" KDP_DIR="$KDP_DIR" VHS_BIN_DIR="$VHS_BIN_DIR")
  # the first start of ttyd sometimes fails (net::ERR_CONNECTION_REFUSED): retry once
  "${vhs_env[@]}" vhs "tapes/session-$session.tape" > /dev/null || "${vhs_env[@]}" vhs "tapes/session-$session.tape" > /dev/null

  if [ ! -f "$report" ]
  then
    echo "❌ the tape did not write $report"
    exit 1
  fi
  if grep -qE "/Users/[a-z]|/home/[a-z]|/private/" "$report"
  then
    echo "❌ $report contains a local path, not publishing it"
    exit 1
  fi
  "$CHROME" --headless=new --disable-gpu --hide-scrollbars --window-size=1400,4100 --virtual-time-budget=4000 \
    --screenshot="$work_dir/report.png" "file://$report" > /dev/null 2>&1

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
  mkdir -p docs/images/sessions
  ffmpeg -hide_banner -loglevel error -y -ss "$poster_at" -i "docs/videos/session-$session.mp4" -frames:v 1 "docs/images/sessions/$session.png"
done
ls -la docs/videos/session-*.mp4
