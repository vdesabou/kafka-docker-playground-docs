#!/bin/bash
# Regenerates the HTML reports and screenshots of docs/reports.md from the samples shipped with
# kafka-docker-playground (playground analyze <cmd> --sample <name>, playground ccloud-costs-history --sample <name>,
# playground cloud-resources aws costs-history --sample <name>).
#
# usage: scripts/generate-reports-gallery.sh [path of the kafka-docker-playground clone]
#
# The connector diagnose, diff, dead letter queue, CI failure, benchmark and SMT test reports need a real run, they are
# not regenerated: pass them with
#   DIAGNOSE_REPORT=/tmp/playground-diagnose/<run>.html DLQ_REPORT=/tmp/playground-dlq-inspect/<run>.html
#   DIFF_REPORT=/tmp/playground-connector-diff/<run>.html CI_REPORT=/tmp/playground-ci-result/<run>.html
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
  "logs|logs --sample support_bundle --include-warnings"
  "heap-dump|heap-dump --sample leak_growth"
  "jscissors|jscissors --sample filestream_sink_bad_json"
)

cd "$KDP"
for report in "${reports[@]}"
do
  name="${report%%|*}"
  echo "📊 playground analyze ${report#*|}"
  # shellcheck disable=SC2086
  "$PLAYGROUND" analyze ${report#*|} --output-dir "$work/$name" < /dev/null > "$work/$name.log" 2>&1 || { cat "$work/$name.log"; exit 1; }
  # the report of the playground, at the top of the output folder: not the pages of Eclipse MAT in its subfolders
  # (heap-dump: */index.html, */toc.html...)
  cp "$(find "$work/$name" -maxdepth 1 -name "*.html" ! -name index.html | head -1)" "$DOCS/reports/$name.html"
done

# cloud costs: from the dummy billing data of tools/cloud-costs/samples, no Confluent Cloud call
echo "📊 playground ccloud-costs-history --sample ccloud_dummy"
"$PLAYGROUND" ccloud-costs-history --sample ccloud_dummy --no-open --output-dir "$work/cloud-costs" < /dev/null > "$work/cloud-costs.log" 2>&1 || { cat "$work/cloud-costs.log"; exit 1; }
cp "$(find "$work/cloud-costs" -name "*.html" | head -1)" "$DOCS/reports/cloud-costs.html"

# aws costs, with the Amazon S3 details: from the dummy cost data of tools/cloud-costs/samples, no AWS call
echo "📊 playground cloud-resources aws costs-history --sample aws_dummy"
"$PLAYGROUND" cloud-resources aws costs-history --sample aws_dummy --no-open --output-dir "$work/aws-costs" < /dev/null > "$work/aws-costs.log" 2>&1 || { cat "$work/aws-costs.log"; exit 1; }
cp "$(find "$work/aws-costs" -name "*.html" | head -1)" "$DOCS/reports/aws-costs.html"

# reports of real runs: keep only the file name of the paths under a user folder (flight recorder analysis...)
strip_user_paths() {
  perl -pe 's#"/(?:Users|home|private)/[^"]*/([^"/]+)"#"$1"#g' "$1" > "$2"
}
[ -n "$DIAGNOSE_REPORT" ] && strip_user_paths "$DIAGNOSE_REPORT" "$DOCS/reports/connector-diagnose.html"
[ -n "$DLQ_REPORT" ] && strip_user_paths "$DLQ_REPORT" "$DOCS/reports/dlq.html"
[ -n "$DIFF_REPORT" ] && strip_user_paths "$DIFF_REPORT" "$DOCS/reports/connector-diff.html"
[ -n "$CI_REPORT" ] && strip_user_paths "$CI_REPORT" "$DOCS/reports/ci-result.html"
[ -n "$BENCHMARK_REPORT" ] && strip_user_paths "$BENCHMARK_REPORT" "$DOCS/reports/benchmark.html"
[ -n "$SMT_REPORT" ] && strip_user_paths "$SMT_REPORT" "$DOCS/reports/smt-test.html"

# the reports are published: no path of a user folder must leak (/tmp paths of a benchmark run are fine)
if grep -lE "/Users/|/home/|/private/" "$DOCS"/reports/*.html
then
  echo "❌ the files above contain a local path, fix them before publishing"
  exit 1
fi

# screenshots in the light theme, even on a machine in dark mode: the reports follow the system theme until their
# "Toggle theme" button is clicked, and an explicit data-theme on <html> wins (the published reports keep following it)
for html in "$DOCS"/reports/*.html
do
  name=$(basename "$html" .html)
  echo "📸 $name"
  perl -0pe 's/<html\b(?![^>]*data-theme)/<html data-theme="light"/i' "$html" > "$work/screenshot-$name.html"
  # aws costs: the gallery card is about the Amazon S3 details, lower in the page: only the header and that section
  if [ "$name" = "aws-costs" ]
  then
    perl -0pi -e 's#</head>#<style>.page>*:not(.header):not(\#s3-details){display:none}</style></head>#' "$work/screenshot-$name.html"
  fi
  "$CHROME" --headless=new --disable-gpu --hide-scrollbars --window-size=1400,900 --virtual-time-budget=4000 \
    --blink-settings=preferredColorScheme=1 --screenshot="$DOCS/images/reports/$name.png" "file://$work/screenshot-$name.html" > /dev/null 2>&1
done
echo "✅ done, preview with: docsify serve $DOCS"
