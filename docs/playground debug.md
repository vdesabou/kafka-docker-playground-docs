# playground debug

🐞 Debug commands

The heavy tooling, made usable: the JDK utilities, tcpdump, iptables and  
the analysis tools are run inside the right container, installed on the  
fly when missing, and their output is brought back to your machine.

**🐌 It hangs, or it is slow**

- **thread-dump**: what every thread is doing right now
- **flight-recorder**: record the JVM from start to stop, then analyze it

**💾 It eats memory, or runs short of resources**

- **heap-dump**: take a .hprof, optionally as a histogram
- **resources**: limit cpus and memory on the fly, fill the disk

**🌐 It is a network or TLS problem**

- **tcp-dump**: capture traffic, analyze it, open it in Wireshark
- **testssl**: probe a TLS endpoint, locally or in the cloud
- **block-traffic**: cut a route with iptables, to simulate an outage
- **degrade-traffic**: add latency, packet loss or corruption with tc
- **dns**: fake the DNS answers of a hostname: NXDOMAIN, a wrong ip, a slow resolver
- **java-debug**: turn on the JVM SSL, Kerberos or class loading traces

**⏰ It depends on the time**

- **clock**: shift the clock of a container (libfaketime)

**🔬 It is in the code**

- **log-level set**: raise the level of any package, without a restart
- **enable-remote-debugging**: attach your IDE debugger to a container
- **jscissors**: trace method calls, arguments and return values

**📦 Hand it over**

- **generate-diagnostics**: a support bundle for connect or broker

🔎 To analyze what you collected (thread dumps, GC logs, heap dumps,  
logs, Oracle XStream reports, CFK bundles, flight recordings, network  
captures): playground analyze

## Usage

```bash
playground debug COMMAND
```

## Commands

- [block-traffic](playground%20debug%20block-traffic) - 🚫 Blocking traffic using iptables
- [clock](playground%20debug%20clock) - ⏰ Shift the clock of a container: token, ticket and certificate expiry, time based partitioning
- [degrade-traffic](playground%20debug%20degrade-traffic) - 🐌 Add latency, packet loss, corruption or a bandwidth limit using tc
- [disable-remote-debugging](playground%20debug%20disable-remote-debugging) - 🛑 Disable java remote debugging for container
- [dns](playground%20debug%20dns) - 🔤 Break the name resolution of a hostname inside a container: NXDOMAIN, a wrong ip, a slow resolver
- [enable-remote-debugging](playground%20debug%20enable-remote-debugging) - ✨ Enable java remote debugging for container
- [flight-recorder](playground%20debug%20flight-recorder) - 🛩️ Record a JVM with Java Flight Recorder, from `--action` start to `--action` stop
- [generate-diagnostics](playground%20debug%20generate-diagnostics) - ⛑️ Generate a diagnostic bundle with Diagnostics Bundle Tool
- [heap-dump](playground%20debug%20heap-dump) - 👻 Take a heap dump
- [java-debug](playground%20debug%20java-debug) - 🤎 JVM arguments for SSL, Kerberos or Class Loading
- [jscissors](playground%20debug%20jscissors) - ✂️ Trace the calls of any method of a running JVM: arguments, return values, durations, exceptions, call tree
- [log-level](playground%20debug%20log-level) - 🧬 Set log level for any package
  - [get](playground%20debug%20log-level%20get) - Get log levels
  - [set](playground%20debug%20log-level%20set) - Set log level for specific logger
- [resources](playground%20debug%20resources) - 🏋️ Limit the cpus and memory of a running container, or fill its disk: OOM, GC pressure, disk full
- [tcp-dump](playground%20debug%20tcp-dump) - 🕵️‍♂️ Take a tcp dump (sniffing network)
- [testssl](playground%20debug%20testssl) - 🔐 Testing TLS/SSL encryption using https://testssl.sh/
- [thread-dump](playground%20debug%20thread-dump) - 🎯 Take a java thread dump

## Debug commands

- [cfk](playground%20debug%20cfk) - 🧱 CFK debug sub-commands
  - [generate-bundle](playground%20debug%20cfk%20generate-bundle) - ⛑️ Generate a Support bundle
  - [sourcecode](playground%20debug%20cfk%20sourcecode) - 🧑‍💻 Source code of the CFK operator at the version of a cluster or of a support bundle


