# 🎓 Bite size session: a producer gets RecordTooLargeException: reproduce it with a topic config, find it, fix it (narrated with comments typed in the terminal)
# the produce commands keep their output in /tmp/out.log and show a few lines: the vhs terminal (ttyd flow control) stops
# updating after a burst of a few dozen lines, the screen then never shows the end of the command
# off camera (scripts/generate-session-videos.sh): a plaintext environment, no topic orders (the tape creates it with
# 'topic create': in the vhs terminal, the screen sometimes stops updating while 'topic produce' creates a topic)
Output docs/videos/session-topic-administration-terminal.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

# ── 1. the symptom ──────────────────────────────────────────────────────────
Type@15ms "# 🎓 Bite size session: since Monday, the producer of the topic orders fails with RecordTooLargeException"
Enter
Sleep 2s
Type@15ms "# nobody changed the producer... but somebody may have changed the topic. Let's build a topic like theirs and find out"
Enter
Sleep 3s

# ── 2. a topic like the customer's ──────────────────────────────────────────
Type@15ms "# ① create it yourself, with the partitions and configs of the case (any kafka-topics --create argument is passed through)"
Enter
Sleep 1s
Type "playground topic create -t orders --nb-partitions 3 --config retention.ms=600000"
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 4s
Type@15ms "# create fails on an existing topic (exit 1): delete it first, or use alter for its configs"
Enter
Sleep 1s
Type "playground topic create -t orders; echo exit=$?"
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 4s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 3. some records, per partition ──────────────────────────────────────────
Type@15ms "# ② 10 keyed records, then where they landed: earliest and latest offset of each partition"
Enter
Sleep 1s
Type `playground topic produce -t orders --nb-messages 10 --key 'k%g' --value '{"id": %g}' > /tmp/out.log 2>&1; grep produced /tmp/out.log`
Sleep 800ms
Enter
Wait@3m /❯\s*$/
Sleep 3s
Type "playground topic get-offsets -t orders"
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 6s
Type@15ms "# keys k1...k10 spread by hash over the 3 partitions. TOTAL is latest - earliest offsets, like get-number-records:"
Enter
Sleep 1s
Type@15ms "# instant, but transaction markers and compacted records count too (topic consume --count reads the real records)"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 4. the change that breaks the producer ──────────────────────────────────
Type@15ms "# ③ what 'somebody' did on Monday: a max.message.bytes override on the live topic"
Enter
Sleep 1s
Type "playground topic alter -t orders --add-config max.message.bytes=1000"
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 4s
Type "playground topic describe -t orders"
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 6s
Type@15ms "# Configs: shows the overrides set on the topic (and a few broker settings), not every effective value: max.message.bytes=1000"
Enter
Sleep 3s
Type@15ms "# now a record of 5 KB, as the customer's producer sends"
Enter
Sleep 1s
Type "playground topic produce -t orders --nb-messages 1 --record-size 5000 < scripts/cli/predefined-schemas/avro/lead.avsc > /tmp/out.log 2>&1; echo exit=$?; grep RecordTooLargeException /tmp/out.log | tail -n 2 | cut -c1-170"
Sleep 800ms
Enter
Wait@3m /❯\s*$/
Sleep 7s
Type@15ms "# 🎯 reproduced: the broker refuses a record bigger than the max.message.bytes of the topic (the producer side is max.request.size)"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 5. the fix ──────────────────────────────────────────────────────────────
Type@15ms "# ④ the fix: remove the override, the topic goes back to the broker default"
Enter
Sleep 1s
Type "playground topic alter -t orders --delete-config max.message.bytes"
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 4s
Type "playground topic describe -t orders"
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 5s
Type@15ms "# max.message.bytes is gone from Configs. The same 5 KB record again:"
Enter
Sleep 1s
Type "playground topic produce -t orders --nb-messages 1 --record-size 5000 < scripts/cli/predefined-schemas/avro/lead.avsc > /tmp/out.log 2>&1; echo exit=$?; grep produced /tmp/out.log"
Sleep 800ms
Enter
Wait@3m /❯\s*$/
Sleep 5s
Type@15ms "# ✅ sent. Tell the customer which override to remove, or to raise max.request.size and max.message.bytes together"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 6. start over ───────────────────────────────────────────────────────────
Type@15ms "# ⑤ start the repro over: delete the topic (a regex works too: -t 'repro-.*')"
Enter
Sleep 1s
Type "playground topic delete -t orders > /tmp/out.log 2>&1; grep -E 'Deleting|subject' /tmp/out.log"
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 5s
Type@15ms "# ⚠️ its subject orders-value goes with it, permanently (the Avro records of step ③): --skip-delete-schema to keep it"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 7. more ─────────────────────────────────────────────────────────────────
Type@15ms "# 💡 recap: create the topic before the producers, alter to reproduce a config, describe to see the overrides, alter --delete-config to fix"
Enter
Sleep 2s
Type@15ms "# 💡 topic list (--show-internal: topics starting with _ or connect- are hidden), get-size / list --sort-by-size for the disk"
Enter
Sleep 2s
Type@15ms "# 💡 wait-for-records -t <t> --min-expected-messages N --max-wait 120 waits for a source connector, even before its topic exists"
Enter
Sleep 2s
Type@15ms "# 📚 the topic administration deep dive has a lab and a recipe per customer symptom"
Enter
Sleep 5s
