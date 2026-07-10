# playground container exec

🪄 Execute command in a container

## Usage

```bash
playground container exec [OPTIONS]
```

## Options

#### *--container, -c, --pod, -p CONTAINER*

🐳 container name (or pod name when cfk environment is used)  
  
🎓 Tip: you can pass multiple containers by specifying --container multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | connect

#### *--command COMMAND*

📲 Command to execute

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--root*

👑 Run command as root

#### *--shell SHELL*

💾 Shell to use (default is bash)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | bash
| Allowed Values: | bash, sh, ksh, zsh

## Examples

```bash
playground exec -c connect -d "date"
```

```bash
playground exec -c connect -d "whoami" --root
```

```bash
playground exec --container connect --command "whoami" --shell sh
```

```bash
playground exec -c broker -c connect -d "ps aux"
```

```bash
playground exec --container schema-registry --container ksqldb-server --command "free -h"
```

```bash
playground exec -c connect -c broker -d "netstat -tuln" --root
```


