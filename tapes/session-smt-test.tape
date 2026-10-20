# 🎓 Bite size session: what does this transform chain (SMT) do to a record, and which step breaks it? (narrated with comments typed in the terminal)
# off camera (scripts/generate-session-videos.sh): the JDBC PostgreSQL sink example, and the chain of a customer in /tmp/transforms.json
# the end of the session (a scroll through the HTML report) is added by scripts/generate-session-videos.sh
Output docs/videos/session-smt-test-terminal.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

# ── 1. the question ─────────────────────────────────────────────────────────
Type@15ms "# 🎓 Bite size session: a customer sends their transform chain: the records land wrong, or the task fails in an SMT"
Enter
Sleep 2s
Type@15ms "# Which transform does what? Usually: TRACE logs, a FileStream sink, and a lot of guessing. Here is the chain:"
Enter
Sleep 2s
Type "cat /tmp/transforms.json"
Sleep 800ms
Enter
Sleep 9s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 2. run the chain on a real record ───────────────────────────────────────
Type@15ms "# Run it step by step on a real record of the orders topic, with the classes and versions of the running worker"
Enter
Sleep 1s
Type@15ms "# (no topic, no connector created; --connector <c> takes the chain of a running connector instead)"
Enter
Sleep 1s
Type "playground connector smt test --from-topic orders --offset 0 < /tmp/transforms.json"
Sleep 800ms
Enter
Wait@3m /❯\s*$/
Sleep 16s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 3. what it shows ────────────────────────────────────────────────────────
Type@15ms "# What each step did:"
Enter
Sleep 1s
Type@15ms "# 1 ReplaceField   product renamed product_name (value and schema: + product_name, - product)"
Enter
Sleep 2s
Type@15ms "# 2 InsertField    source=web added"
Enter
Sleep 2s
Type@15ms "# 3 RegexRouter    topic orders => orders_v2 (the table name of a JDBC sink!)"
Enter
Sleep 2s
Type@15ms "# 4 TimestampConverter: (no change)! field created_at does not exist in the record => a silent no-op, no error"
Enter
Sleep 3s
Type@15ms "# 5 Cast           ❌ DataException: product_name is not a number, it cannot be cast to int32 => the step that fails the task"
Enter
Sleep 3s
Type@15ms "# 💡 compare the built-in transforms of two CP versions: --cp-version 7.9.0 --cp-version 8.3.2"
Enter
Sleep 2s
Type@15ms "# 💡 an SMT that is not in the worker: --smt-plugin owner/name:version (Confluent Hub) or --smt-jar my-smt.jar"
Enter
Sleep 4s

# ── 4. the HTML report ──────────────────────────────────────────────────────
Type@15ms "# 🌐 The HTML report shows the record after each step, the changed fields highlighted, the schema diff and the error"
Enter
Sleep 2s
Type "ls /tmp/playground-smt-test"
Sleep 500ms
Enter
Sleep 3s
Type@15ms "# It looks like this 👇"
Enter
Sleep 2s
