# playground debug enable-remote-debugging

✨ Enable java remote debugging for container  
  
👉 Check documentation https://kafka-docker-playground.io/#/reusables?id=%e2%9c%a8-remote-debugging

## Usage

```bash
playground debug enable-remote-debugging [OPTIONS]
```

## Options

#### *--container, -c CONTAINER*

🐳 Container name  
  
🎓 Tip: you can pass multiple containers by specifying --container multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | connect

## Examples

```bash
playground debug enable-remote-debugging
```

```bash
playground debug enable-remote-debugging --container broker
```

```bash
playground debug enable-remote-debugging -c broker
```


