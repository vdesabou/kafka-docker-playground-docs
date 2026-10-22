# 🎓 Bite size session: read a topic (narrated with comments typed in the terminal)
# each command keeps its output in /tmp/out.log and shows a few lines: the vhs terminal (ttyd flow control) stops
# updating after a burst of a few dozen lines, the screen then never shows the end of the command
# off camera (scripts/generate-session-videos.sh): a plaintext environment, the topic orders (3 partitions, 300 avro
# records, keys order-1 to order-300) and the topic payments (3 avro records, then 2 records that are not avro)
Output docs/videos/session-topic-consume-terminal.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

# ── 1. the idea ─────────────────────────────────────────────────────────────
Type@15ms "# 🎓 Bite size session: read a topic. playground topic consume finds the format (avro, protobuf, json schema, plain) on its own"
Enter
Sleep 2s
Type@15ms "# by default it reads from the beginning: on a big topic, the first 100 records are rarely the ones you want"
Enter
Sleep 1s
Type "playground topic consume -t orders --max-messages 3 > /tmp/out.log 2>&1; grep -E 'contains|CreateTime' /tmp/out.log | cut -c1-150"
Sleep 800ms
Enter
Wait+Screen@3m /Offset:/
Sleep 1s
Sleep 6s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 2. the last records ─────────────────────────────────────────────────────
Type@15ms "# ① the most recent records: --last N, sorted by timestamp across the partitions"
Enter
Sleep 1s
Type "playground topic consume -t orders --last 3 > /tmp/out.log 2>&1; grep -E 'last|CreateTime' /tmp/out.log | cut -c1-150"
Sleep 800ms
Enter
Wait+Screen@3m /Key:order-2[0-9][0-9]/
Sleep 1s
Sleep 6s

# ── 3. one offset ───────────────────────────────────────────────────────────
Type@15ms "# ② the connector says it is stuck on partition 1, offset 42: show that record"
Enter
Sleep 1s
Type "playground topic consume -t orders --partition 1 --offset 42 --max-messages 1 > /tmp/out.log 2>&1; grep CreateTime /tmp/out.log | cut -c1-150"
Sleep 800ms
Enter
Wait+Screen@3m /Offset:42/
Sleep 1s
Sleep 6s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 4. from a time ──────────────────────────────────────────────────────────
Type@15ms "# ③ what arrived during the incident? 5 new records now, then --from-timestamp 20s (or a date, an epoch, 10m, 2h...)"
Enter
Sleep 1s
Type "playground topic produce -t orders --nb-messages 5 --key 'new-%g' < /tmp/order.avsc > /dev/null 2>&1"
Sleep 800ms
Enter
Sleep 8s
Type "playground topic consume -t orders --from-timestamp 20s > /tmp/out.log 2>&1; grep -E 'from|CreateTime' /tmp/out.log | cut -c1-150"
Sleep 800ms
Enter
Wait+Screen@3m /Key:new-5/
Sleep 1s
Sleep 7s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 5. json and counts ──────────────────────────────────────────────────────
Type@15ms "# ④ --json: one object per record, only the records on stdout, ready for jq"
Enter
Sleep 1s
Type "playground topic consume -t orders --last 3 --json 2> /dev/null | jq -c '{key, partition, offset, quantity: .value.quantity}'"
Sleep 800ms
Enter
Wait+Screen@3m /"key":"new-/
Sleep 1s
Sleep 6s
Type@15ms "# ⑤ --count: records, not offsets (transaction markers, compacted or unreadable records do not count), with --grep too"
Enter
Sleep 1s
Type `echo "records: $(playground topic consume -t orders --count 2> /dev/null), containing order-7: $(playground topic consume -t orders --count --grep order-7 2> /dev/null)"`
Sleep 800ms
Enter
Wait+Screen@3m /containing order-7: [0-9]+/
Sleep 1s
Sleep 6s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 6. the assertion ────────────────────────────────────────────────────────
Type@15ms "# ⑥ --min-expected-messages N is how examples check that data flowed: N records must really be consumed"
Enter
Sleep 2s
Type@15ms "# payments has 5 offsets, but a misconfigured producer wrote 2 records that are not avro"
Enter
Sleep 1s
Type "playground topic consume -t payments --min-expected-messages 5 > /tmp/out.log 2>&1; grep -E 'CreateTime|❗|🔥' /tmp/out.log | cut -c1-170"
Sleep 800ms
Enter
Wait+Screen@3m /could be consumed/
Sleep 1s
Sleep 10s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 7. more ─────────────────────────────────────────────────────────────────
Type@15ms "# 💡 --tail (--partition 0 to follow one partition), --grep text (fails when no record contains it)"
Enter
Sleep 2s
Type@15ms "# 💡 --print-schema  also prints the registered schemas, --no-decode keeps base64 values as they are"
Enter
Sleep 2s
Type@15ms "# 💡 --open  full dump of the topic in your editor, --key-subject / --value-subject for other subject name strategies"
Enter
Sleep 2s
Type@15ms "# 📚 playground topic consume --help has an example for each of them"
Enter
Sleep 5s
