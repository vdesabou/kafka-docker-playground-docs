# playground secrets set

🔐 Store a credential  
  
Without --value the value is prompted without echo, so it never lands in  
the shell history.  
  
A name that looks like a credential (PASSWORD, SECRET, TOKEN, KEY, CREDS,  
PWD, PASSPHRASE, LICENSE) goes to the secure backend, anything else is  
kept as a plain variable. Use --secret or --plain to decide yourself.

## Usage

```bash
playground secrets set NAME [OPTIONS]
```

## Arguments

#### *NAME*

🔑 Environment variable name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

## Options

#### *--value VALUE*

🔓 Value to store  
  
❗ it will be visible in your shell history, prefer the prompt ❗

#### *--secret*

🔐 Treat the value as a credential, whatever the variable name is  
  
It goes to the secure backend (keychain, 1Password, pass…) instead of  
being kept in clear text.

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | *--plain*

#### *--plain*

📝 Treat the value as a non sensitive variable  
  
It is kept in clear text in env.ini, which is handy for a URL, an  
account name or a project id.

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | *--secret*

#### *--profile PROFILE*

🗂️ Secrets profile to use (default is the active one)

## Examples

```bash
playground secrets set SALESFORCE_PASSWORD
```

```bash
playground secrets set NGROK_AUTH_TOKEN --value 2abcDEF...
```

```bash
playground secrets set GCP_PROJECT --value my-gcp-project
```

```bash
playground secrets set MY_API_CREDENTIAL --secret
```


