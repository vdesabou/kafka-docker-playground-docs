# playground secrets link

🔗 Point a variable at a secret manager, without storing any value  
  
The store then only contains a reference, which is safe to back up, sync  
between machines, or share with your team.  
  
Use it to reuse a secret that already exists, rather than storing a  
second copy of it, and for the vault backend which playground never  
writes to. The reference is resolved right away, so a typo or a locked  
session is reported on the spot.  
  
'playground secrets unset' drops the reference but leaves the secret  
itself alone.

## Usage

```bash
playground secrets link NAME REFERENCE [OPTIONS]
```

## Arguments

#### *NAME*

🔑 Environment variable name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *REFERENCE*

🔗 op://\<vault\>/\<item\>/\<field\>, vault://\<path\>#\<field\>,  
keychain:\<profile\>:\<NAME\>, secret-tool:\<profile\>:\<NAME\> or pass:\<path\>

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

## Options

#### *--profile PROFILE*

🗂️ Secrets profile to use (default is the active one)

## Examples

```bash
playground secrets link SALESFORCE_PASSWORD op://Private/salesforce/password
```

```bash
playground secrets link SNOWFLAKE_PASSWORD vault://secret/kdp/snowflake#password
```

```bash
playground secrets link CONFLUENT_LICENSE pass:work/confluent/license
```


