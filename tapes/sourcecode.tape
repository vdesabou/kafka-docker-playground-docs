# 🧑‍💻 The source code of a connector at the exact version you run: browse it, compare two versions, or check it out to read it
Output docs/videos/sourcecode.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

Hide
Type "rm -rf /tmp/connector-plugin-sourcecode/kafka-connect-jdbc-10.8.4 && clear"
Enter
Sleep 1s
Show

Type "playground connector-plugin sourcecode -c confluentinc/kafka-connect-jdbc --only-show-url"
Sleep 500ms
Enter
Wait /❯\s*$/
Sleep 3s
Type "# compare two versions:"
Enter
Type "playground connector-plugin sourcecode -c confluentinc/kafka-connect-jdbc --connector-tag 10.8.0 --connector-tag 10.8.4 --only-show-url"
Sleep 500ms
Enter
Wait /❯\s*$/
Sleep 3s
Type "# or check out the code of the version you run, and read it:"
Enter
Type "playground connector-plugin sourcecode -c confluentinc/kafka-connect-jdbc --connector-tag 10.8.4 --checkout-only"
Sleep 500ms
Enter
Wait@2m /❯\s*$/
Sleep 2s
Type "grep -n 'BATCH_SIZE' /tmp/connector-plugin-sourcecode/kafka-connect-jdbc-10.8.4/src/main/java/io/confluent/connect/jdbc/sink/JdbcSinkConfig.java | head -4"
Sleep 500ms
Enter
Sleep 6s
