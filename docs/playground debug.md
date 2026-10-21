# playground debug

🐞 Debug commands

The heavy tooling, made usable: the JDK utilities, tcpdump, iptables and  
the analysis tools are run inside the right container, installed on the  
fly when missing, and their output is brought back to your machine.

**🐌 It hangs, or it is slow**

- **thread-dump**: what every thread is doing right now
- **flight-recorder**: record the JVM from start to stop, then analyze it

**💾 It eats memory**

- **heap-dump**: take a .hprof, optionally as a histogram

**🌐 It is a network or TLS problem**

- **tcp-dump**: capture traffic, open it in Wireshark
- **testssl**: probe a TLS endpoint, locally or in the cloud
- **block-traffic**: cut a route with iptables, to simulate an outage
- **degrade-traffic**: add latency, packet loss or corruption with tc
- **java-debug**: turn on the JVM SSL, Kerberos or class loading traces

**🔬 It is in the code**

- **log-level set**: raise the level of any package, without a restart
- **enable-remote-debugging**: attach your IDE debugger to a container
- **jscissors**: trace method calls, arguments and return values

**📦 Hand it over**

- **generate-diagnostics**: a support bundle for connect or broker

🔎 To analyze what you collected (thread dumps, GC logs, heap dumps,  
logs, Oracle XStream reports, CFK bundles, flight recordings): playground analyze

## Usage

```bash
playground debug COMMAND
```

## Commands

- [enable-remote-debugging](playground%20debug%20enable-remote-debugging) - ✨ Enable java remote debugging for container
- [disable-remote-debugging](playground%20debug%20disable-remote-debugging) - 🛑 Disable java remote debugging for container
- [testssl](playground%20debug%20testssl) - 🔐 Testing TLS/SSL encryption using https://testssl.sh/
- [generate-diagnostics](playground%20debug%20generate-diagnostics) - ⛑️ Generate a diagnostic bundle with Diagnostics Bundle Tool
- [thread-dump](playground%20debug%20thread-dump) - 🎯 Take a java thread dump
- [thread-analyze](playground%20debug%20thread-analyze) - Moved to `playground analyze thread-dump` (kept as a hidden alias)
- [heap-dump](playground%20debug%20heap-dump) - 👻 Take a heap dump
- [heap-analyze](playground%20debug%20heap-analyze) - Moved to `playground analyze heap-dump` (kept as a hidden alias)
- [analyze-logs](playground%20debug%20analyze-logs) - Moved to `playground analyze logs` (kept as a hidden alias)
- [gc-analyze](playground%20debug%20gc-analyze) - Moved to `playground analyze gc-logs` (kept as a hidden alias)
- [tcp-dump](playground%20debug%20tcp-dump) - 🕵️‍♂️ Take a tcp dump (sniffing network)
- [block-traffic](playground%20debug%20block-traffic) - 🚫 Blocking traffic using iptables
- [degrade-traffic](playground%20debug%20degrade-traffic) - 🐌 Add latency, packet loss, corruption or a bandwidth limit using tc
- [java-debug](playground%20debug%20java-debug) - 🤎 JVM arguments for SSL, Kerberos or Class Loading
- [jscissors](playground%20debug%20jscissors) - ✂️ jscissors is an instrumentation framework and can help to analyse control flow and perform some specific logging
- [flight-recorder](playground%20debug%20flight-recorder) - 🛩️ Record a JVM with Java Flight Recorder, from `--action` start to `--action` stop
- [log-level](playground%20debug%20log-level) - 🧬 Set log level for any package

## Debug commands

- [cfk](playground%20debug%20cfk) - 🧱 CFK debug sub-commands
- [cfk-bundle-analyze](playground%20debug%20cfk%20cfk-bundle-analyze) - Moved to `playground analyze cfk-bundle` (kept as a hidden alias)
- [generate-bundle](playground%20debug%20cfk%20generate-bundle) - ⛑️ Generate a Support bundle


