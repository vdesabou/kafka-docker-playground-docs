# playground secrets scan

🔎 Look for stored credentials in clear text in the repository  
  
🎓 Tip: wire it as a pre-commit hook with  
'playground secrets scan --staged'

## Usage

```bash
playground secrets scan [OPTIONS]
```

## Options

#### *--staged*

📦 Scan the staged diff instead of the whole working tree

#### *--profile PROFILE*

🗂️ Secrets profile to use (default is the active one)

## Examples

```bash
playground secrets scan
```

```bash
playground secrets scan --staged
```


