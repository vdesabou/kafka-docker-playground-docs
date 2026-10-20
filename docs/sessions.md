# 🎬 Bite size sessions

Short sessions (2–3 minutes), each about one thing the playground does for you. The narration is typed in the terminal as
`#` comments, so you can pause the video and copy the commands. Each session ends on the HTML report the command
writes, and links to the live report so you can click around it yourself.

> [!TIP]
> The shorter clips at the top of the [introduction](/introduction.md) (🍿 See it in action) show one command each. The
> sessions here explain what the output means and what to do next.

## 🧵 A connector looks stuck: analyze thread dumps

The task is `RUNNING`, but no record moves and there is no error in the logs. Three thread dumps of the worker, a few
seconds apart, show which threads are stuck, blocked or burning CPU.

<video src="videos/session-thread-dump.mp4" poster="images/sessions/thread-dump.png" controls playsinline width="100%"></video>

**In this session**

- the 3 ways to run it: live on a running example, on dumps sent by a customer, on a sample shipped with the playground
- reading the findings, most severe first: deadlock, lock contention, stuck Connect task, CPU-hot thread, leaking thread pool
- from the stuck frame to the code: the connector source code at the customer's version
- the HTML report to share

**Commands**

```bash
# live, on a running example: 3 dumps 5 s apart, then the analysis
playground analyze thread-dump -c connect

# on dumps from a customer: one -f per dump of the same JVM
playground analyze thread-dump -f dump1.txt -f dump2.txt -f dump3.txt

# on the sample used in the session
playground analyze thread-dump --sample deadlock_jdk21 --output-dir /tmp/thread-dump
```

**Links**

- 🌐 <a href="reports/thread-dump.html" target="_blank" rel="noopener">The HTML report shown in the session</a> (the real report: click around)
- 🧠 CLI reference: [playground analyze thread-dump](/playground%20analyze%20thread-dump)
- 🔗 Next step: [playground connector-plugin sourcecode](/playground%20connector-plugin%20sourcecode)
