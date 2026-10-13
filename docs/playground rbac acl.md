# playground rbac acl

🚦 ACL commands  
  
By default, ACLs are MDS centralized ACLs (stored in the  
_confluent-metadata-auth topic and enforced by the CONFLUENT access rule  
provider). With --kafka-acls, they are regular Kafka ACLs created with  
kafka-acls (ZK_ACL or KRAFT_ACL access rule provider).

## Usage

```bash
playground rbac acl COMMAND
```

## RBAC commands

- [create](playground%20rbac%20acl%20create) - 🚦 Create ACLs, one per --operation
- [delete](playground%20rbac%20acl%20delete) - 🗑️ Delete ACLs, one per --operation
- [list](playground%20rbac%20acl%20list) - 📋 List ACLs


