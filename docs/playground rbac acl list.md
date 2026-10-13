# playground rbac acl list

📋 List ACLs  
  
Lists both MDS centralized ACLs and regular Kafka ACLs.

## Usage

```bash
playground rbac acl list [OPTIONS]
```

## Options

#### *--principal, -p PRINCIPAL*

🧑 Principal, User:\<name\> or Group:\<name\> (a bare name means User:\<name\>)  
  
ℹ️ If not set, role bindings of all principals are listed

#### *--verbose, -v*

🐞 Show command being ran.

## Examples

```bash
playground rbac acl list
```

```bash
playground rbac acl list --principal User:charlie
```


