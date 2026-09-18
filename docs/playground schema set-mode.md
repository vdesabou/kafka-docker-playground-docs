# playground schema set-mode

🔏 Set subject-level mode  
  
  READWRITE   the normal mode, schemas can be read and registered  
  READONLY    freeze the subject, registration is refused  
  IMPORT      allow registering schemas at a chosen id and version,  
              which is what a migration between registries needs  
  
⚠️ To enable mode changes on a Schema Registry cluster, you must also set  
mode.mutability=true in the Schema Registry properties file before  
starting Schema Registry, otherwise this command is rejected.

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


