# playground rbac user

🧑 LDAP user commands  
  
Users live in the openldap container. They authenticate on the broker  
with SASL/PLAIN (their LDAP password) and log in to MDS, Control  
Center, Schema Registry and Connect REST API with basic auth.  
Changes apply to the running environment, without restart.

## Usage

```bash
playground rbac user COMMAND
```

## RBAC commands

- [add](playground%20rbac%20user%20add) - ➕ Add an LDAP user
- [delete](playground%20rbac%20user%20delete) - 🗑️ Delete an LDAP user, and remove it from its groups
- [list](playground%20rbac%20user%20list) - 📋 List LDAP users and their groups


