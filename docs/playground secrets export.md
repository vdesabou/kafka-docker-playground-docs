# playground secrets export

📤 Write every credential of a profile to a file, in clear text  
  
❗ Only for the rare case where a tool needs a properties file ❗

## Usage

```bash
playground secrets export [OPTIONS]
```

## Options

#### *--file FILE*

📄 Destination file, outside the repository

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--yes-i-want-plaintext*

🔓 Required, this writes credentials in clear text

#### *--profile PROFILE*

🗂️ Secrets profile to use (default is the active one)

## Examples

```bash
playground secrets export --file ~/kdp-secrets.properties --yes-i-want-plaintext
```


