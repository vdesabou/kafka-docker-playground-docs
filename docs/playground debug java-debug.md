# playground debug java-debug

🤎 JVM arguments for SSL, Kerberos or Class Loading

## Usage

```bash
playground debug java-debug [OPTIONS]
```

## Options

#### *--container, -c, --pod, -p CONTAINER*

🐳 container name (or pod name when cfk environment is used)  
  
🎓 Tip: you can pass multiple containers by specifying --container multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | connect

#### *--type TYPE*

- ssl_all: Enable all SSL debugging, i.e -Djavax.net.debug=all  
- ssl_handshake: Enable SSL handshake debugging, i.e -Djavax.net.debug=ssl:handshake  
- class_loading: Enable class loading debugging, i.e -verbose:class  
- kerberos: Enable Kerberos debugging, i.e -Dsun.security.krb5.debug=true

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes
| Allowed Values: | ssl_all, ssl_handshake, class_loading, kerberos

#### *--action ACTION*

🟢 enable or disable

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | enable
| Allowed Values: | enable, disable

## Examples

```bash
playground debug java-debug --type class_loading
```

```bash
playground debug java-debug --container broker --action start
```


