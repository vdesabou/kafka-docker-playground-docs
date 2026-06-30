# playground container cp

🪄 Copy files between local filesystem and container

## Usage

```bash
playground container cp [OPTIONS]
```

## Options

#### *--source SOURCE*

📥 Source path (local path or container:path)

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--destination DESTINATION*

📤 Destination path (local path or container:path)

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

## Examples

```bash
playground container cp --source ./file.txt --destination connect:/tmp/file.txt
```

```bash
playground container cp --source connect:/tmp/file.txt --destination ./file.txt
```


