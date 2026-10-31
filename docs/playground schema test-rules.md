# playground schema test-rules

📏 Test the data contract rules of a subject against records

Sends each record through the real serializer (the console producer of  
the schema-registry container, use.latest.version=true) with the  
schema and rule set of the version, into a temporary topic and subject  
deleted afterwards: ✅ the record passes the rules, ❌ which rule  
failed and its expression (Rule failed: amountPositive, Expr failed:  
'message.amount \> 0'). Nothing is written to the topics of the subject.

Exit code: 0 when every record passes, 1 otherwise.

❕ The rules are only kept by a Schema Registry with  
resource.extension.class=io.confluent.kafka.schemaregistry.rulehandler.RuleSetResourceExtension  
(`playground schema register` warns when they were dropped). Plaintext  
environment only, schemas without references.

## Usage

```bash
playground schema test-rules [OPTIONS]
```

## Options

#### `--subject SUBJECT`

📛 Subject name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--version VERSION`

🔢 Version whose rules are tested (default: latest, what a producer with use.latest.version=true uses)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `latest`

#### `--record RECORD`

📦 A record (json), repeatable; default: stdin, one json per line

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--json`

📗 Print the result as JSON, and nothing else

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground schema test-rules --subject orders-value --record '{"id": 1, "amount": 5.0}' --record '{"id": 2, "amount": -1.0}'

playground schema test-rules --subject orders-value < records.jsonl

```


