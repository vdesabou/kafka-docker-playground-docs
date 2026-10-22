# 🎓 Bite size session: a slow or broken network, on purpose (narrated with comments typed in the terminal)
# each command that prints a lot keeps its output in /tmp/out.log and shows a few lines: the vhs terminal (ttyd flow
# control) stops updating after a burst of a few dozen lines
# off camera (scripts/generate-session-videos.sh): the JDBC PostgreSQL sink example (connector postgres-sink, 2 rows in
# the table orders) and the avro schema of its topic orders in /tmp/orders.avsc
Output docs/videos/session-network-traffic-terminal.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

# ── 1. the question ─────────────────────────────────────────────────────────
Type@15ms "# 🎓 Bite size session: the customer blames the network. Make it slow, or cut it, on purpose, and watch what the connector does"
Enter
Sleep 2s
Type@15ms "# the JDBC PostgreSQL sink example is running: connect reads the topic orders and writes to postgres"
Enter
Sleep 1s
Type "playground connector status 2>&1 | grep postgres-sink | cut -c1-90"
Sleep 800ms
Enter
Wait+Screen@1m /RUNNING\s+0:/
Sleep 4s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 2. degrade-traffic ──────────────────────────────────────────────────────
Type@15ms "# ① degrade-traffic: latency, jitter, loss, corruption, bandwidth (tc netem, from a netshoot container: nothing installed, no restart)"
Enter
Sleep 2s
Type@15ms "# before: --action status shows what is applied and measures the round trip"
Enter
Sleep 1s
Type "playground debug degrade-traffic -c connect --destination postgres --action status"
Sleep 800ms
Enter
Wait+Screen@1m /round trip from connect/
Sleep 4s
Type@15ms "# +200 ms on the traffic from connect to postgres"
Enter
Sleep 1s
Type "playground debug degrade-traffic -c connect --destination postgres --latency 200ms --action start"
Sleep 800ms
Enter
Wait+Screen@1m /round trip from connect to postgres: [0-9]{3}/
Sleep 4s
Type@15ms "# ⚠️  tc only delays what a container SENDS: the round trip grew by 200 ms, not 400. To delay both ways, degrade postgres too"
Enter
Sleep 1s
Type "playground debug degrade-traffic -c postgres --destination connect --latency 200ms --action start"
Sleep 800ms
Enter
Wait+Screen@1m /round trip from postgres/
Sleep 6s
Hide
Type "clear"
Enter
Sleep 300ms
Show
Type@15ms "# --action stop on postgres only: each container keeps its own degradation until it is stopped or replaced"
Enter
Sleep 1s
Type "playground debug degrade-traffic -c postgres --action stop"
Sleep 800ms
Enter
Wait+Screen@1m /container postgres is back to normal/
Sleep 3s
Type@15ms "# several effects in one call, only on the tcp traffic to one port. A new --action start replaces the previous one of connect"
Enter
Sleep 1s
Type "playground debug degrade-traffic -c connect --destination postgres --port 5432 --latency 100ms --jitter 50ms --loss 5% --action start"
Sleep 800ms
Enter
Wait+Screen@1m /tcp connection time|no tcp connection/
Sleep 4s
Type@15ms "# with --port, what is measured is a tcp connection: the ping (icmp) is not degraded"
Enter
Sleep 1s
Type "playground debug degrade-traffic -c connect --destination postgres --action status"
Sleep 800ms
Enter
Wait+Screen@1m /round trip from connect to postgres: 0/
Sleep 5s
Type@15ms "# --action stop: back to normal, on every interface of the container"
Enter
Sleep 1s
Type "playground debug degrade-traffic -c connect --action stop"
Sleep 800ms
Enter
Wait+Screen@1m /container connect is back to normal/
Sleep 4s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 3. block-traffic ────────────────────────────────────────────────────────
Type@15ms "# ② block-traffic: an iptables DROP, like a firewall. No error comes back: the client waits for its own timeout"
Enter
Sleep 2s
Type "playground debug block-traffic -c connect --destination postgres --port 5432 --action start > /tmp/out.log 2>&1; grep -E 'Blocking|DROP' /tmp/out.log"
Sleep 800ms
Enter
Wait+Screen@1m /-j DROP/
Sleep 3s
Type@15ms "# new records arrive: the sink has to write them to postgres"
Enter
Sleep 1s
Type "playground topic produce -t orders --nb-messages 5 < /tmp/orders.avsc > /dev/null 2>&1"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 1s
Type@15ms "# connector wait --state FAILED returns as soon as the connector or one of its tasks fails"
Enter
Sleep 1s
Type "playground connector wait --connector postgres-sink --state FAILED --max-wait 300 > /tmp/out.log 2>&1; grep -E 'is FAILED after' /tmp/out.log"
Sleep 800ms
Enter
Sleep 4s
# the jdbc sink retries for about a minute: cut it
Hide
Wait+Screen@6m /FAILED after [0-9]+ seconds/
Show
Sleep 4s
Type@15ms "# why? the error digest of the connect logs"
Enter
Sleep 1s
Type "playground container logs -c connect --errors --since 5m > /tmp/out.log 2>&1; grep -m 1 -A 4 'ERROR x' /tmp/out.log | cut -c1-150"
Sleep 800ms
Enter
Wait+Screen@1m /Connect timed out/
Sleep 8s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 4. recovery ─────────────────────────────────────────────────────────────
Type@15ms "# ③ the network is back: the same flags, with --action stop"
Enter
Sleep 1s
Type "playground debug block-traffic -c connect --destination postgres --port 5432 --action stop > /tmp/out.log 2>&1; grep Unblocking /tmp/out.log"
Sleep 800ms
Enter
Wait+Screen@1m /Unblocking traffic/
Sleep 3s
Type@15ms "# does the sink recover on its own?"
Enter
Sleep 1s
Type "sleep 10; playground connector status 2>&1 | grep postgres-sink | cut -c1-90"
Sleep 800ms
Enter
Wait+Screen@1m /FAILED\s+tasks/
Sleep 3s
Type@15ms "# no: 'Task is being killed and will not recover until manually restarted'. That is the answer for the customer"
Enter
Sleep 3s
Type "playground connector restart --connector postgres-sink > /dev/null 2>&1; playground connector wait --connector postgres-sink --max-wait 60 > /tmp/out.log 2>&1; grep 'is RUNNING' /tmp/out.log"
Sleep 800ms
Enter
Wait+Screen@2m /RUNNING \(1 task/
Sleep 2s
Type@15ms "# 2 rows before the outage + the 5 records sent during it"
Enter
Sleep 1s
Type `sleep 8; echo "rows in orders: $(playground container exec -c postgres --command "psql -U myuser -d postgres -t -A -c 'SELECT count(*) FROM orders'" 2>/dev/null | tail -1)"`
Sleep 800ms
Enter
Wait+Screen@1m /rows in orders: [0-9]/
Sleep 4s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 5. more ─────────────────────────────────────────────────────────────────
Type@15ms "# 💡 -c can be repeated, --destination is a container, an ip or a hostname, cfk too (an ephemeral container in the pod)"
Enter
Sleep 2s
Type@15ms "# 💡 degrade-traffic without --destination: all the traffic of the container (Confluent Cloud, a SaaS behind changing ips)"
Enter
Sleep 2s
Type@15ms "# 💡 a container restart removes both. The *-proxy.sh examples block the direct route to prove that the proxy is used"
Enter
Sleep 2s
Type@15ms "# 📚 playground debug degrade-traffic --help, playground debug block-traffic --help"
Enter
Sleep 5s
