# playground rbac user

🧑 LDAP user commands (Keycloak clients on rbac-oauth)

Users live in the openldap container. They authenticate on the broker  
with SASL/PLAIN (their LDAP password) and log in to MDS, Control  
Center, Schema Registry and Connect REST API with basic auth.  
Changes apply to the running environment, without restart.

On rbac-oauth, users are the clients of the Keycloak realm kafka  
(client_credentials grant): `--user` is the client id, `--password` its  
secret, `--group` a Keycloak group (groups claim of the token, principal  
Group:`<group>`).

## Usage

```bash
playground rbac user COMMAND
```

## RBAC commands

- [add](playground%20rbac%20user%20add) - ➕ Add an LDAP user (a Keycloak client on rbac-oauth)
- [delete](playground%20rbac%20user%20delete) - 🗑️ Delete an LDAP user, and remove it from its groups (the Keycloak client on rbac-oauth)
- [list](playground%20rbac%20user%20list) - 📋 List LDAP users and their groups (Keycloak clients, secrets and groups on rbac-oauth)


