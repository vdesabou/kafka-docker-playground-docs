#!/bin/bash
# Records the "See it in action" clips (docs/videos/*.mp4 and *.gif) from the tapes in tapes/, with VHS.
#
# usage: scripts/generate-cli-videos.sh [tape name...]      (default: all the tapes)
#
# requirements: vhs (brew install vhs, it pulls ttyd and ffmpeg), docker for the benchmark, diagnose and claude-code tapes,
# claude (logged in) for the claude-code tape
#
# The clips show the paths of the clone: record from a clone at a neutral path, without the private
# reproduction-models submodule (find-example would list its models), for example:
#   git -C ../kafka-docker-playground worktree add --detach /Users/Shared/kafka-docker-playground master
#   KDP_DIR=/Users/Shared/kafka-docker-playground scripts/generate-cli-videos.sh
#
# ⚠️ the benchmark, diagnose and claude-code tapes run an example: it stops the environment that is running in that clone
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd "$DIR/.."

export KDP_DIR="${KDP_DIR:-/Users/Shared/kafka-docker-playground}"
if [ ! -x "$KDP_DIR/scripts/cli/playground" ]
then
  echo "❌ no kafka-docker-playground clone in KDP_DIR=$KDP_DIR"
  exit 1
fi
if [[ "$KDP_DIR" == "$HOME"* ]]
then
  echo "❌ KDP_DIR=$KDP_DIR is under your home folder, which would show in the clips: use a neutral path"
  exit 1
fi
if [ -n "$(ls -A "$KDP_DIR/reproduction-models" 2> /dev/null)" ]
then
  echo "❌ $KDP_DIR/reproduction-models is not empty: playground find-example would show the private reproduction models"
  exit 1
fi

# no-op 'open' / 'xdg-open' so that the HTML reports are not opened in a browser, neutral author for repro bootstrap
# fixed and neutral paths: they show in some clips (secrets store, empty HOME)
work_dir=/tmp/kdp-video
rm -rf "$work_dir"
export VHS_BIN_DIR="$work_dir/bin"
mkdir -p "$VHS_BIN_DIR"
trap 'rm -rf "$work_dir"' EXIT
for cmd in open xdg-open
do
  printf '#!/bin/sh\nexit 0\n' > "$VHS_BIN_DIR/$cmd"
done
printf '#!/bin/sh\necho playground\n' > "$VHS_BIN_DIR/whoami"
chmod +x "$VHS_BIN_DIR"/*

# first on the PATH: the playground commands called by playground itself must be the ones of that clone too
export PATH="$KDP_DIR/scripts/cli:$PATH"
playground config set clipboard false
playground config set check-and-update-repo-version false

# an empty secrets store, with the file backend: secrets check / set must neither show nor touch your real secrets
export PLAYGROUND_SECRETS_DIR="$work_dir/secrets"
export PLAYGROUND_SECRETS_BACKEND=file
mkdir -p "$PLAYGROUND_SECRETS_DIR"

tapes=("$@")
if [ ${#tapes[@]} -eq 0 ]
then
  tapes=(find-example run-menu ccloud-run-menu secrets repro-bootstrap repro-pipeline analyze benchmark diagnose claude-code)
fi

mkdir -p docs/videos
for tape in "${tapes[@]}"
do
  echo "🎬 $tape"
  # the first start of ttyd sometimes fails (net::ERR_CONNECTION_REFUSED): retry once
  # an empty HOME (no ~/.aws/credentials... nor your home path in a clip), except for the tapes that need docker or claude
  vhs_home="$work_dir/home"
  if [[ "$tape" =~ ^(benchmark|diagnose|claude-code)$ ]]
  then
    vhs_home="$HOME"
  fi
  mkdir -p "$work_dir/home"
  # minimal environment: no credential exported in your shell (AWS_*, ZENDESK_*...) can show in a clip
  vhs_env=(env -i HOME="$vhs_home" USER="$USER" SHELL=/bin/bash LANG="${LANG:-en_US.UTF-8}" TERM=xterm-256color PATH="$PATH"
    KDP_DIR="$KDP_DIR" VHS_BIN_DIR="$VHS_BIN_DIR" PLAYGROUND_SECRETS_DIR="$PLAYGROUND_SECRETS_DIR" PLAYGROUND_SECRETS_BACKEND=file)
  "${vhs_env[@]}" vhs "tapes/$tape.tape" > /dev/null || "${vhs_env[@]}" vhs "tapes/$tape.tape" > /dev/null
done

if [[ " ${tapes[*]} " =~ " "(benchmark|diagnose|claude-code)" " ]]
then
  echo "🛑 stopping the example"
  playground stop > /dev/null 2>&1 || true
fi
ls -la docs/videos
