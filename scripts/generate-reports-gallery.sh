#!/bin/bash
# Regenerates the HTML reports and screenshots of docs/reports.md from the samples shipped with
# kafka-docker-playground (playground analyze <cmd> --sample <name>).
#
# usage: scripts/generate-reports-gallery.sh [path of the kafka-docker-playground clone]
#
# The benchmark and SMT test reports need a real run, they are not regenerated: pass them with
#   BENCHMARK_REPORT=/tmp/playground-benchmark/<run>.html SMT_REPORT=/tmp/playground-smt-test/<run>.html
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
DOCS="$DIR/../docs"
KDP="$( cd "${1:-$DIR/../../kafka-docker-playground}" && pwd )"
PLAYGROUND="$KDP/scripts/cli/playground"
CHROME="${CHROME:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"
command -v google-chrome > /dev/null && CHROME=google-chrome

work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
mkdir -p "$DOCS/reports" "$DOCS/images/reports"

# name|playground analyze arguments
reports=(
  "thread-dump|thread-dump --sample deadlock_jdk21"
  "gc-logs|gc-logs --sample jdk21_g1_kafka_real"
  "flight-recorder|flight-recorder --sample jdbc_postgres_sink"
  "oracle-xstream-report|oracle-xstream-report --sample synthetic_failures"
  "cfk-bundle|cfk-bundle --sample synthetic"
  "tcp-dump|tcp-dump --sample kafka_and_network_errors"
)

cd "$KDP"
for report in "${reports[@]}"
do
  name="${report%%|*}"
  echo "📊 playground analyze ${report#*|}"
  # shellcheck disable=SC2086
  "$PLAYGROUND" analyze ${report#*|} --output-dir "$work/$name" < /dev/null > "$work/$name.log" 2>&1 || { cat "$work/$name.log"; exit 1; }
  cp "$(find "$work/$name" -name "*.html" | head -1)" "$DOCS/reports/$name.html"
done

# reports of real runs: keep only the file name of the paths under a user folder (flight recorder analysis...)
strip_user_paths() {
  perl -pe 's#"/(?:Users|home|private)/[^"]*/([^"/]+)"#"$1"#g' "$1" > "$2"
}
[ -n "$BENCHMARK_REPORT" ] && strip_user_paths "$BENCHMARK_REPORT" "$DOCS/reports/benchmark.html"
[ -n "$SMT_REPORT" ] && strip_user_paths "$SMT_REPORT" "$DOCS/reports/smt-test.html"

# the reports are published: no path of a user folder must leak (/tmp paths of a benchmark run are fine)
if grep -lE "/Users/|/home/|/private/" "$DOCS"/reports/*.html
then
  echo "❌ the files above contain a local path, fix them before publishing"
  exit 1
fi

for html in "$DOCS"/reports/*.html
do
  name=$(basename "$html" .html)
  echo "📸 $name"
  "$CHROME" --headless=new --disable-gpu --hide-scrollbars --window-size=1400,900 --virtual-time-budget=4000 \
    --screenshot="$DOCS/images/reports/$name.png" "file://$html" > /dev/null 2>&1
done
echo "✅ done, preview with: docsify serve $DOCS"
