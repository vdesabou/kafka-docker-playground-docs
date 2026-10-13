# playground rbac role-binding list

📋 List role bindings  
  
Without --principal, every principal with a role binding is listed.

## Usage

```bash
playground rbac role-binding list [OPTIONS]
```

## Options

#### *--principal, -p PRINCIPAL*

🧑 Principal, User:\<name\> or Group:\<name\> (a bare name means User:\<name\>)  
  
ℹ️ If not set, role bindings of all principals are listed

#### *--scope SCOPE*

🎯 Only list role bindings of this cluster  
  
ℹ️ If not set, all clusters are listed

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | kafka, schema-registry, connect, ksqldb

#### *--verbose, -v*

🐞 Show command being ran.

## Examples

```bash
playground rbac role-binding list
```

```bash
playground rbac role-binding list --principal User:connectorSA
```

```bash
playground rbac role-binding list --scope schema-registry
```


