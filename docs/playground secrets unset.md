# playground secrets unset

🗑️ Remove a stored credential  
  
The value goes too, not only the reference: the keychain entry is  
deleted, the 1Password item is archived.  
  
A secret pointed at with 'playground secrets link' is left untouched,  
since it belongs to you and not to the playground.

| Attributes       | &nbsp;
|------------------|-------------
| Alias:           | delete, rm

## Usage

```bash
playground secrets unset NAME [OPTIONS]
```

## Arguments

#### *NAME*

🔑 Environment variable name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

## Options

#### *--profile PROFILE*

🗂️ Secrets profile to use (default is the active one)

## Examples

```bash
playground secrets unset SALESFORCE_PASSWORD
```


