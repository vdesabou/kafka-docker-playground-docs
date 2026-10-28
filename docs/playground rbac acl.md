# playground rbac acl

🚦 ACL commands

By default, ACLs are MDS centralized ACLs (stored in the  
_confluent-metadata-auth topic and enforced by the CONFLUENT access rule  
provider). With `--kafka-acls`, they are regular Kafka ACLs created with  
kafka-acls (`ZK_ACL` or `KRAFT_ACL` access rule provider).

⛅ On a Confluent Cloud run, they are the ACLs of the Confluent Cloud  
cluster (confluent kafka acl). `--connector` then uses the service  
account of a fully managed connector created with  
`playground run --ccloud-service-account as principal, to reproduce`  
authorization errors: delete or deny one of its ACLs, then restart the  
connector.

🎬 Bite size session: https://kafka-docker-playground.io/#/sessions?id=%F0%9F%91%A4-a-fully-managed-connector-with-a-service-account-loses-an-acl

## Usage

```bash
playground rbac acl COMMAND
```

## RBAC commands

- [create](playground%20rbac%20acl%20create) - 🚦 Create ACLs, one per `--operation`
- [delete](playground%20rbac%20acl%20delete) - 🗑️ Delete ACLs, one per `--operation`
- [list](playground%20rbac%20acl%20list) - 📋 List ACLs


