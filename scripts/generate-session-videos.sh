#!/bin/bash
# Records the "Bite size sessions" videos (docs/videos/session-<name>.mp4): a tape narrated with comments typed in
# the terminal (tapes/session-<name>.tape), followed by a scroll through the HTML report that the tape generated.
#
# usage: KDP_DIR=/Users/Shared/kafka-docker-playground scripts/generate-session-videos.sh [session name...]
#        (default: all the sessions)
#
# requirements: vhs, ffmpeg, Google Chrome (headless screenshots of the HTML report), docker for the sessions that
# run an example or an environment (every session with docker=yes in session_settings: all but thread-dump, gc-logs,
# flight-recorder, oracle-xstream-report and sourcecode)
# connect-migration also needs Confluent Cloud (the [ccloud] details in the playground.ini of KDP_DIR, from a ccloud
# example run once in that clone, and the Cloud API key of the secrets store) and AWS credentials (~/.aws): it creates a
# fully managed connector, deleted after the recording
# Same isolation as scripts/generate-cli-videos.sh (neutral clone path, env -i, empty HOME except for the docker
# sessions, no-op open), but it does not change your playground config.
#
# ⚠️ the docker sessions start an example or an environment, off camera or on camera: it stops the environment that is
# running in that clone
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
ALL_SESSIONS=(run secured-environments repro-models versions container-lifecycle offsets-and-lag create-or-update log-levels container-logs schema topic-administration thread-dump gc-logs flight-recorder jscissors oracle-xstream-report cfk-bundle sourcecode remote-debugging dlq smt-test topic-produce topic-consume benchmark network-traffic connect-migration terraform)
session_settings() {
  report="" scroll="" page_height=4100 docker="" setup="" teardown="" stills=""
  case "$1" in
    run)
      docker=yes
      setup=setup_run
      teardown=teardown_run
      ;;
    topic-administration)
      docker=yes
      setup=setup_topic_administration
      ;;
    schema)
      docker=yes
      setup=setup_schema
      ;;
    container-logs)
      docker=yes
      setup=setup_container_logs
      ;;
    log-levels)
      docker=yes
      setup=setup_log_levels
      ;;
    create-or-update)
      docker=yes
      setup=setup_create_or_update
      ;;
    offsets-and-lag)
      docker=yes
      setup=setup_offsets_and_lag
      ;;
    container-lifecycle)
      docker=yes
      setup=setup_jdbc_postgresql_sink
      ;;
    versions)
      docker=yes
      setup=setup_versions
      ;;
    repro-models)
      docker=yes
      setup=setup_repro_models
      teardown=teardown_repro_models
      ;;
    secured-environments)
      docker=yes
      setup=setup_secured_environments
      teardown=teardown_secured_environments
      ;;
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
    jscissors)
      report="/tmp/jscissors/*/*-jscissors-report.html"
      scroll="6:0 8:650"
      docker=yes
      setup=setup_jscissors
      teardown=teardown_jscissors
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
    network-traffic)
      docker=yes
      setup=setup_network_traffic
      ;;
    connect-migration)
      docker=yes
      setup=setup_connect_migration
      teardown=teardown_connect_migration
      ;;
    terraform)
      docker=yes
      setup=setup_terraform
      teardown=teardown_terraform
      ;;
    *)
      echo "❌ unknown session $1 (known: ${ALL_SESSIONS[*]})"
      exit 1
      ;;
  esac
}

# the run history of the clone, put aside: the session shows its own runs only ('playground history', the history of
# the menu), restored by the teardown
setup_run() {
  rm -f playground-run-history.session-backup
  if [ -f playground-run-history ]
  then
    mv playground-run-history playground-run-history.session-backup
  fi
  : > playground-run-history
}
teardown_run() {
  if [ -f playground-run-history.session-backup ]
  then
    mv playground-run-history.session-backup playground-run-history
  fi
  return 0
}

# a plaintext environment and no topic orders: the tape creates it with 'topic create' (in the vhs terminal, the screen
# sometimes stops updating while 'topic produce' creates a topic)
setup_topic_administration() {
  playground start-environment --environment plaintext > /tmp/kdp-session-setup.log 2>&1
  playground topic delete -t orders >> /tmp/kdp-session-setup.log 2>&1
  rm -f /tmp/out.log
}

# a plaintext environment (fresh registry: the ids start at 1), the empty topic orders (in the vhs terminal, the screen
# sometimes stops updating while 'topic produce' creates a topic) and three versions of the Order schema of the schema
# deep dive lab: v1 (id, amount), v2-bad (+ currency without default, refused by BACKWARD), v2 (+ currency with a default)
setup_schema() {
  playground start-environment --environment plaintext > /tmp/kdp-session-setup.log 2>&1
  playground topic create -t orders >> /tmp/kdp-session-setup.log 2>&1
  cat > /tmp/order-v1.avsc << 'EOF'
{ "type": "record", "name": "Order", "namespace": "com.example",
  "fields": [ {"name": "id", "type": "int"}, {"name": "amount", "type": "double"} ] }
EOF
  cat > /tmp/order-v2-bad.avsc << 'EOF'
{ "type": "record", "name": "Order", "namespace": "com.example",
  "fields": [ {"name": "id", "type": "int"}, {"name": "amount", "type": "double"}, {"name": "currency", "type": "string"} ] }
EOF
  cat > /tmp/order-v2.avsc << 'EOF'
{ "type": "record", "name": "Order", "namespace": "com.example",
  "fields": [ {"name": "id", "type": "int"}, {"name": "amount", "type": "double"}, {"name": "currency", "type": "string", "default": "EUR"} ] }
EOF
  rm -f /tmp/out.log
}

# the FileStream sink example, and the bad-sink connector of other/deep-dive-labs/container-logs.sh: an AvroConverter on
# the plain JSON records of topic filestream, its task FAILED (Unknown magic byte!), so that the digest has an ERROR
setup_container_logs() {
  playground run -f connect/connect-filestream-sink/filestream-sink.sh > /tmp/kdp-session-setup.log 2>&1 || return 1
  playground connector create-or-update --connector bad-sink --no-wait >> /tmp/kdp-session-setup.log 2>&1 << 'EOF'
{
  "tasks.max": "1",
  "connector.class": "org.apache.kafka.connect.file.FileStreamSinkConnector",
  "topics": "filestream",
  "file": "/tmp/bad.json",
  "key.converter": "org.apache.kafka.connect.storage.StringConverter",
  "value.converter": "io.confluent.connect.avro.AvroConverter",
  "value.converter.schema.registry.url": "http://schema-registry:8081"
}
EOF
  playground connector wait --connector bad-sink --state FAILED --max-wait 120 >> /tmp/kdp-session-setup.log 2>&1
}

# the FileStream sink example (connector filestream-sink, topic filestream to /tmp/output.json), with the default log
# levels: a restart of connect puts back the levels a previous recording may have set
setup_log_levels() {
  playground run -f connect/connect-filestream-sink/filestream-sink.sh > /tmp/kdp-session-setup.log 2>&1
}

# in session_settings(), next to the other cases

# with the other setup functions
# the FileStream sink example (connector filestream-sink, 5 records in the topic filestream), and the config "sent by a
# customer" in the REST API format: a file in a folder that does not exist in the connect container, and the same config
# fixed (/tmp/customer-output.json). No broken-sink connector left by a previous recording
setup_create_or_update() {
  playground run -f connect/connect-filestream-sink/filestream-sink.sh > /tmp/kdp-session-setup.log 2>&1
  cat > /tmp/customer-connector.json << 'EOF'
{
  "name": "customer-sink",
  "config": {
    "tasks.max": "1",
    "connector.class": "org.apache.kafka.connect.file.FileStreamSinkConnector",
    "topics": "filestream",
    "file": "/does/not/exist/output.json",
    "key.converter": "org.apache.kafka.connect.storage.StringConverter",
    "value.converter": "org.apache.kafka.connect.json.JsonConverter",
    "value.converter.schemas.enable": "false"
  }
}
EOF
  sed 's|/does/not/exist/output.json|/tmp/customer-output.json|' /tmp/customer-connector.json > /tmp/customer-connector-fixed.json
  playground connector delete -c broken-sink >> /tmp/kdp-session-setup.log 2>&1 || true
}

# in session_settings(), next to the other cases

# with the other setup functions
# the FileStream sink example (5 records written to /tmp/output.json), its first commit (offset 5: lag 0 instead of
# "lag: -"), then the connector paused and 20 more records in the topic filestream: a lag of 20 that does not move
setup_offsets_and_lag() {
  playground run -f connect/connect-filestream-sink/filestream-sink.sh > /tmp/kdp-session-setup.log 2>&1
  playground connector show-lag --connector filestream-sink --interval 5 --max-wait 90 >> /tmp/kdp-session-setup.log 2>&1
  playground connector pause --connector filestream-sink >> /tmp/kdp-session-setup.log 2>&1
  playground topic produce -t filestream --nb-messages 20 --value '{"id": %g}' >> /tmp/kdp-session-setup.log 2>&1
}

# add container-lifecycle to ALL_SESSIONS, to the docker list of the header comment, to the "start an example off camera"
# warning, and to the regex of the final 'stopping the example' block

# in session_settings():

# no setup_container_lifecycle / teardown needed: setup_jdbc_postgresql_sink (connect/connect-jdbc-postgresql-sink/postgres-sink.sh)
# already logs to /tmp/kdp-session-setup.log. The tape leaves connect on its original definition (the last recreate
# drops the KAFKA_HEAP_OPTS override, and the JDK 17 goes away with it)

# add versions to ALL_SESSIONS, to the docker list of the header comment, to the "start an example off camera" warning,
# and to the regex of the final 'stopping the example' block

# in session_settings():

# the JDBC PostgreSQL sink example with the customer's versions (CP 8.2.0, connector 10.8.4), the avro schema of its
# topic orders in /tmp/orders.avsc for the record produced on camera, and the 10.9.9 zip of the connector from
# Confluent Hub in /tmp/engineering-build (it plays the build sent by engineering). The tape needs 10.9.9 to be the
# latest version on Confluent Hub: 'connector versions' says "is latest" after the zip, and update-version --connect-tag
# installs the latest version again (see the risks)
setup_versions() {
  local latest
  latest=$(curl -s https://api.hub.confluent.io/api/plugins/confluentinc/kafka-connect-jdbc/versions | jq -r '.[-1].version')
  if [ "$latest" != "10.9.9" ]
  then
    echo "❌ the latest JDBC connector on Confluent Hub is $latest, not 10.9.9: update tapes/session-versions.tape" | tee /tmp/kdp-session-setup.log
    return 1
  fi
  # the version list cached by 'connector versions' (a stale one would not show 10.9.9 as the latest)
  rm -f /tmp/version_confluentinc_kafka-connect-jdbc
  rm -rf /tmp/engineering-build
  mkdir -p /tmp/engineering-build
  curl -sSfL -o /tmp/engineering-build/confluentinc-kafka-connect-jdbc-10.9.9.zip \
    https://hub-downloads.confluent.io/api/plugins/confluentinc/kafka-connect-jdbc/versions/10.9.9/confluentinc-kafka-connect-jdbc-10.9.9.zip > /tmp/kdp-session-setup.log 2>&1 || return 1
  playground run -f connect/connect-jdbc-postgresql-sink/postgres-sink.sh --tag 8.2.0 --connector-tag 10.8.4 >> /tmp/kdp-session-setup.log 2>&1
  sed -n "/topic produce -t orders --nb-messages 1 << 'EOF'/,/^EOF/p" connect/connect-jdbc-postgresql-sink/postgres-sink.sh | sed '1d;$d' > /tmp/orders.avsc
}

    # in session_settings

# an empty reproduction-models folder: the private submodule is never checked out in this clone, and the session must
# show no private model. Bootstrap needs no git repository there (without reproduction-models/.git it skips the
# pre-commit hook, check -f / export -f / import skip their git calls). The clipboard is disabled (bootstrap and run
# copy their command with pbcopy), the run history is put aside (export takes the run line of the model from it), and
# the previous current example is kept: the teardown restores all three and removes everything bootstrap / import wrote
repro_models_state=/tmp/kdp-session-repro-state
setup_repro_models() {
  if [ -e reproduction-models/.git ] || [ -n "$(ls -A reproduction-models 2> /dev/null)" ]
  then
    echo "❌ $KDP_DIR/reproduction-models is not empty: the session must not show private models" | tee /tmp/kdp-session-setup.log
    return 1
  fi
  mkdir -p reproduction-models "$repro_models_state"
  playground config get clipboard 2> /dev/null | tail -1 > "$repro_models_state/clipboard"
  playground state get run.test_file 2> /dev/null | tail -1 > "$repro_models_state/test_file"
  playground config set clipboard false > /tmp/kdp-session-setup.log 2>&1
  rm -f playground-run-history.session-backup
  if [ -f playground-run-history ]
  then
    mv playground-run-history playground-run-history.session-backup
  fi
  : > playground-run-history
  # the bundle folder, and the empty secrets dir the tape points PLAYGROUND_SECRETS_DIR to
  rm -rf /tmp/kdp-session-repro /tmp/kdp-session-secrets
  mkdir -p /tmp/kdp-session-repro /tmp/kdp-session-secrets
}
teardown_repro_models() {
  # the model's environment, while its stop.sh still exists
  playground stop >> /tmp/kdp-session-setup.log 2>&1
  # everything bootstrap and import wrote (the folder was empty before the session)
  if [ ! -e reproduction-models/.git ]
  then
    find reproduction-models -mindepth 1 -maxdepth 1 -exec rm -rf {} +
  fi
  rm -rf /tmp/kdp-session-repro /tmp/kdp-session-secrets
  if [ -f playground-run-history.session-backup ]
  then
    mv playground-run-history.session-backup playground-run-history
  fi
  local prev
  prev=$(cat "$repro_models_state/test_file" 2> /dev/null)
  [ -n "$prev" ] && playground state set run.test_file "$prev" >> /tmp/kdp-session-setup.log 2>&1
  prev=$(cat "$repro_models_state/clipboard" 2> /dev/null)
  playground config set clipboard "${prev:-true}" >> /tmp/kdp-session-setup.log 2>&1
  rm -rf "$repro_models_state"
  return 0
}

    # in session_settings

# the config of the FileStream sink of the example with an Avro converter: it opens its own Schema Registry connection,
# so create-or-update --dry-run shows the keys it adds under sasl-ssl. The tape runs the example itself, twice
# (sasl-ssl, then rbac-sasl-plain): nothing is started off camera
setup_secured_environments() {
  rm -f /tmp/out.log
  cat > /tmp/filestream-avro.json << 'EOF2'
{
  "tasks.max": "1",
  "connector.class": "org.apache.kafka.connect.file.FileStreamSinkConnector",
  "topics": "filestream",
  "file": "/tmp/output.json",
  "value.converter": "io.confluent.connect.avro.AvroConverter",
  "value.converter.schema.registry.url": "http://schema-registry:8081"
}
EOF2
  : > /tmp/kdp-session-setup.log
}
# the rbac environment holds the role binding deleted on camera if the recording stopped in the middle: stop it
teardown_secured_environments() {
  playground stop >> /tmp/kdp-session-setup.log 2>&1
  rm -f /tmp/filestream-avro.json /tmp/out.log
  return 0
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

# the JDBC PostgreSQL sink example, and the avro schema of its orders topic for the records produced on camera while
# postgres is blocked
setup_network_traffic() {
  setup_jdbc_postgresql_sink
  sed -n "/topic produce -t orders --nb-messages 1 << 'EOF'/,/^EOF/p" connect/connect-jdbc-postgresql-sink/postgres-sink.sh | sed '1d;$d' > /tmp/orders.avsc
}

# the JDBC PostgreSQL sink example with errors.tolerance=all (no dead letter queue, no errors.log.enable: a record the
# converter rejects is dropped without a word), the avro schema of its topic orders in /tmp/orders.avsc, and no trace of
# a previous recording (the report of the session is the newest one under /tmp/jscissors)
setup_jscissors() {
  setup_jdbc_postgresql_sink
  sed -n "/topic produce -t orders --nb-messages 1 << 'EOF'/,/^EOF/p" connect/connect-jdbc-postgresql-sink/postgres-sink.sh | sed '1d;$d' > /tmp/orders.avsc
  playground connector create-or-update --connector postgres-sink >> /tmp/kdp-session-setup.log 2>&1 << 'EOF'
{
  "connector.class": "io.confluent.connect.jdbc.JdbcSinkConnector",
  "tasks.max": "1",
  "connection.url": "jdbc:postgresql://postgres/postgres?user=myuser&password=mypassword&ssl=false",
  "topics": "orders",
  "auto.create": "true",
  "errors.tolerance": "all"
}
EOF
  rm -rf /tmp/jscissors
}
# a recording stopped in the middle leaves the route to postgres cut and the agent tracing
teardown_jscissors() {
  playground debug block-traffic -c connect --destination postgres --action stop >> /tmp/kdp-session-setup.log 2>&1
  playground debug jscissors -c connect --action stop --no-analyze --output-dir /tmp/kdp-session-jscissors-trace >> /tmp/kdp-session-setup.log 2>&1
  rm -rf /tmp/kdp-session-jscissors-trace
  return 0
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

# the beginning of ccloud/fm-datagen-source/fully-managed-datagen-source.sh (up to the connector): Confluent Cloud
# bootstrapped and the topic datagen_pageviews, no connector. The tape runs under env -i: it gets the [ccloud] details
# and the API key of the cluster ($CLOUD_KEY, $CLOUD_SECRET) from a private file it sources off camera (removed by the
# teardown). The connector config, with "$CLOUD_KEY" / "$CLOUD_SECRET" placeholders that envsubst replaces, is in
# /tmp/datagen.json: no secret shows on camera. Needs terraform and the Cloud API key of the secrets store
terraform_env=/tmp/kdp-session-terraform.env
terraform_connector=DatagenSource_playground
setup_terraform() {
  if ! command -v terraform > /dev/null 2>&1 || ! command -v envsubst > /dev/null 2>&1
  then
    echo "❌ terraform and envsubst are needed (brew install hashicorp/tap/terraform gettext)" | tee /tmp/kdp-session-setup.log
    return 1
  fi
  if [ -z "$(playground state get ccloud.CLUSTER_NAME 2> /dev/null)" ]
  then
    echo "❌ no [ccloud] details in $KDP_DIR/playground.ini: run a ccloud example once in that clone" | tee /tmp/kdp-session-setup.log
    return 1
  fi
  local example=ccloud/fm-datagen-source
  sed -e '/^connector_name="DatagenSource_\$USER"/,$d' $example/fully-managed-datagen-source.sh > $example/session-setup.sh
  grep -q 'playground topic create --topic datagen_pageviews' $example/session-setup.sh || { echo "❌ the topic creation was not found in $example/fully-managed-datagen-source.sh" | tee /tmp/kdp-session-setup.log; return 1; }
  chmod +x $example/session-setup.sh
  (umask 077 && : > "$terraform_env")
  local name creds
  for name in ENVIRONMENT CLUSTER_NAME CLUSTER_CLOUD CLUSTER_REGION CLUSTER_CREDS SCHEMA_REGISTRY_CREDS
  do
    printf 'export %s=%q\n' "$name" "$(playground state get ccloud.$name)" >> "$terraform_env"
  done
  creds=$(playground state get ccloud.CLUSTER_CREDS)
  printf 'export CLOUD_KEY=%q\nexport CLOUD_SECRET=%q\n' "${creds%%:*}" "${creds#*:}" >> "$terraform_env"
  cat > /tmp/datagen.json << DATAGEN
{
  "connector.class": "DatagenSource",
  "name": "$terraform_connector",
  "kafka.auth.mode": "KAFKA_API_KEY",
  "kafka.api.key": "\$CLOUD_KEY",
  "kafka.api.secret": "\$CLOUD_SECRET",
  "kafka.topic": "datagen_pageviews",
  "output.data.format": "JSON",
  "quickstart": "PAGEVIEWS",
  "max.interval": "10000",
  "tasks.max": "1"
}
DATAGEN
  (
    source "$terraform_env"
    # the exit code of 'playground run' is not enough: it can be 1 after a successful ccloud example (end of run summary)
    playground run -f "$PWD/$example/session-setup.sh" < /dev/null > /tmp/kdp-session-setup.log 2>&1
    grep -q "RESULT: SUCCESS" /tmp/kdp-session-setup.log || exit 1
    # the connector, its terraform state and its last config of a previous recording that failed
    playground connector delete --connector $terraform_connector >> /tmp/kdp-session-setup.log 2>&1
    rm -rf .terraform-playground/$terraform_connector-*
    playground state del terraform.connector.$terraform_connector >> /tmp/kdp-session-setup.log 2>&1
    rm -f /tmp/config-$terraform_connector
    exit 0
  )
}
# the fully managed connector is billed: delete it (terraform destroy) if the tape did not, then the private files
teardown_terraform() {
  (
    set +e
    source "$terraform_env" 2> /dev/null
    playground connector delete --connector $terraform_connector
  ) < /dev/null >> /tmp/kdp-session-setup.log 2>&1
  playground container kill-all >> /tmp/kdp-session-setup.log 2>&1
  rm -rf ccloud/fm-datagen-source/session-setup.sh "$terraform_env" /tmp/datagen.json
  return 0
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
  # the first start of ttyd sometimes fails (net::ERR_CONNECTION_REFUSED): retry once. A failed take may have changed
  # what the setup prepared (offsets moved, a connector stopped, a rule added): run the setup again before the retry
  recorded=yes
  if ! "${vhs_env[@]}" vhs "tapes/session-$session.tape" > /dev/null
  then
    if [ -n "$setup" ]
    then
      echo "   🔁 off camera: $setup again before the retry (log in /tmp/kdp-session-setup.log)"
      (cd "$KDP_DIR" && PATH="$KDP_DIR/scripts/cli:$PATH" && $setup) || recorded=""
    fi
    [ -n "$recorded" ] && { "${vhs_env[@]}" vhs "tapes/session-$session.tape" > /dev/null || recorded=""; }
  fi
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

if [[ " ${sessions[*]} " =~ " "(run|secured-environments|repro-models|versions|container-lifecycle|offsets-and-lag|create-or-update|log-levels|container-logs|schema|topic-administration|remote-debugging|dlq|smt-test|jscissors|topic-produce|topic-consume|benchmark|network-traffic|connect-migration|terraform)" " ]]
then
  echo "🛑 stopping the example"
  (cd "$KDP_DIR" && PATH="$KDP_DIR/scripts/cli:$PATH" playground stop > /dev/null 2>&1) || true
fi
ls -la docs/videos/session-*.mp4
