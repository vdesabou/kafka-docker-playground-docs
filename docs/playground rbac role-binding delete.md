# playground rbac role-binding delete

🗑️ Delete a role binding

Same flags as `playground rbac role-binding create`.

## Usage

```bash
playground rbac role-binding delete [OPTIONS]
```

## Options

#### `--principal, -p PRINCIPAL`

🧑 Principal, User:`<name>` or Group:`<name>` (a bare name means User:`<name>`)

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--role, -r ROLE`

🎩 Role name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes
| Allowed Values: | `ResourceOwner`, `DeveloperRead`, `DeveloperWrite`, `DeveloperManage`, `SystemAdmin`, `ClusterAdmin`, `SecurityAdmin`, `UserAdmin`, `AuditAdmin`, `Operator`

#### `--resource RESOURCE`

📦 Resource, `<ResourceType>:<name>`, for example Topic:orders, Group:my-app,  
Subject:orders-value, Connector:my-sink, TransactionalId:my-tx, Cluster:kafka-cluster

ℹ️ If not set, the role is bound on the whole cluster

#### `--prefix`

🔤 The resource name is a prefix (PREFIXED pattern) instead of a literal name

#### `--scope SCOPE`

🎯 Cluster the role binding applies to

ℹ️ If not set, it is deduced from the resource type (kafka when there is no resource)

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `kafka`, `schema-registry`, `connect`, `ksqldb`

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground rbac role-binding delete --principal User:alice --role DeveloperRead --resource Topic:orders
```

```bash
playground rbac role-binding delete --principal User:alice --role SystemAdmin
```


