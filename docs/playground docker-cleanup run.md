# playground docker-cleanup run

🧽 Free the disk of the container engine now, as the weekly job does

Use `--dry-run` to see what would be removed.

## Usage

```bash
playground docker-cleanup run [OPTIONS]
```

## Options

#### `--older-than DAYS`

📆 Remove the Confluent Platform versions not used for this number of days

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `60`

#### `--max-build-cache GB`

🧱 Build cache to keep, in GB: above it, the least recently used build cache is removed

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `10`

#### `--dry-run`

🔎 Only show what would be removed

## Examples

```bash
playground docker-cleanup run --dry-run
```

```bash
playground docker-cleanup run --older-than 30
```


