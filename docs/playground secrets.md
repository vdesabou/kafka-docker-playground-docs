# playground secrets

🔐 Credentials required by examples  
  
Stored outside the repository, in ~/.config/kafka-docker-playground, so that  
they survive 'git clean -fdx' and can never be committed by mistake.  
  
🎓 Tip: an exported environment variable always wins over the store, so  
'export FOO=bar' and 'source secret.properties' keep working.

## Usage

```bash
playground secrets COMMAND
```

## == Commands ==

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


