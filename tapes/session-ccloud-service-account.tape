# 🎓 Bite size session: a fully managed connector with a service account, reproduce an authorization error (narrated with
# comments typed in the terminal)
# off camera (scripts/generate-session-videos.sh): the beginning of ccloud/fm-datagen-source/fully-managed-datagen-source.sh,
# Confluent Cloud bootstrapped and the topic datagen_pageviews, and the connector config in /tmp/datagen-sa.json with
# "$CLOUD_KEY" / "$CLOUD_SECRET" placeholders; after the recording, the connector and its service account are deleted if
# the tape did not
# the waits (provisioning, the task failing, the restart: about 1 to 3 min each) run hidden: only the commands and their
# results are shown
Output docs/videos/session-ccloud-service-account-terminal.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

# off camera: the [ccloud] details (no "Use previously used ccloud cluster" question) and $CLOUD_KEY / $CLOUD_SECRET (the
# file, mode 600, is removed by the teardown of scripts/generate-session-videos.sh)
# the generator runs vhs a second time when the first run fails: start from a clean state (no connector, no service
# account left by the first run); the marker is printed with printf so that the typed command does not match it
Hide
Type 'source /tmp/kdp-session-ccloud-service-account.env; playground connector delete --connector DatagenSource_playground > /tmp/kdp-sa-session-reset.log 2>&1; printf "kdp-%s\n" reset-done'
Enter
Wait+Screen@5m /kdp-reset-done/
Type "clear"
Enter
Sleep 1s
Show

# ── 1. the idea ─────────────────────────────────────────────────────────────
Type@15ms "# 🎓 Bite size session: a fully managed connector with a service account, and an authorization error reproduced"
Enter
Sleep 2s
Type@15ms "# the examples use an API key that can do anything: the customer's connector runs with a service account and ACLs"
Enter
Sleep 2s
Type@15ms "# playground run --ccloud-service-account gives each connector of the example its own service account (the example is"
Enter
Type@15ms "# not changed): it sets PG_CCLOUD_SERVICE_ACCOUNT=true, which playground connector create-or-update reads"
Enter
Sleep 2s
Type@15ms "# the config of the Datagen example (ccloud/fm-datagen-source), with the API key of the cluster"
Enter
Sleep 1s
Type "cat /tmp/datagen-sa.json"
Sleep 800ms
Enter
Sleep 6s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 2. create ───────────────────────────────────────────────────────────────
Type@15ms "# ① create it with a service account: the API key is removed from the config, the ACLs come from the documentation"
Enter
Sleep 1s
Type "envsubst < /tmp/datagen-sa.json | PG_CCLOUD_SERVICE_ACCOUNT=true playground connector create-or-update -c DatagenSource_playground --wait > /tmp/kdp-sa-session-create.log 2>&1; grep -E '👤|🎩|🚦|💻 confluent (iam|kafka acl)|rbac acl delete|is RUNNING' /tmp/kdp-sa-session-create.log | cut -c1-150"
Sleep 800ms
Enter
Sleep 3s
Hide
Wait@15m /❯\s*$/
Sleep 3s
Show
Sleep 10s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 3. the ACLs ─────────────────────────────────────────────────────────────
Type@15ms "# ② the ACLs of its service account: --connector finds it (kafka.service.account.id of the connector config)"
Enter
Sleep 1s
Type "playground rbac acl list --connector DatagenSource_playground 2>&1 | cut -c1-150"
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 8s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 4. break it ─────────────────────────────────────────────────────────────
Type@15ms "# ③ the customer's case: the service account lost WRITE on the topic. Delete the ACL, restart, the task fails"
Enter
Sleep 1s
Type@15ms "# (an ACL change takes up to a minute to be applied in Confluent Cloud, hence the sleep 60 before the restart)"
Enter
Sleep 1s
Type "playground rbac acl delete --connector DatagenSource_playground --operation WRITE --resource Topic:datagen_pageviews 2>&1 | cut -c1-150"
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 3s
Type "sleep 60; playground connector restart --connector DatagenSource_playground > /dev/null 2>&1; playground connector wait --connector DatagenSource_playground --state FAILED --max-wait 600 > /dev/null 2>&1; playground connector status --connector DatagenSource_playground 2>&1 | grep -E 'FAILED|permission' | cut -c1-150"
Sleep 800ms
Enter
Sleep 3s
Hide
Wait@15m /❯\s*$/
Sleep 3s
Show
Sleep 6s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 5. diagnose ─────────────────────────────────────────────────────────────
Type@15ms "# ④ playground connector diagnose compares the ACLs of the service account with the documentation, and prints the fix"
Enter
Sleep 1s
Type "playground connector diagnose --connector DatagenSource_playground --no-open > /tmp/kdp-sa-session-diagnose.log 2>&1; grep -E 'service account sa-|missing:|denied:|🔧|rbac acl create' /tmp/kdp-sa-session-diagnose.log | cut -c1-150"
Sleep 800ms
Enter
Wait@5m /❯\s*$/
Sleep 1s
Sleep 12s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 6. fix it ───────────────────────────────────────────────────────────────
Type@15ms "# ⑤ the fix is the command diagnose printed: create the ACL again, restart, the connector is RUNNING"
Enter
Sleep 1s
Type@15ms "# (the restart is retried until the new ACL is applied: the wait stops as soon as it sees the connector FAILED)"
Enter
Sleep 1s
Type "playground rbac acl create --connector DatagenSource_playground --operation WRITE --resource Topic:datagen_pageviews 2>&1 | cut -c1-150"
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 3s
Type "for i in 1 2 3; do sleep 60; playground connector restart --connector DatagenSource_playground > /dev/null 2>&1; sleep 30; playground connector wait --connector DatagenSource_playground --max-wait 300 > /dev/null 2>&1 && break; done; playground connector status --connector DatagenSource_playground 2>&1 | grep -E 'RUNNING|FAILED' | cut -c1-150"
Sleep 800ms
Enter
Sleep 3s
Hide
Wait@25m /❯\s*$/
Sleep 3s
Show
Sleep 6s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 7. delete ───────────────────────────────────────────────────────────────
Type@15ms "# ⑥ playground connector delete also deletes the service account and its ACLs (so do the end of a run and cleanup-cloud-resources)"
Enter
Sleep 1s
Type "playground connector delete --connector DatagenSource_playground 2>&1 | grep -E 'service account|deleted' | cut -c1-150"
Sleep 800ms
Enter
Wait@5m /❯\s*$/
Sleep 3s
Sleep 6s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 8. more ─────────────────────────────────────────────────────────────────
Type@15ms "# 💡 --ccloud-service-account-acls none: no ACL at all, add them one by one with playground rbac acl create --connector"
Enter
Sleep 2s
Type@15ms "# 💡 --ccloud-service-account-acls full: every operation on every topic and group, to rule ACLs out"
Enter
Sleep 2s
Type@15ms "# 💡 PG_CCLOUD_SERVICE_ACCOUNT_ACL_EXCLUDE='READ Group:' skips ACLs when they are created, --deny adds a DENY ACL"
Enter
Sleep 2s
Type@15ms "# 💡 --ccloud-service-account-id sa-xxxxx: the customer's service account, as is (no ACL created nor deleted)"
Enter
Sleep 2s
Type@15ms "# 📚 playground run --help, playground rbac acl --help"
Enter
Sleep 5s
