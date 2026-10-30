# playground connector smt test

🧪 Apply the transform chain (SMT) of a connector to a record, step by step

Shows what each transform changes (topic, key, value, headers, schema field by field), the result of each predicate, a record dropped by a transform, and the transform that throws with its config and its error. No topic or connector is created: the chain runs in a small harness in the connect container, with the classpath and the plugin.path of the worker, so the transforms, predicates and converters are the same classes and versions as in the worker.

The transforms come from a running connector (`--connector`) or from a connector config on stdin (or `--config` @file). The record is a json (`--record`): schemaless, or {"schema": ..., "payload": ...} like the JsonConverter for a record with a schema. Or a real record of a topic (`--from-topic`, `--offset`), converted with the converters of the connector (avro, protobuf, json schema with schema registry).

`--cp-version` runs the same test with the built-in transforms of other CP versions (throwaway cp-server-connect containers), `--smt-plugin` installs a Confluent Hub plugin for the test only (the worker is not changed), `--smt-jar` adds a jar (custom SMT development).

An html report of the steps (the value after each step with the added, changed and removed fields highlighted, the schema diff, the predicates, the error with its stack trace, and with `--cp-version` a comparison of the versions) is written to /tmp/playground-smt-test, and opened in the browser in an interactive terminal.

🎓 Tip: the connector config can be a whole connector config: only transforms.\*, predicates.\* and the converters are used.

## Usage

```bash
playground connector smt test [OPTIONS]
```

## Options

#### `--verbose, -v`

🐞 Show command being ran.

#### `--connector, -c CONNECTOR`

🔗 Use the transforms, predicates and converters of this running connector

#### `--config CONFIG`

📄 Connector config with the transforms (json, or @file), instead of `--connector` or stdin

#### `--record RECORD`

🧾 Record to transform (json, or @file): {"topic": "orders", "key": ..., "value": ..., "headers": {...}, "timestamp": `<ms>`}

key and value are schemaless json, or {"schema": ..., "payload": ...} for a record with a schema. Headers are typed like the SimpleHeaderConverter does (string, int64, float64, boolean, map, array), or {"schema": ..., "payload": ...}; give them as a list [{"key": ..., "value": ...}] for several headers with the same key. Default: a schemaless record with a value {"id": 1, "name": "foo"}

#### `--from-topic FROM-TOPIC`

🗳 Read the record from this topic instead of `--record`, and convert it with the converters of the connector

#### `--offset OFFSET`

📍 Offset of the record with `--from-topic` (default is 0)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `0`

#### `--partition PARTITION`

🧩 Partition of the record with `--from-topic` (default is 0)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `0`

#### `--type TYPE`

🔀 Build a sink or a source record (default: the type of `--connector`, sink otherwise)

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `sink`, `source`

#### `--cp-version CP-VERSION`

🔢 Run the test with the built-in transforms of these CP versions (repeat the flag), in throwaway cp-server-connect containers, to compare them. The plugins of the running worker are not available there, only `--smt-plugin` and `--smt-jar`

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--smt-plugin SMT-PLUGIN`

🧩 Confluent Hub plugin with transforms, installed for the test only (owner/name:version), e.g. confluentinc/connect-transforms:1.6.2

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--smt-jar SMT-JAR`

☕ Jar with transforms to add for the test (custom SMT development). Repeat it for the jars it depends on: they are loaded together, as one plugin

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--json`

📄 Print the steps as json

#### `--no-open`

🚫 Do not open the html report in the browser (it is still written, and its path printed)

#### `--cluster CLUSTER`

🌍 Cluster to use in an mdc-\* environment (us or europe)

Default: the `PLAYGROUND_CLUSTER` environment variable, else the value set with `playground state set run.cluster <cluster>`. Ignored in the other environments.

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `us`, `europe`

## Examples

```bash
playground connector smt test --connector filestream-sink
```

```bash
playground connector smt test --connector filestream-sink --record '{"topic":"filestream","key":"k1","value":{"id":1,"name":"foo"}}'
```

```bash
playground connector smt test --connector my-sink --from-topic orders --offset 42
```

```bash
playground connector smt test --record @record.json --config @transforms.json --cp-version 7.9.0 --cp-version 8.3.2
```

```bash
playground connector smt test --connector my-sink --smt-plugin confluentinc/connect-transforms:1.6.2
```


