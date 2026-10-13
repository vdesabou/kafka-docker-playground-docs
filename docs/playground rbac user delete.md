# playground rbac user delete

🗑️ Delete an LDAP user, and remove it from its groups  
  
Its role bindings and ACLs are not deleted.

## Usage

```bash
playground rbac user delete [OPTIONS]
```

## Options

#### *--user, -u USER*

🧑 User name (principal User:\<user\>)

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--verbose, -v*

🐞 Show command being ran.

## Examples

```bash
playground rbac user delete --user bob
```


