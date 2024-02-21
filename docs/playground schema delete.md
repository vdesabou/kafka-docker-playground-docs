# playground schema delete

🧟 Delete schema

## Usage

```bash
playground schema delete [OPTIONS]
```

## Options

#### *--subject SUBJECT*

📛 Subject name to delete:  
    
  if --version is provided, only that version will be deleted. Otherwise the complete subject will be deleted

#### *--version VERSION*

🔢 Schema version of the provided subject to delete  
  
Can only be used when --subject is provided

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | *--id*

#### *--id ID*

🫵 Schema id  
  
Can only be used when --subject is provided

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | *--version*

#### *--permanent*

💀 Hard delete (default is soft delete)

#### *--verbose, -v*

🐞 Show command being ran.


