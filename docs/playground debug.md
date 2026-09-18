# playground debug

🐞 Debug commands  
  
The heavy tooling, made usable: the JDK utilities, tcpdump, iptables and  
the analysis tools are run inside the right container, installed on the  
fly when missing, and their output is brought back to your machine.  
  
🐌 It hangs, or it is slow  
  thread-dump         what every thread is doing right now  
  flight-recorder     record the JVM over a period, open it in JMC  
  gc-analyze          GC pauses, heap trends and tuning advice  
  
💾 It eats memory  
  heap-dump           take a .hprof, optionally as a histogram  
  heap-analyze        run Eclipse MAT on it, leak suspects report  
  
🌐 It is a network or TLS problem  
  tcp-dump            capture traffic, open it in Wireshark  
  testssl             probe a TLS endpoint, locally or in the cloud  
  block-traffic       cut a route with iptables, to simulate an outage  
  java-debug          turn on the JVM SSL, Kerberos or class loading traces  
  
🔬 It is in the code  
  log-level set       raise the level of any package, without a restart  
  enable-remote-debugging   attach your IDE debugger to a container  
  jscissors           trace method calls, arguments and return values  
  
📦 Hand it over  
  generate-diagnostics   a support bundle for connect or broker

## Usage

```bash
playground debug COMMAND
```

## == Commands ==

- [enable-remote-debugging](playground%20debug%20enable-remote-debugging) - ✨ Enable java remote debugging for container
- [disable-remote-debugging](playground%20debug%20disable-remote-debugging) - 🛑 Disable java remote debugging for container
- [testssl](playground%20debug%20testssl) - 🔐 Testing TLS/SSL encryption using https://testssl.sh/
- [generate-diagnostics](playground%20debug%20generate-diagnostics) - ⛑️ Generate a diagnostic bundle with Diagnostics Bundle Tool
- [thread-dump](playground%20debug%20thread-dump) - 🎯 Take a java thread dump
- [heap-dump](playground%20debug%20heap-dump) - 👻 Take a heap dump
- [heap-analyze](playground%20debug%20heap-analyze) - 🔬 Analyze a heap dump file using Eclipse MAT (Memory Analyzer Tool)
- [gc-analyze](playground%20debug%20gc-analyze) - 📈 Analyze JVM Garbage Collection logs
- [tcp-dump](playground%20debug%20tcp-dump) - 🕵️‍♂️ Take a tcp dump (sniffing network)
- [block-traffic](playground%20debug%20block-traffic) - 🚫 Blocking traffic using iptables
- [java-debug](playground%20debug%20java-debug) - 🤎 JVM arguments for SSL, Kerberos or Class Loading
- [jscissors](playground%20debug%20jscissors) - ✂️ jscissors is an instrumentation framework and can help to analyse control flow and perform some specific logging
- [flight-recorder](playground%20debug%20flight-recorder) - 🛩️ Record flight recorder
- [log-level](playground%20debug%20log-level) - 🧬 Set log level for any package

## Debug commands

- [cfk](playground%20debug%20cfk) - 🧱 CFK debug sub-commands
- [cfk-bundle-analyze](playground%20debug%20cfk%20cfk-bundle-analyze) - 📦 Analyze a Confluent for Kubernetes (CFK) support bundle
- [generate-bundle](playground%20debug%20cfk%20generate-bundle) - ⛑️ Generate a Support bundle


