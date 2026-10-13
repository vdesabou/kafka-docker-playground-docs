# playground rbac user add

➕ Add an LDAP user  
  
The user can connect right away. MDS picks up new group  
memberships (for Group:\<name\> role bindings) within its LDAP  
refresh interval (60 seconds by default).

## Usage

```bash
playground rbac user add [OPTIONS]
```

## Options

#### *--user, -u USER*

🧑 User name (principal User:\<user\>)

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--password PASSWORD*

🔑 Password  
  
ℹ️ If not set, \<user\>-secret

#### *--group, -g GROUP*

👥 Group to add the user to (principal Group:\<group\>), created if it does not exist. Can be set several times.

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### *--verbose, -v*

🐞 Show command being ran.

## Examples

```bash
playground rbac user add --user bob
```

```bash
playground rbac user add --user bob --password bob-pwd --group KafkaDevelopers
```


