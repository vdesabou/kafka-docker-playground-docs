# playground ansible inventory delete

🗑️ Remove a yq path from the inventory, and print the change

## Usage

```bash
playground ansible inventory delete PATH
```

## Arguments

#### `PATH`

yq path, for example .all.vars.sasl_protocol

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

## Examples

```bash
playground ansible inventory delete .all.vars.sasl_protocol
```


