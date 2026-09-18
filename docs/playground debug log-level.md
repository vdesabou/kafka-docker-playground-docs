# playground debug log-level

🧬 Set log level for any package  
  
Changes the level of any logger on the running connect worker, straight  
away and without a restart, so you do not have to edit log4j properties  
and rebuild the container.  
  
🎓 Tip: raise only the package you suspect, for instance  
io.confluent.connect.s3 or org.apache.kafka.clients.consumer, rather  
than the root logger, or the useful lines will be lost in the noise.

## Usage

```bash
playground debug log-level COMMAND
```

## == Commands ==

- [get](playground%20debug%20log-level%20get) - Get log levels
- [set](playground%20debug%20log-level%20set) - Set log level for specific logger

## Examples

```bash
playground debug log-level get
```

```bash
playground debug log-level get -p io.confluent.connect.oracle.cdc
```

```bash
playground debug log-level get --package io.confluent.connect.oracle.cdc
```

```bash
playground debug log-level set -p io.confluent.connect.oracle.cdc.logging.LogUtils -l TRACE
```


