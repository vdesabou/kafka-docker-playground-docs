# playground container exec

🪄 Execute command in a container  
  
Runs one command and returns, which makes it the form to use inside  
example scripts. Add --root when the component user is not allowed to  
do what you are asking, typically to install a package or read a file  
under /etc.

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
playground container exec -c connect --command "date"
```

```bash
playground container exec -c connect --command "whoami" --root
```

```bash
playground container exec --container connect --command "whoami" --shell sh
```

```bash
playground container exec -c broker -c connect --command "ps aux"
```

```bash
playground container exec --container schema-registry --container ksqldb-server --command "free -h"
```

```bash
playground container exec -c connect -c broker --command "netstat -tuln" --root
```


