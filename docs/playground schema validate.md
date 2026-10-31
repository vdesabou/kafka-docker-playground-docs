# playground schema validate

🧪 Register schemas in a throwaway Schema Registry of each CP version, and compare the verdicts

Answers "a schema registered years ago is refused after the upgrade"  
without upgrading anything: for each `--cp-version`, a Schema Registry  
container of that version starts next to the broker of the running  
environment (its own kafkastore topic, both deleted afterwards), and  
the schemas are registered in `--subject` in the order given, so a  
v1 then v2 also shows the compatibility checks of each version.

Each registry starts empty with the default settings of its version  
(validation of new schemas is on since CP 8.2.0, with the stricter  
namespaces of Avro 1.12).

Exit code: 0 when every schema is accepted by every version, 1  
otherwise. Needs a running docker environment (not ccloud / cfk). CP  
5.x / 6.0 registries can't talk to a CP 8 broker.

## Usage

```bash
playground schema validate [OPTIONS]
```

## Options

#### `--cp-version VERSION`

🏷️ CP version of a Schema Registry to try (repeat it: `--cp-version` 7.9.2 `--cp-version` 8.2.0)

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes
| Repeatable:     |  ✓ Yes

#### `--schema SCHEMA`

🔥 A schema: @`<file>`, a file path or the schema itself (repeatable, registered in that order); default: stdin

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--subject SUBJECT`

📛 Subject to register in (default validate-value)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `validate-value`

#### `--keep`

🐳 Keep the Schema Registry containers and their topics (to look at their logs or settings)

#### `--json`

📗 Print the result as JSON, and nothing else

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground schema validate --cp-version 7.9.2 --cp-version 8.2.0 < legacy.avsc

playground schema validate --cp-version 7.9.2 --cp-version 8.4.0 --schema @v1.avsc --schema @v2.avsc --json

```


