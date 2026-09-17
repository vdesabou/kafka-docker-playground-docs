# playground secrets backend

🏦 Show or change where secrets are kept  
  
keychain (macOS), secret-tool (Linux), pass, op (1Password), vault  
(HashiCorp) or file.  
  
op and vault are reference-only: create the item there, then use  
'playground secrets link'.

## Usage

```bash
playground secrets backend [BACKEND]
```

## Arguments

#### *BACKEND*

🏦 Backend to use

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | keychain, secret-tool, pass, op, vault, file

## Examples

```bash
playground secrets backend
```

```bash
playground secrets backend op
```


