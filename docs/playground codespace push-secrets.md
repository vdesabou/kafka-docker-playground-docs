# playground codespace push-secrets

🔐 Send the secrets store to a codespace

Resolves every variable of the profile on your laptop (1Password, macOS  
Keychain…), then imports them into the secrets store of the codespace  
(backend file, ~/.config/kafka-docker-playground): credentials as  
credentials, plain variables as plain variables. `playground run` in the  
codespace then loads what each example declares, as on your laptop, and  
`playground secrets list` or 'check' work there. Nothing to install in the  
codespace, no 1Password token to give it.

The values are piped over 'gh codespace ssh', so no clear text copy is  
ever written locally and they never appear in 'ps'. In the codespace they  
are stored in clear text in secrets.ini (mode 0600), like any file backend.

The credentials that cannot be stored as name=value pairs are sent too,  
when they exist at the root of the repository (same as 'playground ec2  
push-secrets'):

- **aws_credentials_with_assuming_iam_role**: -\> ~/.aws/credentials-with-assuming-iam-role
- **aws_credentials_aws_account_with_assume_role -\> ~/.aws/credentials_aws_account_with_assume_role**
- **github_ssh_key_file**: -\> ~/.ssh/id_rsa

⚠️ 'Codespaces: Rebuild Container' empties the home directory: run it  
again after a rebuild.

Without `--codespace`, the most recently used codespace is used.

## Usage

```bash
playground codespace push-secrets [OPTIONS]
```

## Options

#### `--codespace, -c CODESPACE`

☁️ codespace name, as shown by `playground codespace list` (use completion)

🎓 Tip: if not specified, the most recently used codespace is used

#### `--profile PROFILE`

🗂️ Secrets profile to send (default is the active one), imported into the profile of the same name

#### `--dry-run`

🔍 List what would be sent, change nothing

## Examples

```bash
playground codespace push-secrets --dry-run
```

```bash
playground codespace push-secrets
```

```bash
playground codespace push-secrets --profile case-123456
```


