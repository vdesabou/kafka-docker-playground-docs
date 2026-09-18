# playground secrets

🔐 Credentials required by examples  
  
Examples declare the environment variables they need. Store them once here  
and 'playground run' loads them automatically, picking only the ones the  
example at hand declares:  
  
  playground secrets set SALESFORCE_PASSWORD    🔐 store it, prompted  
  playground secrets check -f \<example\>         ✅ what is still missing  
  playground run -f \<example\>                   🚀 loaded for you  
  
📂 Where it is stored  
  
In ~/.config/kafka-docker-playground, never in the repository, so it  
survives 'git clean -fdx' and can never be committed by mistake:  
  
  secrets.ini  0600  credentials, as a reference to the backend  
                     ('op://...', 'keychain:...'), not as a value  
  env.ini      0644  plain variables, in clear text  
  
A name containing PASSWORD, PASSPHRASE, SECRET, TOKEN, KEY, CREDS, PWD or  
LICENSE is treated as a credential, anything else as a plain variable  
(GCP_PROJECT, AWS_REGION, an account name, a URL). Use 'secrets set  
--secret' or '--plain' to decide yourself.  
  
🏦 Backends  
  
Where the credential values themselves are kept:  
  
  keychain     macOS Keychain  
  secret-tool  freedesktop secret service (GNOME Keyring, KWallet)  
  pass         the standard unix password manager  
  op           1Password, through the 'op' CLI  
  vault        HashiCorp Vault  
  file         clear text in secrets.ini, no encryption, last resort  
  
With no configuration, the first available of keychain (macOS), then  
secret-tool, then pass is used, and file is the fallback. op and vault  
are never picked automatically, so that an example never blocks on an  
unlock prompt. Choose one explicitly with:  
  
  playground secrets backend op  
  
op creates and rotates the items it stores. vault is reference-only:  
create the secret in Vault, then point a variable at it. Any backend can  
also reuse a secret you already have, instead of storing a new one:  
  
  playground secrets link SALESFORCE_PASSWORD op://Private/sfdc/password  
  
🗂️ Profiles  
  
A profile is an independent set of variables, typically one per customer  
or per support case, so last week's credentials never leak into this  
week's reproduction model:  
  
  playground secrets profile customer-123456    🗂️ switch to it  
  playground secrets profile                    📋 list them, with counts  
  playground secrets list --profile default     🎯 use one just this once  
  
Lookup falls back to the 'default' profile, so what is shared between all  
of them (CONFLUENT_LICENSE, NGROK_AUTH_TOKEN) is stored there once.  
  
🔍 Resolution order  
  
  1. an exported environment variable, which always wins  
  2. the active profile  
  3. the default profile  
  
So 'export FOO=bar' and 'source secret.properties' keep working, and  
'playground secrets list' flags what the environment overrides.  
  
⚙️ Configuration  
  
  playground config set secrets.backend \<backend\>      🏦 see above  
  playground config set secrets.profile \<name\>         🗂️ active profile  
  playground config set secrets.op-vault \<vault\>       🔑 1Password vault  
  
PLAYGROUND_SECRETS_DIR, PLAYGROUND_SECRETS_BACKEND,  
PLAYGROUND_SECRETS_PROFILE and PLAYGROUND_OP_VAULT override them for a  
single command.

## Usage

```bash
playground secrets COMMAND
```

## Secrets commands

- [set](playground%20secrets%20set) - 🔐 Store a credential
- [get](playground%20secrets%20get) - 🔍 Show a stored credential (masked unless --reveal is used)
- [unset](playground%20secrets%20unset) - 🗑️ Remove a stored credential
- [list](playground%20secrets%20list) - 📋 List stored credentials
- [link](playground%20secrets%20link) - 🔗 Point a variable at a secret manager, without storing any value
- [check](playground%20secrets%20check) - ✅ Show what an example needs, and what is missing
- [env](playground%20secrets%20env) - 🐚 Export what an example needs into the current shell
- [import](playground%20secrets%20import) - 📥 Import an existing secret.properties / variable.properties file
- [export](playground%20secrets%20export) - 📤 Write every credential of a profile to a file, in clear text
- [edit](playground%20secrets%20edit) - ✏️ Open the store in your editor
- [backend](playground%20secrets%20backend) - 🏦 Show or change where secrets are kept
- [profile](playground%20secrets%20profile) - 🗂️ Show or switch the active profile
- [scan](playground%20secrets%20scan) - 🔎 Look for stored credentials in clear text in the repository


