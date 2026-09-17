# playground secrets get

🔍 Show a stored credential (masked unless --reveal is used)

## Usage

```bash
playground secrets get NAME [OPTIONS]
```

## Arguments

#### *NAME*

🔑 Environment variable name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

## Options

#### *--reveal*

👀 Print the value in clear text  
  
❗ it will be visible in your terminal scrollback ❗

#### *--profile PROFILE*

🗂️ Secrets profile to use (default is the active one)

## Examples

```bash
playground secrets get SALESFORCE_PASSWORD
```

```bash
playground secrets get SALESFORCE_PASSWORD --reveal
```


