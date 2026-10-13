# playground rbac acl create

🚦 Create ACLs, one per --operation

## Usage

```bash
playground rbac acl create [OPTIONS]
```

## Options

#### *--principal, -p PRINCIPAL*

🧑 Principal, User:\<name\> or Group:\<name\> (a bare name means User:\<name\>)

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--operation, -o OPERATION*

⚙️ Operation, can be set several times

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes
| Repeatable:     |  ✓ Yes
| Allowed Values: | ALL, READ, WRITE, CREATE, DELETE, ALTER, DESCRIBE, CLUSTER_ACTION, DESCRIBE_CONFIGS, ALTER_CONFIGS, IDEMPOTENT_WRITE

#### *--resource RESOURCE*

📦 Resource, \<ResourceType\>:\<name\> with ResourceType one of Topic, Group,  
Cluster, TransactionalId, DelegationToken. Use Cluster:kafka-cluster for the cluster.

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--prefix*

🔤 The resource name is a prefix (PREFIXED pattern) instead of a literal name

#### *--deny*

⛔ DENY instead of ALLOW

#### *--host HOST*

🖥️ Host the ACL applies to  
  
ℹ️ If not set, all hosts (*)

#### *--kafka-acls*

🧰 Use regular Kafka ACLs (kafka-acls) instead of MDS centralized ACLs

#### *--verbose, -v*

🐞 Show command being ran.

## Examples

```bash
playground rbac acl create --principal User:charlie --operation WRITE --operation DESCRIBE --resource Topic:orders
```

```bash
playground rbac acl create --principal User:charlie --operation READ --resource Group:my-app --prefix
```

```bash
playground rbac acl create --principal User:charlie --operation READ --resource Topic:orders --kafka-acls
```


