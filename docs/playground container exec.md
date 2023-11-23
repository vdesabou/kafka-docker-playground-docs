# playground container exec

🪄  Execute command in a container

## Usage

```bash
playground container exec [OPTIONS]
```

## Options

#### *--container, -c CONTAINER*

🐳 Container name

| Attributes      | &nbsp;
|-----------------|-------------
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


