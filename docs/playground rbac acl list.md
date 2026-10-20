# playground rbac acl list

📋 List ACLs

Lists both MDS centralized ACLs and regular Kafka ACLs, or the ACLs of  
the Confluent Cloud cluster on a Confluent Cloud run.

## Usage

```bash
playground rbac acl list [OPTIONS]
```

## Options

#### `--principal, -p PRINCIPAL`

🧑 Principal, User:`<name>` or Group:`<name>` (a bare name means User:`<name>`)

ℹ️ If not set, role bindings of all principals are listed

#### `--connector, -c CONNECTOR`

🔗 Use the service account of this fully managed connector (kafka.service.account.id) as principal

⛅ Confluent Cloud only, see playground run `--ccloud-service-account`

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground rbac acl list
```

```bash
playground rbac acl list --principal User:charlie
```

```bash
playground rbac acl list --connector HttpSink_$USER
```


