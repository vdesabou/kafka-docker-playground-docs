# playground schema history

📜 Timeline of the Schema Registry, from its _schemas topic

Every registration, soft and permanent delete (and the ids that stop  
resolving because of it), compatibility, mode and setting change, with  
its date: answers "who deleted the schema, when, soft or hard?" and  
"when was the rule relaxed?".

Reads the kafkastore topic of the running environment (_schemas, or  
_schemas_`<name>`_`<namespace>` with CFK, see `--topic`), or a dump with -f:  
the output of `playground topic consume -t _schemas --json`, or of  
kafka-console-consumer `--topic` _schemas `--from-beginning`  
`--property` print.key=true `--property` print.timestamp=true, which is  
what to ask a customer for.

Not available on Confluent Cloud, which doesn't expose _schemas: use  
the audit logs of the organization instead.

The temporary subjects of 'schema check-compatibility' and 'schema  
diff' are hidden (`--include-temporary` to show them).

## Usage

```bash
playground schema history [OPTIONS]
```

## Options

#### `--subject SUBJECT`

📛 Only the events of this subject (the ids are still tracked across subjects)

#### `--since SINCE`

🕰️ Only the events after: 12h, 30m, 2d, or a date (2026-10-31, 2026-10-31T10:00)

#### `--file, -f FILE`

📄 A dump of the _schemas topic instead of the running environment (JSON lines of 'topic consume `--json`', or kafka-console-consumer with print.key and print.timestamp)

#### `--topic TOPIC`

📛 The kafkastore.topic of the Schema Registry (default: _schemas, else the first topic starting with _schemas)

#### `--include-temporary`

👻 Also show the temporary subjects of check-compatibility and diff

#### `--json`

📗 Print the result as JSON, and nothing else

#### `--verbose, -v`

🐞 Show command being ran.

#### `--cluster CLUSTER`

🌍 Cluster to use in an mdc-\* environment (us or europe)

Default: the `PLAYGROUND_CLUSTER` environment variable, else the value set with `playground state set run.cluster <cluster>`. Ignored in the other environments.

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `us`, `europe`

## Examples

```bash
playground schema history
```

```bash
playground schema history --subject orders-value --since 2d
```

```bash
playground schema history -f customer-schemas-dump.txt --json | jq .summary
```


