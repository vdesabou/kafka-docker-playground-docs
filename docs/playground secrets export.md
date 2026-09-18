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

#### *--only ONLY*

🎯 Export only the credentials, only the plain variables, or both

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | all
| Allowed Values: | secret, plain, all

#### *--profile PROFILE*

🗂️ Secrets profile to use (default is the active one)

## Examples

```bash
playground secrets export --file ~/kdp-secrets.properties --yes-i-want-plaintext
```

```bash
playground secrets export --file ~/kdp-vars.properties --only plain --yes-i-want-plaintext
```


