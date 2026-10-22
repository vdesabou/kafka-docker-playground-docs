# 🎓 Bite size session: deploy a fully managed connector with Terraform (narrated with comments typed in the terminal)
# off camera (scripts/generate-session-videos.sh): the beginning of ccloud/fm-datagen-source/fully-managed-datagen-source.sh,
# Confluent Cloud bootstrapped and the topic datagen_pageviews, and the connector config in /tmp/datagen.json with
# "$CLOUD_KEY" / "$CLOUD_SECRET" placeholders; after the recording, the connector is deleted if the tape did not
# the creation (terraform init, plan, apply, provisioning: about 3 to 4 min) runs hidden: only its command and its result are shown
Output docs/videos/session-terraform-terminal.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

# off camera: the [ccloud] details (no "Use previously used ccloud cluster" question) and $CLOUD_KEY / $CLOUD_SECRET (the
# file, mode 600, is removed by the teardown of scripts/generate-session-videos.sh)
# the generator runs vhs a second time when the first run fails: start from a clean state (no connector, the original config)
Hide
# (the connector of a failed run has a terraform state: deleting it runs terraform destroy); the marker is printed with
# printf so that the typed command does not match it
Type 'source /tmp/kdp-session-terraform.env; [ -n "$(playground state get terraform.connector.DatagenSource_playground)" ] && playground connector delete --connector DatagenSource_playground > /tmp/kdp-terraform-session-reset.log 2>&1; sed -i "" "s/\"1000\"/\"10000\"/" /tmp/datagen.json; printf "kdp-%s\n" reset-done'
Enter
Wait+Screen@5m /kdp-reset-done/
Type "clear"
Enter
Sleep 1s
Show

# ── 1. the idea ─────────────────────────────────────────────────────────────
Type@15ms "# 🎓 Bite size session: deploy a fully managed connector with Terraform, from the same JSON config as every example"
Enter
Sleep 2s
Type@15ms "# the config of the Datagen example (ccloud/fm-datagen-source): the API key and secret come from environment variables"
Enter
Sleep 1s
Type "cat /tmp/datagen.json"
Sleep 800ms
Enter
Sleep 7s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 2. create ───────────────────────────────────────────────────────────────
Type@15ms "# ① add --terraform: the JSON becomes HCL, then terraform init, plan and apply (the 3 minutes of provisioning are cut)"
Enter
Sleep 1s
Type "envsubst < /tmp/datagen.json | playground connector create-or-update -c DatagenSource_playground --terraform --wait > /tmp/kdp-terraform-session-create.log 2>&1; grep -E 'Terraform directory|Plan:|Connector ID|is RUNNING' /tmp/kdp-terraform-session-create.log | cut -c1-150"
Sleep 800ms
Enter
Sleep 3s
Hide
Wait+Screen@15m /lcc-[a-z0-9]{4}/
Sleep 3s
Show
Sleep 9s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 3. the HCL ──────────────────────────────────────────────────────────────
Type@15ms "# ② the HCL it generated: the API key and secret go to config_sensitive, masked in the output (and hidden by Terraform)"
Enter
Sleep 1s
Type `sed -n '/resource "confluent_connector"/,/lifecycle/{/lifecycle/q;p;}' /tmp/kdp-terraform-session-create.log | grep -vE '^ *$' | cut -c1-120`
Sleep 800ms
Enter
Wait+Screen@1m /config_sensitive/
Sleep 10s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 4. the state ────────────────────────────────────────────────────────────
Type@15ms "# ③ the Terraform folder of the connector is kept (.tf file and state): .terraform-playground/<connector>-*"
Enter
Sleep 1s
Type "ls .terraform-playground/ && terraform -chdir=$(ls -d .terraform-playground/DatagenSource_playground-*) state list"
Sleep 800ms
Enter
Wait+Screen@1m /confluent_connector\./
Sleep 6s

# ── 5. update ───────────────────────────────────────────────────────────────
Type@15ms "# ④ change the config and run the same command: the state is reused, Terraform updates the connector in place"
Enter
Sleep 1s
Type `sed -i '' 's/"10000"/"1000"/' /tmp/datagen.json`
Sleep 800ms
Enter
Sleep 1s
Type "envsubst < /tmp/datagen.json | playground connector create-or-update -c DatagenSource_playground --terraform > /tmp/kdp-terraform-session-update.log 2>&1; grep -E 'reused|-> |Plan:' /tmp/kdp-terraform-session-update.log | cut -c1-150"
Sleep 800ms
Enter
Wait+Screen@5m /to change/
Sleep 1s
Sleep 9s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 6. records ──────────────────────────────────────────────────────────────
Type@15ms "# ⑤ the connector produces: the last records of its topic"
Enter
Sleep 1s
Type "playground topic consume -t datagen_pageviews --last 3 > /tmp/kdp-terraform-session-consume.log 2>&1; grep CreateTime /tmp/kdp-terraform-session-consume.log | cut -c1-150"
Sleep 800ms
Enter
Wait+Screen@6m /Offset:/
Sleep 1s
Sleep 6s

# ── 7. delete ───────────────────────────────────────────────────────────────
Type@15ms "# ⑥ playground connector delete runs terraform destroy: no state is left with a connector that no longer exists"
Enter
Sleep 1s
Type "playground connector delete --connector DatagenSource_playground > /tmp/kdp-terraform-session-delete.log 2>&1; grep -E 'terraform destroy|Destroy complete' /tmp/kdp-terraform-session-delete.log | cut -c1-150"
Sleep 800ms
Enter
Wait+Screen@5m /Destroy complete/
Sleep 1s
Sleep 6s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 8. more ─────────────────────────────────────────────────────────────────
Type@15ms "# 💡 a connector created without --terraform is imported into the state the first time --terraform is used"
Enter
Sleep 2s
Type@15ms "# 💡 connector.tf is plain HCL for the confluentinc/confluent provider: a starting point for your own Terraform code"
Enter
Sleep 2s
Type@15ms "# 💡 works with every fully managed example: add --terraform to its playground connector create-or-update"
Enter
Sleep 2s
Type@15ms "# 📚 playground connector create-or-update --help"
Enter
Sleep 5s
