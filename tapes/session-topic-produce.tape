# 🎓 Bite size session: produce realistic test data to a topic (narrated with comments typed in the terminal)
# each command keeps its output in /tmp/out.log and shows its last 12 lines: the vhs terminal (ttyd flow control) stops
# updating after a burst of a few dozen lines, the screen then never shows the end of the command
# off camera (scripts/generate-session-videos.sh): the JDBC PostgreSQL sink example, its topics, and a JSON record in /tmp/payment.json
Output docs/videos/session-topic-produce-terminal.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

# ── 1. the idea ─────────────────────────────────────────────────────────────
Type@15ms "# 🎓 Bite size session: you need records like the customer's: give a schema, get random records that match it"
Enter
Sleep 2s
Type@15ms "# Avro, JSON Schema, Protobuf or plain JSON; schema registered for you; any environment (SASL, mTLS, Confluent Cloud)"
Enter
Sleep 3s

# ── 2. from a schema, with a key and headers ────────────────────────────────
Type@15ms "# ① an Avro schema on stdin, 5 records, a key (%g = the record number) and headers"
Enter
Sleep 1s
Type "playground topic produce -t leads --nb-messages 5 --key 'lead-%g' --headers 'source:web,version:2' < scripts/cli/predefined-schemas/avro/lead.avsc > /tmp/out.log 2>&1; grep -v WARNING /tmp/out.log | tail -n 12 | cut -c1-150"
Sleep 800ms
Enter
Wait+Screen@3m /produced 5 records to topic leads/
Sleep 1s
Sleep 6s
Type@15ms "# and read them back, with their key and headers"
Enter
Sleep 1s
Type "playground topic consume -t leads --max-messages 2 > /tmp/out.log 2>&1; grep Key: /tmp/out.log | cut -c1-150"
Sleep 800ms
Enter
Wait+Screen@3m /Key:lead-2/
Sleep 1s
Sleep 7s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 3. no schema? derive one from a record ──────────────────────────────────
Type@15ms "# ② the customer sent one JSON record, no schema: derive an Avro (or JSON Schema, Protobuf) schema from it"
Enter
Sleep 1s
Type "cat /tmp/payment.json"
Sleep 800ms
Enter
Sleep 2s
Type "playground topic produce -t payments --nb-messages 3 --derive-value-schema-as AVRO < /tmp/payment.json > /tmp/out.log 2>&1; grep -v WARNING /tmp/out.log | tail -n 12 | cut -c1-150"
Sleep 800ms
Enter
Wait+Screen@3m /produced 3 records to topic payments/
Sleep 1s
Sleep 8s
Type@15ms "# the derived schema (amount double, customer string, order_id int, paid boolean) is registered as payments-value"
Enter
Sleep 4s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 4. datagen, tombstones, big records ─────────────────────────────────────
Type@15ms "# ③ datagen schemas give realistic values: stock trades, pizza orders, clickstream... (predefined-schemas/datagen)"
Enter
Sleep 1s
Type "playground topic produce -t trades --nb-messages 3 < scripts/cli/predefined-schemas/datagen/stock_trades_schema.avro > /tmp/out.log 2>&1; grep -v WARNING /tmp/out.log | tail -n 12 | cut -c1-150"
Sleep 800ms
Enter
Wait+Screen@3m /produced 3 records to topic trades/
Sleep 1s
Sleep 6s
Type@15ms "# ④ a tombstone (null value) for a key: deletes in a compacted topic, a JDBC sink with delete.enabled"
Enter
Sleep 1s
Type "playground topic produce -t leads --tombstone --key 'lead-1' > /tmp/out.log 2>&1; grep -v WARNING /tmp/out.log | tail -n 12 | cut -c1-150"
Sleep 800ms
Enter
Wait+Screen@3m /produced 1 records to topic leads/
Sleep 1s
Sleep 4s
Type@15ms "# ⑤ big records: --record-size 1000000 (1 MB each, to test max.request.size, message.max.bytes...)"
Enter
Sleep 1s
Type "playground topic produce -t big --nb-messages 2 --record-size 1000000 < scripts/cli/predefined-schemas/avro/lead.avsc > /tmp/out.log 2>&1; grep -E 'record size|records were generated|produc' /tmp/out.log | cut -c1-150"
Sleep 800ms
Enter
Wait+Screen@3m /produced 2 records to topic big/
Sleep 9s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 5. more ─────────────────────────────────────────────────────────────────
Type@15ms "# 💡 --forced-value '{...}'  your exact payload (%g = the record number), --generate-only to print records without sending"
Enter
Sleep 2s
Type@15ms "# 💡 --nb-messages -1  produce without end (load test), --sleep-time-between-batch to pace it"
Enter
Sleep 2s
Type@15ms "# 💡 --validate  checks the schema against the converter of the sink connector"
Enter
Sleep 2s
Type@15ms "# 💡 --value-subject-name-strategy TopicRecordNameStrategy, --schema-id-in-header, --compression-codec zstd..."
Enter
Sleep 2s
Type@15ms "# 📚 playground topic produce --help has an example for each of them"
Enter
Sleep 5s
