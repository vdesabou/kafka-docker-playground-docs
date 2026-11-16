# playground ansible inventory get

🔎 Display the inventory, or the value of a yq path

## Usage

```bash
playground ansible inventory get [PATH]
```

## Arguments

#### `PATH`

yq path, for example .all.vars.confluent_package_version

## Examples

```bash
playground ansible inventory get
```

```bash
playground ansible inventory get .all.vars.confluent_package_version
```

```bash
playground ansible inventory get .all.children.kafka_connect.vars
```


