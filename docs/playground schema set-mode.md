# playground schema set-mode

🔏 Set subject-level mode  
  
To enable mode changes on a Schema Registry cluster, you must also set mode.mutability=true in the Schema Registry properties file before starting Schema Registry

## Usage

```bash
playground schema set-mode [OPTIONS]
```

## Options

#### *--subject SUBJECT*

📛 Subject name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--verbose, -v*

🐞 Show command being ran.

#### *--mode MODE*

Schema Registry mode

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes
| Allowed Values: | IMPORT, READONLY, READWRITE


