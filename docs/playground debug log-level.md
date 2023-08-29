# playground debug log-level

🧬 Set log level for any package

## Usage

```bash
playground debug log-level COMMAND
```

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

## == Commands ==

- [get](playground%20debug%20log-level%20get) - Get log levels
- [set](playground%20debug%20log-level%20set) - Set log level for specific logger


