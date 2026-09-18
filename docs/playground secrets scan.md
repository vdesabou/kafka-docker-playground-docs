# playground secrets scan

🔎 Look for stored credentials in clear text in the repository  
  
Resolves every credential of the profile and greps the working tree,  
tracked and untracked files alike, for the values themselves. Catches  
the password pasted into a reproduction model, which no pattern based  
scanner would recognise.  
  
Plain variables are skipped, a region or a bucket name is expected to  
appear in an example, and so are values shorter than 8 characters,  
which would match everywhere. Exits 1 as soon as one is found.  
  
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


