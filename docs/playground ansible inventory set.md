# playground ansible inventory set

✏️ Set the value of a yq path, and print the change

🎓 Tip: then `playground ansible playbook` (`--limit` `<host>` to apply it  
to one host only)

## Usage

```bash
playground ansible inventory set PATH VALUE
```

## Arguments

#### `PATH`

yq path, for example .all.vars.sasl_protocol

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `VALUE`

yaml value, for example plain, true, 100, or '{"num.partitions": 6}'

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

## Examples

```bash
playground ansible inventory set .all.vars.ssl_enabled true
```

```bash
playground ansible inventory set '.all.children.kafka_broker.vars.kafka_broker_custom_properties["num.partitions"]' 6
```

```bash
playground ansible inventory set .all.vars.kafka_broker_custom_listeners '{"client": {"name": "CLIENT", "port": 9093}}'
```


