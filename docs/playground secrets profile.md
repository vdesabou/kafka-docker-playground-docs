# playground secrets profile

🗂️ Show or switch the active profile  
  
A profile is an independent set of variables. Without an argument it  
lists them all with their variable count, and marks the active one.  
  
A variable missing from the active profile is looked up in 'default',  
so what is shared between all of them (CONFLUENT_LICENSE,  
NGROK_AUTH_TOKEN) only needs to be stored once, there.  
  
Switching is persistent, it writes the config key secrets.profile. To  
use another one just for a command, every secrets command takes  
--profile.  
  
🎓 Tip: use one profile per support case, so last week's customer  
credentials never leak into this week's reproduction model.

## Usage

```bash
playground secrets profile [PROFILE]
```

## Arguments

#### *PROFILE*

🗂️ Profile to activate

## Examples

```bash
playground secrets profile
```

```bash
playground secrets profile customer-123456
```


