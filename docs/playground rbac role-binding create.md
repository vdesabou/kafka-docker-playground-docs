# playground rbac role-binding create

🔐 Create a role binding  
  
Without --resource, the role is bound on the whole cluster  
(SystemAdmin, ClusterAdmin, SecurityAdmin, UserAdmin, AuditAdmin,  
Operator). With --resource, it is bound on that resource  
(ResourceOwner, DeveloperRead, DeveloperWrite, DeveloperManage).  
  
The scope is deduced from the resource type when --scope is not set:  
Subject is schema-registry, Connector is connect, KsqlCluster is  
ksqldb, anything else is kafka.

## Usage

```bash
playground rbac role-binding create [OPTIONS]
```

## Options

#### *--principal, -p PRINCIPAL*

🧑 Principal, User:\<name\> or Group:\<name\> (a bare name means User:\<name\>)  
  
❕ Required, unless --file is set

#### *--role, -r ROLE*

🎩 Role name  
  
❕ Required, unless --file is set

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | ResourceOwner, DeveloperRead, DeveloperWrite, DeveloperManage, SystemAdmin, ClusterAdmin, SecurityAdmin, UserAdmin, AuditAdmin, Operator

#### *--resource RESOURCE*

📦 Resource, \<ResourceType\>:\<name\>, for example Topic:orders, Group:my-app,  
Subject:orders-value, Connector:my-sink, TransactionalId:my-tx, Cluster:kafka-cluster  
  
ℹ️ If not set, the role is bound on the whole cluster

#### *--prefix*

🔤 The resource name is a prefix (PREFIXED pattern) instead of a literal name

#### *--scope SCOPE*

🎯 Cluster the role binding applies to  
  
ℹ️ If not set, it is deduced from the resource type (kafka when there is no resource)

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | kafka, schema-registry, connect, ksqldb

#### *--file FILE*

📄 Create all the role bindings of a file, one per line: \<principal\> \<role\> \<resource or -\> [prefix] [scope=\<scope\>]  
  
See environment/rbac-sasl-plain/role-bindings.txt (the default role bindings) for the format.

#### *--verbose, -v*

🐞 Show command being ran.

## Examples

```bash
playground rbac role-binding create --principal User:alice --role DeveloperRead --resource Topic:orders
```

```bash
playground rbac role-binding create --principal User:alice --role ResourceOwner --resource Topic:orders --prefix
```

```bash
playground rbac role-binding create --principal User:connectorSA --role ResourceOwner --resource Subject:orders-value
```

```bash
playground rbac role-binding create --principal Group:KafkaDevelopers --role SystemAdmin --scope connect
```

```bash
playground rbac role-binding create --file "$PWD/role-bindings.txt"
```


