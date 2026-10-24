# 🎓 Bite size session: "the lag of our sink is stuck at 20": read the lag, find why, follow it to 0, then rewind the sink by
# 3 records (narrated with comments typed in the terminal)
# each command that prints a wide table keeps its output in /tmp/out.log and shows a few columns: the vhs terminal (ttyd
# flow control) stops updating after a burst of a few dozen lines
# off camera (scripts/generate-session-videos.sh): the FileStream sink example (connector filestream-sink, 5 records written
# to /tmp/output.json and committed), then the connector paused and 20 more records produced to the topic filestream
Output docs/videos/session-offsets-and-lag-terminal.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

# ── 1. the symptom ──────────────────────────────────────────────────────────
Type@15ms "# 🎓 Bite size session: a customer says 'the lag of our sink is stuck at 20, nothing new reaches the file'"
Enter
Sleep 2s
Type@15ms "# a sink is a consumer: its offsets are in the consumer group connect-<connector name>"
Enter
Sleep 1s
Type "playground consumer-group describe --group connect-filestream-sink > /tmp/out.log 2>&1; grep -E 'GROUP|connect-filestream-sink' /tmp/out.log | cut -c1-130"
Sleep 800ms
Enter
Wait+Screen@1m /Total lag for consumer group/
Sleep 1s
Sleep 6s
Type@15ms "# committed offset 5, end offset 25: lag 20. And a consumer is still a member of the group: the task is there, it does not consume"
Enter
Sleep 3s
Type@15ms "# connector show-lag follows the lag until it reaches 0. It checks the connector first:"
Enter
Sleep 1s
Type "playground connector show-lag --connector filestream-sink --interval 5 --max-wait 30"
Sleep 800ms
Enter
Sleep 4s
# show-lag checks the status for 60 s (about 80 s in practice) before it gives up: cut it
Hide
Wait@3m /❯\s*$/
Show
Sleep 5s
Type@15ms "# ❌ not RUNNING after 60 s (exit 1, whatever --max-wait). Why?"
Enter
Sleep 1s
Type "playground connector status -c filestream-sink 2>&1 | grep filestream-sink | cut -c1-90"
Sleep 800ms
Enter
Wait+Screen@1m /PAUSED\s+0:/
Sleep 4s
Type@15ms "# ⏸️  someone paused it: a paused sink keeps its place in the group, consumes nothing, and its lag grows"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 2. resume, and follow the lag ───────────────────────────────────────────
Type@15ms "# ① resume it, and follow the lag every 5 s"
Enter
Sleep 1s
Type "playground connector resume --connector filestream-sink"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 2s
Type "playground connector show-lag --connector filestream-sink --interval 5 --max-wait 90"
Sleep 800ms
Enter
Wait+Screen@2m /consumer lag for .*filestream-sink is/
Sleep 12s
# the lag reaches 0 at the next commit, about 35 s after the resume: cut it
Hide
Wait@3m /❯\s*$/
Show
Sleep 5s
Type@15ms "# 🔸🐌 'still 20' until the next commit of the task, then 🏁 0. The records were written right after the resume: the lag only moves at a commit"
Enter
Sleep 3s
Type@15ms "# lag and offsets are COMMITTED values: a sink commits every offset.flush.interval.ms (60 s by default)"
Enter
Sleep 3s
Type@15ms "# 🔸 the same lag for MORE than a minute while RUNNING: stuck tasks (connector diagnose, a thread dump). Less: wait for the commit"
Enter
Sleep 3s
Type@15ms "# the same position with the offsets API of Connect (KIP-875), for sources too (a file position, a SCN, a LSN... no lag)"
Enter
Sleep 1s
Type "playground connector offsets get --connector filestream-sink"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 5s
Type@15ms "# topic filestream, partition 0, kafka_offset 25: the next record to read. alter writes this json back, reset deletes it"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 3. rewind by 3 records ──────────────────────────────────────────────────
Type@15ms "# ② the customer's target lost the last 3 records: write them again. Move the group back by 3:"
Enter
Sleep 1s
Type "playground consumer-group reset-offsets --group connect-filestream-sink --topic filestream --shift-by -3"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 7s
Type@15ms "# ❌ Kafka refuses: the group of a running sink has an active member. Offsets only change while the connector is stopped"
Enter
Sleep 3s
Type@15ms "# connector offsets alter|reset stop and resume it for you, but take explicit offsets. To go back N records or to a date:"
Enter
Sleep 3s
# a full screen sometimes stops updating in the vhs terminal: start the rewind on an empty one
Hide
Type "clear"
Enter
Sleep 300ms
Show
Type@15ms "# stop the connector, reset its group (--dry-run first), resume it"
Enter
Sleep 1s
Type "playground connector stop --connector filestream-sink"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 2s
Type "playground consumer-group reset-offsets --group connect-filestream-sink --topic filestream --shift-by -3 --dry-run"
Sleep 800ms
Enter
Wait+Screen@1m /Nothing was changed/
Sleep 1s
Sleep 5s
Type@15ms "# NEW-OFFSET 22 (25 - 3), nothing changed yet. Now for real:"
Enter
Sleep 1s
Type "playground consumer-group reset-offsets --group connect-filestream-sink --topic filestream --shift-by -3"
Sleep 800ms
Enter
Wait+Screen@1m /Offsets of consumer group connect-filestream-sink reset/
Sleep 1s
Sleep 3s
Type "playground connector resume --connector filestream-sink"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 2s
Type "playground connector show-lag --connector filestream-sink --interval 5 --max-wait 90"
Sleep 800ms
Enter
Wait+Screen@2m /consumer lag for .*filestream-sink is/
Sleep 6s
# the next commit: cut it
Hide
Wait@3m /❯\s*$/
Show
Sleep 3s
Type "playground container exec -c connect --command 'wc -l /tmp/output.json'"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 3s
Type@15ms "# ✅ 28 lines: 5 + 20, then the last 3 again. At least once: after a rewind or a crash you get duplicates, never a loss"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 4. recap ────────────────────────────────────────────────────────────────
Type@15ms "# 🧰 Where a connector is in its data, and how to move it:"
Enter
Sleep 1s
Type@15ms "#   playground connector show-lag --connector <c>             🐢 a sink catching up, or stuck (--max-wait is not an assertion)"
Enter
Sleep 2s
Type@15ms "#   playground connector offsets get|alter|reset --connector <c>   📍 sinks and sources, stop / resume included"
Enter
Sleep 2s
Type@15ms "#   playground consumer-group reset-offsets --group connect-<c>  ⏪ --to-datetime, --shift-by, --by-duration, on a stopped sink"
Enter
Sleep 2s
Type@15ms "#   playground consumer-group describe --group <g> --members     👥 any group: lag, members, state"
Enter
Sleep 3s
Type@15ms "# 💡 committed is not processed: give the lag one commit interval (60 s) before calling a sink stuck"
Enter
Sleep 6s
