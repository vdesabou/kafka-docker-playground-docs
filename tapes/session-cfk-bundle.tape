# 🎓 Bite size session: what is wrong in this Confluent for Kubernetes cluster? Analyze a CFK support bundle (narrated with comments typed in the terminal)
# the end of the session (a scroll through the HTML report) is added by scripts/generate-session-videos.sh
Output docs/videos/session-cfk-bundle-terminal.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

# ── 1. the symptom ──────────────────────────────────────────────────────────
Type@15ms "# 🎓 Bite size session: a CFK cluster is broken, the customer sends a support bundle (kubectl confluent support-bundle)"
Enter
Sleep 2s
Type@15ms "# A tar.gz of pod logs, CR yamls, events and pod states: where do you start?"
Enter
Sleep 3s

# ── 2. the ways to run it ───────────────────────────────────────────────────
Type@15ms "# ① on the bundle of a customer: folder, .tar.gz or .zip, analyzed in a container, secrets / IPs / hostnames sanitized"
Enter
Type@15ms "#    playground analyze cfk-bundle --bundle support-bundle.tar.gz"
Enter
Sleep 2s
Type@15ms "#    focus with --component connect, --severity high, --top 5"
Enter
Sleep 2s
Type@15ms "# ② on a sample shipped with the playground: a cluster with several problems, try it now 👇"
Enter
Sleep 2s

Type "playground analyze cfk-bundle --sample synthetic --output-dir /tmp/cfk-bundle | less -R"
Sleep 800ms
Enter

# ── 3. the digest, page by page ─────────────────────────────────────────────
# page 1: issues by severity and component, versions, recent changes
Sleep 16s
Type " "
# page 2: pod failures, with the recommended steps
Sleep 10s
Type " "
# page 3: resource issues (OOMKilled), health checks
Sleep 10s
Type " "
# page 4: certificate / TLS issues
Sleep 10s
Type "q"
Sleep 500ms
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 4. what it found ────────────────────────────────────────────────────────
Type@15ms "# What it found: 4 critical, 6 high, and a timeline that tells the story"
Enter
Sleep 1s
Type@15ms "# 🕘 recent changes: Kafka/kafka edited with kubectl on Oct 13 (spec.tls), the broker certificate expired that night"
Enter
Sleep 3s
Type@15ms "# 🔴 kafka-2 in CrashLoopBackOff, 42 restarts: Caused by CertificateExpiredException => renew the certificate"
Enter
Sleep 3s
Type@15ms "# 🔴 connect-0 OOMKilled (exit code 137): OutOfMemoryError in task orders-sink-1 => raise the heap / pod memory"
Enter
Sleep 3s
Type@15ms "# 🟠 schemaregistry-0 not ready (503), and its log says SASL PLAIN authentication failed => check its credentials"
Enter
Sleep 3s
Type@15ms "# 👉 each category ends with the kubectl commands to run next and a link to the CFK troubleshooting docs"
Enter
Sleep 4s

# ── 5. the HTML report ──────────────────────────────────────────────────────
Type@15ms "# 🌐 The HTML report can be filtered by severity and component, with the context of every finding. Attach it to the case!"
Enter
Sleep 2s
Type "ls /tmp/cfk-bundle"
Sleep 500ms
Enter
Sleep 3s
Type@15ms "# It looks like this 👇"
Enter
Sleep 2s
