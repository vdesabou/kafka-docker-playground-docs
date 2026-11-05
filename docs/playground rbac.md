# playground rbac

🛡️ RBAC commands (rbac-sasl-plain and cfk-rbac environments, plus Confluent Cloud ACLs)

Change permissions of the running rbac-sasl-plain or cfk-rbac environment  
without opening a shell in a container: the commands call the MDS REST API  
(http://localhost:8091, a port-forward to the kafka service on cfk-rbac) as  
superUser.

- **role-binding**: create, delete and list role bindings
- **user**: add, delete and list LDAP users and their groups
- **acl**: create, delete and list ACLs (MDS centralized ACLs, or regular Kafka ACLs with `--kafka-acls`). On a Confluent Cloud run, ACLs of the Confluent Cloud cluster

🎓 Tip: principals are User:`<name>` or Group:`<name>`, a bare name means User:`<name>`.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-secured-environments  
🎬 Bite size session: https://kafka-docker-playground.io/#/sessions?id=%F0%9F%94%90-the-same-example-under-sasl_ssl-and-rbac

## Usage

```bash
playground rbac COMMAND
```

## RBAC commands

- [role-binding](playground%20rbac%20role-binding) - 🔐 Role binding commands
  - [create](playground%20rbac%20role-binding%20create) - 🔐 Create a role binding
  - [delete](playground%20rbac%20role-binding%20delete) - 🗑️ Delete a role binding
  - [list](playground%20rbac%20role-binding%20list) - 📋 List role bindings
- [user](playground%20rbac%20user) - 🧑 LDAP user commands
  - [add](playground%20rbac%20user%20add) - ➕ Add an LDAP user
  - [delete](playground%20rbac%20user%20delete) - 🗑️ Delete an LDAP user, and remove it from its groups
  - [list](playground%20rbac%20user%20list) - 📋 List LDAP users and their groups
- [acl](playground%20rbac%20acl) - 🚦 ACL commands
  - [create](playground%20rbac%20acl%20create) - 🚦 Create ACLs, one per `--operation`
  - [delete](playground%20rbac%20acl%20delete) - 🗑️ Delete ACLs, one per `--operation`
  - [list](playground%20rbac%20acl%20list) - 📋 List ACLs


