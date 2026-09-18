# playground secrets list

📋 List stored credentials  
  
Values are never printed: secrets are shown as a masked fingerprint  
(last 4 characters and a sha256 prefix), which is enough to tell whether  
it is the token you rotated yesterday. Plain variables are shown as is.  
  
Two markers to look out for:  
  
  ⚠️ overridden by the environment   an exported variable is what the  
                                    example will actually get  
  ❌ cannot be resolved              the reference is there but the  
                                    backend gave nothing back, usually  
                                    a locked session or a deleted item

## Usage

```bash
playground secrets list [OPTIONS]
```

## Options

#### *--show-source*

🔗 Show the backend reference instead of the fingerprint

#### *--profile PROFILE*

🗂️ Secrets profile to use (default is the active one)

## Examples

```bash
playground secrets list
```

```bash
playground secrets list --profile customer-123456
```


