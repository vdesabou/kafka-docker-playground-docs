# playground container ssh

🛬 SSH into container

## Usage

```bash
playground container ssh [OPTIONS]
```

## Options

#### *--container, -c CONTAINER*

🐳 Container name  
  
🎓 Tip: you can pass multiple containers by specifying --container multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | connect

#### *--shell, -s SHELL*

💾 Shell to use (default is bash)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | bash
| Allowed Values: | bash, sh, ksh, zsh

## Examples

```bash
playground ssh -c connect
```

```bash
playground ssh -c connect -s sh
```

```bash
playground ssh --container connect --shell sh
```


