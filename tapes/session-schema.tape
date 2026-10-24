# 🎓 Bite size session: consumers fail with "Schema not found" after a cleanup: register, a refused version, soft vs permanent delete (narrated with comments typed in the terminal)
# the produce and consume commands keep their output in /tmp/out.log and show a few lines: the vhs terminal (ttyd flow
# control) stops updating after a burst of a few dozen lines, the screen then never shows the end of the command
# off camera (scripts/generate-session-videos.sh): a plaintext environment, the empty topic orders (created off camera:
# in the vhs terminal, the screen sometimes stops updating while 'topic produce' creates a topic), and three versions
# of the Order schema in /tmp: order-v1.avsc (id, amount), order-v2-bad.avsc (+ currency without default),
# order-v2.avsc (+ currency with "default": "EUR")
Output docs/videos/session-schema-terminal.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

# ── 1. the symptom ──────────────────────────────────────────────────────────
Type@15ms "# 🎓 Bite size session: the producer of orders was refused a new schema version, somebody 'cleaned up' the subject..."
Enter
Sleep 2s
Type@15ms "# ...and now the consumers fail with: Error retrieving Avro schema for id 2. Let's replay the story"
Enter
Sleep 3s

# ── 2. register, and a version that is refused ──────────────────────────────
Type@15ms "# ① version 1 of the schema, registered without producing anything (avro, json schema or protobuf: detected)"
Enter
Sleep 1s
Type "playground schema register --subject orders-value < /tmp/order-v1.avsc"
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 5s
Type@15ms "# subject orders-value, version 1, id 1. The id is global to the registry, and it is what travels in every record"
Enter
Sleep 3s
Type@15ms "# ② the rule of the customer: BACKWARD (checked only when a new version is registered, never when reading)"
Enter
Sleep 1s
Type "playground schema set-compatibility --subject orders-value --compatibility BACKWARD"
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 3s
Type@15ms "# their version 2 adds a currency field, a string without default"
Enter
Sleep 1s
Type "cat /tmp/order-v2-bad.avsc"
Sleep 800ms
Enter
Sleep 4s
Type "playground schema register --subject orders-value < /tmp/order-v2-bad.avsc; echo exit=$?"
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 8s
Type@15ms "# 40901 READER_FIELD_MISSING_DEFAULT_VALUE: a v2 reader could not read v1 records, they have no currency. exit 1"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 3. the right fix, and records ───────────────────────────────────────────
Type@15ms `# ③ the right fix is not a cleanup: give the new field a default ("default": "EUR")`
Enter
Sleep 1s
Type "playground schema register --subject orders-value < /tmp/order-v2.avsc"
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 5s
Type@15ms "# accepted: version 2, id 2. Now 2 records written with it, and the schema id each record carries"
Enter
Sleep 1s
Type "playground topic produce -t orders --nb-messages 2 < /tmp/order-v2.avsc > /tmp/out.log 2>&1; grep produced /tmp/out.log"
Sleep 800ms
Enter
Wait@3m /❯\s*$/
Sleep 3s
Type "playground topic consume -t orders --min-expected-messages 2 --timeout 60 > /tmp/out.log 2>&1; grep -E 'avro for value|ValueSchemaId' /tmp/out.log | cut -c1-170"
Sleep 800ms
Enter
Wait@3m /❯\s*$/
Sleep 6s
Type@15ms "# ValueSchemaId:2 is all a consumer needs: it asks the registry for id 2, never for the subject"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 4. a soft delete: harmless ──────────────────────────────────────────────
Type@15ms "# ④ the 'cleanup', first as a plain delete: soft by default"
Enter
Sleep 1s
Type "playground schema delete --subject orders-value"
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 4s
Type "playground schema get --id 2"
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 6s
Type@15ms "# the subject is hidden (schema get --deleted shows it 🧟), but id 2 still resolves (deleted: true): old records still deserialize"
Enter
Sleep 3s
Type@15ms "# the same schema registered again: same id 2, next version number (the soft-deleted ones stay taken)"
Enter
Sleep 1s
Type "playground schema register --subject orders-value < /tmp/order-v2.avsc"
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 5s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 5. a permanent delete: the outage ───────────────────────────────────────
Type@15ms "# ⑤ what the customer really ran: a permanent delete (the CLI soft-deletes first, as the registry requires)"
Enter
Sleep 1s
Type "playground schema delete --subject orders-value --permanent > /tmp/out.log 2>&1; grep -E 'deleting subject' /tmp/out.log"
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 4s
Type "playground schema get --id 2"
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 6s
Type@15ms "# 🎯 40403 Schema 2 not found: exactly what the consumers get for every record written with id 2"
Enter
Sleep 3s
Type@15ms "# and registering the schema again does not bring id 2 back:"
Enter
Sleep 1s
Type "playground schema register --subject orders-value < /tmp/order-v1.avsc"
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 5s
Type@15ms "# a new id, version 1: a new history. The old records stay unreadable (see other/recover-from-schema-hard-deletion)"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 6. more ─────────────────────────────────────────────────────────────────
Type@15ms "# 💡 recap: a refused version (40901) is fixed with a default, not a delete; soft delete keeps the ids, --permanent loses them"
Enter
Sleep 2s
Type@15ms "# 💡 get-compatibility reads the subject-level rule only (40408 when none is set: the global one is BACKWARD by default)"
Enter
Sleep 2s
Type@15ms "# 💡 playground topic delete also deletes <topic>-key / <topic>-value permanently (--skip-delete-schema to keep them)"
Enter
Sleep 2s
Type@15ms "# 💡 no schema, only a sample message? playground schema derive-schema"
Enter
Sleep 2s
Type@15ms "# 📚 the Schema Registry deep dive has a lab and a recipe per customer symptom"
Enter
Sleep 5s
