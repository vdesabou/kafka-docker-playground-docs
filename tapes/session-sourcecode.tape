# 🎓 Bite size session: the source code of a connector at the exact version a customer runs (narrated with comments typed in the terminal)
Output docs/videos/session-sourcecode-terminal.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

Hide
Type "rm -rf /tmp/connector-plugin-sourcecode/kafka-connect-jdbc-10.8.4 && clear"
Enter
Sleep 1s
Show

# ── 1. the question ─────────────────────────────────────────────────────────
Type@15ms "# 🎓 Bite size session: a customer runs the JDBC sink 10.8.4. What does batch.size do, and what changed since?"
Enter
Sleep 2s
Type@15ms "# The answer is in the code at their exact version, not on the main branch: which repo, which tag?"
Enter
Sleep 3s

# ── 2. the docs of a config key, offline ────────────────────────────────────
Type@15ms "# ① first, the docs of the key: doc, type, default, since when, and the values used in the examples"
Enter
Sleep 1s
Type "playground connector-plugin config-key --key batch.size --connector-class io.confluent.connect.jdbc.JdbcSinkConnector"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 7s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 3. the code at a version, a comparison ──────────────────────────────────
Type@15ms "# ② the code at the version of the customer: the GitHub tree at the exact tag"
Enter
Sleep 1s
Type "playground connector-plugin sourcecode -c confluentinc/kafka-connect-jdbc --connector-tag 10.8.4 --only-show-url"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 4s
Type@15ms "# ③ what changed between their version and the latest one: two --connector-tag => the GitHub comparison"
Enter
Sleep 1s
Type "playground connector-plugin sourcecode -c confluentinc/kafka-connect-jdbc --connector-tag 10.8.4 --connector-tag 10.9.9 --only-show-url"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 5s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 4. read it locally ──────────────────────────────────────────────────────
Type@15ms "# ④ read it locally: clones the tag into /tmp/connector-plugin-sourcecode (reused next time), then grep away"
Enter
Sleep 1s
Type "playground connector-plugin sourcecode -c confluentinc/kafka-connect-jdbc --connector-tag 10.8.4 --checkout-only"
Sleep 800ms
Enter
Wait@2m /❯\s*$/
Sleep 3s
Type "grep -n 'BATCH_SIZE' /tmp/connector-plugin-sourcecode/kafka-connect-jdbc-10.8.4/src/main/java/io/confluent/connect/jdbc/sink/JdbcSinkConfig.java | head -4"
Sleep 800ms
Enter
Sleep 5s

# ── 5. more ─────────────────────────────────────────────────────────────────
Type@15ms "# 💡 fully managed connectors too: confluentinc/<FM plugin name> resolves to the v<version>-cloud tag (needs VPN)"
Enter
Sleep 3s
Type@15ms "# 💡 interactively, --open opens the code in your editor, --compile builds the plugin to run it with --connector-zip"
Enter
Sleep 3s
Type@15ms "# 🔗 the stuck frame of a thread dump, or a hot method of a flight recording: this is where you read it"
Enter
Sleep 5s
