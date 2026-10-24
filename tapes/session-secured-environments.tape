# 🎓 Bite size session: the same example under SASL_SSL, then RBAC: what the CLI does for you, and an authorization
# error on purpose (narrated with comments typed in the terminal)
# each command that prints a lot keeps its output in /tmp/out.log or is filtered: the vhs terminal (ttyd flow control)
# stops updating after a burst of a few dozen lines
# off camera (scripts/generate-session-videos.sh): /tmp/filestream-avro.json, the config of the FileStream sink with an
# Avro converter (for create-or-update --dry-run). The session runs the FileStream sink example twice (sasl-ssl, then
# rbac-sasl-plain, about 1 min 30 s each), the waits are cut
Output docs/videos/session-secured-environments-terminal.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
# heavy environments (sasl-ssl, then rbac with LDAP and MDS) load the machine: fast typing reaches the terminal out of
# order, type slower than the other sessions
Set TypingSpeed 45ms
Source tapes/prelude.tape

# ── 1. one flag ─────────────────────────────────────────────────────────────
Type@20ms "# 🎓 Bite size session: 'it works in dev, not in our SSL cluster', 'TopicAuthorizationException with RBAC'"
Enter
Sleep 2s
Type@20ms "# The same example runs under plaintext, SASL, SCRAM, SASL_SSL, mTLS, Kerberos, LDAP or RBAC: one flag, nothing to change in the script"
Enter
Sleep 3s
Type "playground run -f $PWD/connect/connect-filestream-sink/filestream-sink.sh --environment sasl-ssl"
Sleep 800ms
Enter
Sleep 4s
# the run takes about a minute and a half: cut it
Hide
Wait@15m /❯\s*$/
# the background jobs a run leaves (fzf file list, tag and plugin lists) slow the terminal down: wait for them, off camera
Type "while pgrep -f 'generate-fzf-find-files|generate-tag-list|generate-connector-plugin-list|generate-kafka-region-list|display-last-updated|generate_connector_versions' > /dev/null; do sleep 2; done; clear"
Enter
Wait@5m /❯\s*$/
Sleep 5s
Show
Type "playground connector status -c filestream-sink"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 4s
Type@20ms "# ✅ the example ran under sasl-ssl (the run is cut). Every environment is plaintext + one compose file: listeners, JAAS, keystores"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 2. the same commands ────────────────────────────────────────────────────
Type@20ms "# The CLI knows which environment runs (recorded in playground.ini), and adapts each call: no flag to pass"
Enter
Sleep 2s
Type "playground state get run.environment"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 2s
Type `playground topic produce -t filestream --nb-messages 3 --value '{"id": %g}' > /dev/null 2>&1`
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 1s
Type "playground topic consume -t filestream --min-expected-messages 8 --timeout 60"
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 6s
Type@20ms "# 8 records: the 5 of the example + 3. Same commands as on plaintext: the console clients ran with the SASL_SSL client config"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 3. under the hood ───────────────────────────────────────────────────────
Type@20ms "# What the connect worker really loaded"
Enter
Sleep 1s
Type "playground container get-properties -c connect | grep -E 'security.protocol|sasl.mechanism|listeners'"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 5s
Type@20ms "# SASL_SSL to the brokers, and the REST API on https: the CLI calls it with the client certificate"
Enter
Sleep 3s
Type@20ms "# A connector config that opens its own connection (here a Schema Registry url) gets the security keys added for you:"
Enter
Sleep 1s
Type "cat /tmp/filestream-avro.json"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 2s
Type "playground connector create-or-update -c filestream-sink --dry-run < /tmp/filestream-avro.json 2>&1 | grep -E 'Following config|schema.registry|dry-run'"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 7s
Type@20ms "# http becomes https + keystore / truststore. --dry-run shows them, --skip-automatic-connector-config sends the config as the customer wrote it"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show
Type@20ms "# By hand, a kafka-* tool without the client config fails on the TLS listener (often with OutOfMemoryError: TLS bytes read as a size)"
Enter
Sleep 2s
Type "playground container exec -c connect --command 'timeout 60 kafka-topics --bootstrap-server broker:9092 --list' 2>&1 | grep -m 2 -E 'Error|Exception'"
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 5s
Type@20ms "# with the client config the CLI uses, it works"
Enter
Sleep 1s
Type "playground container exec -c connect --command 'kafka-topics --bootstrap-server broker:9092 --command-config /etc/kafka/secrets/client_without_interceptors.config --list' 2>&1 | grep filestream"
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 4s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 4. RBAC, and an authorization error ─────────────────────────────────────
Type@20ms "# Now RBAC: LDAP, MDS, 57 role bindings. Connectors are created by connectorSubmitter and run as connectorSA (added for you)"
Enter
Sleep 2s
Type "playground run -f $PWD/connect/connect-filestream-sink/filestream-sink.sh --environment rbac-sasl-plain"
Sleep 800ms
Enter
Sleep 4s
Hide
Wait@15m /❯\s*$/
# the background jobs a run leaves (fzf file list, tag and plugin lists) slow the terminal down: wait for them, off camera
Type "while pgrep -f 'generate-fzf-find-files|generate-tag-list|generate-connector-plugin-list|generate-kafka-region-list|display-last-updated|generate_connector_versions' > /dev/null; do sleep 2; done; clear"
Enter
Wait@5m /❯\s*$/
Sleep 5s
Show
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show
Type "playground rbac role-binding list --principal User:connectorSA"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 5s
Type@20ms "# ResourceOwner on every topic. The customer does not grant that: remove it"
Enter
Sleep 2s
Type "playground rbac role-binding delete --principal User:connectorSA --role ResourceOwner --resource 'Topic:*' > /dev/null 2>&1"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 1s
Type@20ms "# a running task keeps what it already opened: send a record, restart, wait for FAILED"
Enter
Sleep 1s
Type `playground topic produce -t filestream --nb-messages 1 --value '{"id": "after-delete"}' > /dev/null 2>&1; playground connector restart -c filestream-sink > /dev/null 2>&1`
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 1s
Type "playground connector wait -c filestream-sink --state FAILED --max-wait 180 > /tmp/out.log 2>&1; grep 'is FAILED after' /tmp/out.log"
Sleep 800ms
Enter
Sleep 3s
Hide
Wait@4m /❯\s*$/
Sleep 5s
Show
Sleep 2s
Type "playground connector status -c filestream-sink"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 6s
Type@20ms "# 🛑 TopicAuthorizationException: Not authorized to access topics: [filestream]. That is the customer's error, reproduced"
Enter
Sleep 3s
Type@20ms "# grant it back, restart: RUNNING again"
Enter
Sleep 1s
Type "playground rbac role-binding create --principal User:connectorSA --role ResourceOwner --resource 'Topic:*' > /dev/null 2>&1; playground connector restart -c filestream-sink > /dev/null 2>&1"
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 1s
Type "playground connector wait -c filestream-sink --max-wait 180 > /tmp/out.log 2>&1; grep 'is RUNNING' /tmp/out.log"
Sleep 800ms
Enter
Sleep 3s
Hide
Wait@4m /❯\s*$/
Sleep 5s
Show
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 5. recap ────────────────────────────────────────────────────────────────
Type@20ms "# 🔐 What the CLI does for you, from run.environment:"
Enter
Sleep 1s
Type@20ms "#   topic produce / consume      the client config of the environment (Kerberos: in the client container, after kinit, with FQDNs)"
Enter
Sleep 2s
Type@20ms "#   connector create-or-update   the security keys of the connections the connector opens itself (--dry-run to see them)"
Enter
Sleep 2s
Type@20ms "#   connector / schema commands  https + client certificate (sasl-ssl, 2way-ssl), basic auth (RBAC)"
Enter
Sleep 2s
Type@20ms "#   credentials                  fixed and public, in environment/<type>/: fine for a repro, never as the customer's config"
Enter
Sleep 3s
Type@20ms "# 💡 in a repro model, keep PLAYGROUND_ENVIRONMENT=${PLAYGROUND_ENVIRONMENT:-<customer's type>}: run uses it, CI can still run it elsewhere"
Enter
Sleep 6s
