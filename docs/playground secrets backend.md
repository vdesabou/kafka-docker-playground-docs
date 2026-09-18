# playground secrets backend

🏦 Show or change where secrets are kept  
  
  keychain     macOS Keychain, through 'security'  
  secret-tool  freedesktop secret service (GNOME Keyring, KWallet)  
  pass         the standard unix password manager  
  op           1Password, through the 'op' CLI  
  vault        HashiCorp Vault, through the 'vault' CLI  
  file         clear text in secrets.ini, no encryption, last resort  
  
With no configuration, the first available of keychain (macOS),  
secret-tool and pass is used, and file is the fallback. op and vault  
have to be chosen here, so that an example never blocks on an unlock  
prompt halfway through.  
  
Only new values are affected: what is already stored keeps being read  
from, and rotated in, the backend it went to.  
  
vault is reference-only, playground never writes to it: create the  
secret there, then use 'playground secrets link'. op creates the item  
for you, named kdp-\<profile\>-\<NAME\> in the vault set by  
'playground config set secrets.op-vault' (default: Private), and can  
also point at an existing one with 'playground secrets link'.

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


