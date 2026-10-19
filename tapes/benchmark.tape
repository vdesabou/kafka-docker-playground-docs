# 📈 Benchmark a connector
Output docs/videos/benchmark.mp4
Source tapes/settings.tape
Source tapes/prelude.tape

# off camera: the JDBC PostgreSQL sink example (about 1 min)
Hide
Type "playground run -f connect/connect-jdbc-postgresql-sink/postgres-sink.sh > /tmp/kdp-video-run.log 2>&1; clear"
Enter
Wait@15m /❯\s*$/
Show

Type "playground connector status"
Sleep 500ms
Enter
Wait /❯\s*$/
Sleep 2s
Type "playground connector benchmark --nb-records 3000000 --interval 2 --output-dir /tmp/kdp-video-benchmark"
Sleep 500ms
Enter
Sleep 4s
# the backlog takes a minute to load: cut it
Hide
Wait+Screen@10m /resuming/
Show
Wait@10m /❯\s*$/
Sleep 8s
