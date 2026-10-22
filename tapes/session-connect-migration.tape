# 🎓 Bite size session: move a self-managed connector to fully managed with the Connector Migration Utility (narrated with comments typed in the terminal)
# off camera (scripts/generate-session-videos.sh): the first half of ccloud/connect-migration-utility/cloudwatch-metrics-sink.sh,
# a local worker connected to Confluent Cloud with the self-managed AWS CloudWatch Metrics sink OnPremCloudWatchMetricsSink_playground;
# after the recording, the fully managed connector is deleted
# discovery (about 2 min) and migrate (about 1 min 30 s) run hidden: only their command and their result are shown
Output docs/videos/session-connect-migration-terminal.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

# off camera: the [ccloud] details (no "Use previously used ccloud cluster" question) and the AWS keys (the file, mode 600,
# is removed by the teardown of scripts/generate-session-videos.sh, which needs it to delete the fully managed connector)
Hide
Type 'source /tmp/kdp-session-connect-migration.env && clear'
Enter
Sleep 1s
Show

# ── 1. the idea ─────────────────────────────────────────────────────────────
Type@15ms "# 🎓 Bite size session: moving a self-managed connector to fully managed. What does its config become? Lost or replayed data?"
Enter
Sleep 3s
Type@15ms "# Rehearse it: a local worker connected to Confluent Cloud runs the self-managed connector, the Migration Utility moves it"
Enter
Sleep 3s
Type "playground connector status 2> /dev/null | grep OnPrem"
Sleep 800ms
Enter
Wait+Screen@1m /RUNNING/
Sleep 3s
Type@15ms "# ⛈️ the self-managed AWS CloudWatch Metrics sink, RUNNING on the local worker"
Enter
Sleep 2s

# ── 2. discovery ────────────────────────────────────────────────────────────
Type@15ms "# ① discovery: reads the connectors of the worker and writes the equivalent fully managed configs (secrets redacted)"
Enter
Sleep 2s
Type "playground connector connect-migration-utility discovery > /tmp/discovery.log 2>&1"
Sleep 800ms
Enter
Hide
Wait@5m /❯\s*$/
Type "clear"
Enter
Sleep 300ms
Show
Type@15ms "# ✅ discovery done (about 2 minutes, cut). The summary: what can move, what cannot"
Enter
Sleep 1s
Type "sed -n '/Overall Summary/,/Per-Cluster Summary/p' /tmp/discovery.log | grep -v '^===' | head -10"
Sleep 800ms
Enter
Sleep 5s
Type@15ms "# and the fully managed config it generated:"
Enter
Sleep 1s
Type `jq '.config | {"connector.class", topics, "input.data.format", "aws.secret.access.key"}' connect-migration-utility-discovery-output/discovered_configs/successful_configs/fm_configs/*.json`
Sleep 800ms
Enter
Sleep 6s
Type@15ms "# 🔄 AwsCloudWatchMetricsSinkConnector => CloudWatchMetricsSink, Avro converter => input.data.format, secret redacted"
Enter
Sleep 4s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 3. the three modes ──────────────────────────────────────────────────────
Type@15ms "# ② migrate, in one of three modes:"
Enter
Sleep 1s
Type@15ms "#   create                     a new connector, no offsets: it starts from scratch (replay, or skip with latest)"
Enter
Sleep 3s
Type@15ms "#   create_latest_offset       starts from the offsets of the self-managed one, which keeps running: no downtime, some duplicates"
Enter
Sleep 3s
Type@15ms "#   stop_create_latest_offset  stops the self-managed one first, then starts from its offsets: no loss, no duplicates"
Enter
Sleep 4s
Type@15ms "# The secrets were redacted by discovery: pass them again (single quotes: expanded by the command, never shown)"
Enter
Sleep 2s

# ── 4. migrate ──────────────────────────────────────────────────────────────
Type "playground connector connect-migration-utility migrate --migration-mode stop_create_latest_offset --no-open --sensitive-property 'aws.access.key.id=$AWS_ACCESS_KEY_ID' --sensitive-property 'aws.secret.access.key=$AWS_SECRET_ACCESS_KEY' > /tmp/migrate.log 2>&1"
Sleep 1s
Enter
Hide
Wait@5m /❯\s*$/
Type "clear"
Enter
Sleep 300ms
Show
Type@15ms "# ✅ migrate done (about 1 minute 30, cut):"
Enter
Sleep 1s
Type "grep -E 'Updated|successful|PROVISIONING' /tmp/migrate.log | cut -c1-110"
Sleep 800ms
Enter
Sleep 5s
Type "playground connector wait --connector OnPremCloudWatchMetricsSink_playground --state RUNNING --max-wait 300 2> /dev/null | tail -1"
Sleep 800ms
Enter
Wait+Screen@6m /is RUNNING|FAILED|did not/
Sleep 4s
Type@15ms "# 🌤️ the fully managed connector is RUNNING in Confluent Cloud. And the self-managed one?"
Enter
Sleep 2s
Type "playground switch-back > /dev/null 2>&1; playground connector status 2> /dev/null | grep OnPrem"
Sleep 800ms
Enter
Wait+Screen@1m /STOPPED|RUNNING  /
Sleep 3s
Type@15ms "# 🛑 STOPPED by migrate before the fully managed one started from its offsets: no record lost, none twice"
Enter
Sleep 4s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 5. what we saw ──────────────────────────────────────────────────────────
Type@15ms "# What we saw:"
Enter
Sleep 1s
Type@15ms "# 🔍 discovery: the fully managed config of each connector, and the ones that cannot move (with the reason in the summary)"
Enter
Sleep 3s
Type@15ms "# 🪄 migrate, stop_create_latest_offset: the self-managed connector STOPPED, the fully managed one RUNNING from its offsets"
Enter
Sleep 3s
Type@15ms "# 🔐 --sensitive-property puts the secrets back; --no-open skips the editor and the browser (scripts, agents)"
Enter
Sleep 3s
Type@15ms "# 📚 the example: playground run -f ccloud/connect-migration-utility/cloudwatch-metrics-sink.sh (Confluent Cloud + AWS)"
Enter
Sleep 4s
