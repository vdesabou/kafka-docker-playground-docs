# playground schema delete

🧟 Delete schema  
  
Without --version the whole subject goes; with it, only that version.  
  
A plain delete is soft: the schema is hidden but its id and version  
number stay taken, so re-registering does not reuse them. Add  
--permanent to really remove it, which is what you need before  
re-creating the same subject from scratch.  
  
❕ The registry requires a soft delete before a permanent one; with  
   --permanent the command does both for you.

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

#### *--permanent*

💀 Hard delete (default is soft delete)

#### *--verbose, -v*

🐞 Show command being ran.


