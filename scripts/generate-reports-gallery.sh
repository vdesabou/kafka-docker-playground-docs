#!/bin/bash
# Regenerates the HTML reports and screenshots of docs/reports.md from the samples shipped with
# kafka-docker-playground (playground analyze <cmd> --sample <name>, playground cloud-resources ccloud costs-history --sample <name>,
# playground cloud-resources aws costs-history --sample <name>, playground streams status --sample kafka_streams).
#
# usage: scripts/generate-reports-gallery.sh [path of the kafka-docker-playground clone]
#
# The connector diagnose, diff, dead letter queue, CI failure, benchmark, SMT test and CVE scan reports need a real run, they are
# not regenerated: pass them with
#   DIAGNOSE_REPORT=/tmp/playground-diagnose/<run>.html DLQ_REPORT=/tmp/playground-dlq-inspect/<run>.html
#   DIFF_REPORT=/tmp/playground-connector-diff/<run>.html CI_REPORT=/tmp/playground-ci-result/<run>.html
#   BENCHMARK_REPORT=/tmp/playground-benchmark/<run>.html SMT_REPORT=/tmp/playground-smt-test/<run>.html
#   CVE_REPORT=/tmp/playground-cve-scan/<run>.html (playground connector-plugin cve-scan -c confluentinc/kafka-connect-jdbc
#   --connector-tag 10.7.4 --compare-with 10.9.9)
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
  "tcp-dump|tcp-dump --sample kafka_and_network_errors"
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

# ── playground analyze logs: the examples of its deep dive (docs/deep-dive-analyze-logs.md of kafka-docker-playground) ──
# each report in its own folder, as analyze logs writes it: the report (<sample>-log-report.html), the pages of its files
# (<sample>-log-report-files/, with the shards of 🔎 Search every log line in search/), the pages of the ☸️ issues of the
# CFK bundles (<bundle>-cfk-files/) and the comparison of two bundles (cfk-bundles-comparison-*.html): their relative links
# keep working on the website. reports/<name>.html redirects to it (the address of the gallery before the folders).
# name|playground analyze logs arguments
log_reports=(
  "logs|--sample support_bundle --include-warnings"
  "logs-connect|--sample connect_task_failure"
  "logs-many-connectors|--sample connect_many_connectors"
  "logs-clients|--sample kafka_clients"
  "logs-streams|--sample kafka_streams"
  "logs-compare|--sample compare_fix"
  "cfk-bundle|--sample cfk_bundle"
  "logs-cfk-rollout|--sample cfk_rollout --sample cfk_rollout_after"
  "logs-cfk-kraft-migration|--sample cfk_kraft_migration"
)
# the folders of the file pages of the gallery before the folders
rm -rf "$DOCS"/reports/*-log-report-files
for report in "${log_reports[@]}"
do
  name="${report%%|*}"
  echo "📊 playground analyze logs ${report#*|}"
  # shellcheck disable=SC2086
  "$PLAYGROUND" analyze logs ${report#*|} --output-dir "$work/$name" < /dev/null > "$work/$name.log" 2>&1 || { cat "$work/$name.log"; exit 1; }
  main=$(find "$work/$name" -maxdepth 1 -name "*-log-report.html" | head -1)
  [ -n "$main" ] || { cat "$work/$name.log"; exit 1; }
  rm -rf "$DOCS/reports/$name"
  mkdir -p "$DOCS/reports/$name"
  cp "$main" "$DOCS/reports/$name/"
  find "$work/$name" -maxdepth 1 -name "cfk-bundles-comparison-*.html" -exec cp {} "$DOCS/reports/$name/" \;
  for files in "$work/$name"/*-log-report-files "$work/$name"/*-cfk-files
  do
    [ -d "$files" ] || continue
    # the pages (not the copies of the files written there for the editor) and the search shards
    mkdir -p "$DOCS/reports/$name/$(basename "$files")"
    cp "$files"/*.html "$DOCS/reports/$name/$(basename "$files")/" 2> /dev/null || true
    [ -d "$files/search" ] && cp -R "$files/search" "$DOCS/reports/$name/$(basename "$files")/"
  done
  target="$name/$(basename "$main")"
  printf '<!DOCTYPE html><html><head><meta charset="utf-8"><meta http-equiv="refresh" content="0; url=%s"><title>%s</title></head><body><a href="%s">%s</a></body></html>\n' \
    "$target" "$name" "$target" "$target" > "$DOCS/reports/$name.html"
done

# cloud costs: from the dummy billing data of tools/cloud-costs/samples, no Confluent Cloud call
echo "📊 playground cloud-resources ccloud costs-history --sample ccloud_dummy"
"$PLAYGROUND" cloud-resources ccloud costs-history --sample ccloud_dummy --no-open --output-dir "$work/cloud-costs" < /dev/null > "$work/cloud-costs.log" 2>&1 || { cat "$work/cloud-costs.log"; exit 1; }
cp "$(find "$work/cloud-costs" -name "*.html" | head -1)" "$DOCS/reports/cloud-costs.html"

# aws costs, with the Amazon S3 details: from the dummy cost data of tools/cloud-costs/samples, no AWS call
echo "📊 playground cloud-resources aws costs-history --sample aws_dummy"
"$PLAYGROUND" cloud-resources aws costs-history --sample aws_dummy --no-open --output-dir "$work/aws-costs" < /dev/null > "$work/aws-costs.log" 2>&1 || { cat "$work/aws-costs.log"; exit 1; }
cp "$(find "$work/aws-costs" -name "*.html" | head -1)" "$DOCS/reports/aws-costs.html"

# kafka streams: playground streams status on the logs of tools/log-analyzer/samples/kafka-streams, no running example. It
# exits 1 (an instance of the sample is in ERROR): the report is still written
echo "📊 playground streams status --sample kafka_streams --html"
"$PLAYGROUND" streams status --sample kafka_streams --html --no-open --output-dir "$work/kafka-streams" < /dev/null > "$work/kafka-streams.log" 2>&1 || true
[ -n "$(find "$work/kafka-streams" -name "*.html" 2>/dev/null)" ] || { cat "$work/kafka-streams.log"; exit 1; }
cp "$(find "$work/kafka-streams" -name "*.html" | head -1)" "$DOCS/reports/kafka-streams.html"

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
[ -n "$CVE_REPORT" ] && strip_user_paths "$CVE_REPORT" "$DOCS/reports/cve-scan.html"

# the ✏️ links that open a file of the report in the local editor (vscode://file/<temporary folder of the run>/...):
# useless on the website, and they hold a local path
find "$DOCS/reports" -name "*.html" -exec perl -0pi -e 's#<a\b[^>]*\bhref=["\x27]vscode://[^>]*>.*?</a>##gs' {} +
# the file pages of analyze logs: their ✏️ button (data-url='vscode://…'), and the folder of the kafka-docker-playground
# clone in the paths of the samples (…/tools/log-analyzer/samples/connect.log → tools/log-analyzer/samples/connect.log)
find "$DOCS/reports" -path "*-files/*.html" -exec perl -0pi -e 's#<a\b[^>]*\bdata-url=["\x27]vscode://[^>]*>.*?</a>##gs' {} +
grep -rlF "$KDP/" "$DOCS/reports" | while read -r f; do perl -pi -e "s#\Q$KDP/\E##g" "$f"; done

# the reports are published: no path of a user folder must leak (/tmp paths of a benchmark run are fine)
if grep -rlE "/Users/|/home/|/private/|vscode://" "$DOCS/reports"
then
  echo "❌ the files above contain a local path, fix them before publishing"
  exit 1
fi

# screenshots in the light theme, even on a machine in dark mode: the reports follow the system theme until their
# "Toggle theme" button is clicked, and an explicit data-theme on <html> wins (the published reports keep following it).
# $1: name of the png, $2: page (under reports/), $3: URL fragment, $4: section to show (a CSS selector, or ~ and a part of
# its title: what is above it is hidden), $5: JavaScript run before (a click, a search, a dialog opened), $6: CSS added.
# The copy is written next to the page: its relative links (file pages, search shards) load as on the website
shoot() {
  local png="$1" page="$DOCS/reports/$2" fragment="$3" target="$4" action="$5" css="$6"
  local copy
  copy="$(dirname "$page")/.screenshot-$(basename "$page")"
  echo "📸 $png"
  TARGET="$target" ACTION="$action" CSS="$css" python3 - "$page" "$copy" << 'PY'
import json, os, re, sys
src, dst = sys.argv[1], sys.argv[2]
html = open(src, encoding="utf-8").read()
html = re.sub(r"<html\b(?![^>]*data-theme)", '<html data-theme="light"', html, count=1, flags=re.I)
target, action, css = os.environ["TARGET"], os.environ["ACTION"], os.environ["CSS"]
inject = ""
if css:
    inject += "<style>" + css + "</style>"
if target or action:
    # the side panel of the sections and the floating buttons out of a close-up
    inject += ("<style>.side-nav,.side-nav-show,.to-top,.share-float{display:none!important}body.side-nav-on{padding-left:0!important}</style>"
               "<script>window.addEventListener('load',function(){setTimeout(function(){try{" + action + "}catch(e){console.error(e)}"
               "setTimeout(function(){var s=" + json.dumps(target) + ",t=null;"
               "if(s.charAt(0)==='~'){var h=[].find.call(document.querySelectorAll('h2,h3'),function(x){return x.textContent.indexOf(s.slice(1))>=0});"
               "t=h?(h.closest('.table-card,.chart-card,.findings')||h):null}else if(s){t=document.querySelector(s)}"
               "if(t){for(var n=t;n&&n!==document.body;n=n.parentElement){for(var p=n.previousElementSibling;p;p=p.previousElementSibling){"
               "if(!/^(SCRIPT|STYLE|DIALOG)$/.test(p.tagName))p.style.display='none'}}window.scrollTo(0,0)}},700)},500)});</script>")
if inject:
    i = html.lower().rfind("</body>")
    html = html[:i] + inject + html[i:] if i >= 0 else html + inject
open(dst, "w", encoding="utf-8").write(html)
PY
  "$CHROME" --headless=new --disable-gpu --hide-scrollbars --window-size=1400,900 --virtual-time-budget=8000 \
    --allow-file-access-from-files --blink-settings=preferredColorScheme=1 --screenshot="$DOCS/images/reports/$png.png" \
    "file://$copy$fragment" > /dev/null 2>&1
  rm -f "$copy"
}

for html in "$DOCS"/reports/*.html
do
  name=$(basename "$html" .html)
  # the address of an analyze logs report before the folders: its report, in its folder
  if grep -q 'http-equiv="refresh"' "$html"
  then
    page=$(find "$DOCS/reports/$name" -maxdepth 1 -name "*-log-report.html" | head -1)
    shoot "$name" "$name/$(basename "$page")" "" "" "" ""
    continue
  fi
  css=""
  # aws costs: the gallery card is about the Amazon S3 details, lower in the page: only the header and that section
  [ "$name" = "aws-costs" ] && css='.page>*:not(.header):not(#s3-details){display:none}'
  # kafka streams: the advice under each finding pushes the timeline of the states out of the screenshot
  [ "$name" = "kafka-streams" ] && css='.rec-details{display:none}'
  shoot "$name" "$name.html" "" "" "" "$css"
done

# 📸 the tour of the analyze logs report (docs/deep-dive-analyze-logs.md): one section of an example per screenshot
logs_page() { ( cd "$DOCS/reports" && find "$1" -maxdepth 1 -name "${2:-*-log-report.html}" | sort | head -1 ); }
file_page() { ( cd "$DOCS/reports" && find "$1" -path "*-log-report-files/*.html" | sort | head -1 ); }
shoot logs-tour-story "$(logs_page logs)" "" ".story" "" ""
shoot logs-tour-findings "$(logs_page logs)" "" ".findings" "" ""
shoot logs-tour-filters "$(logs_page logs)" "" ".lvl-filter" \
  "var q=document.querySelector('.pp-quick');q.value=q.querySelector('option[value^=last]').value;q.dispatchEvent(new Event('change'))" ""
shoot logs-tour-timeline "$(logs_page logs)" "" "#incident-timeline" "" ""
shoot logs-tour-occurrences "$(logs_page logs)" "" "~📈 Occurrences over time" "" ""
shoot logs-tour-root-causes "$(logs_page logs)" "" "#all-root-causes" "" ""
shoot logs-tour-search "$(logs_page logs)" "#pg:lq=level%3AINFO" "#log-search" "" ""
# without its opening animation: the screenshot is taken while it fades in
shoot logs-tour-share "$(logs_page logs)" "" "" "document.querySelector('.share-dlg').showModal()" ".share-dlg[open]{animation:none!important}"
shoot logs-tour-connectors "$(logs_page logs-many-connectors)" "" "#connectors" "" ""
shoot logs-tour-rebalances "$(logs_page logs-many-connectors)" "" "~🔄 Restarts and rebalances" \
  "var r=[].find.call(document.querySelectorAll('tr.lc-row'),function(x){return x.dataset.times});if(r)r.click()" ""
shoot logs-tour-config "$(logs_page logs-many-connectors)" "" "~⚙️ Configuration" "" ""
shoot logs-tour-file-page "$(file_page logs-connect)" "" "" "document.getElementById('lv-next').click()" ""
shoot logs-tour-compare "$(logs_page logs-compare)" "" "~🔁 Comparison" "" ""
shoot logs-tour-streams "$(logs_page logs-streams)" "" "~🌊 Kafka Streams" "" ""
shoot logs-tour-cfk "$(logs_page cfk-bundle)" "" ".cfk-card" "" ""
shoot logs-tour-cfk-compare "$(logs_page logs-cfk-rollout 'cfk-bundles-comparison-*.html')" "" "" "" ""
echo "✅ done, preview with: docsify serve $DOCS"
