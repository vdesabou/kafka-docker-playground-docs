# playground debug thread-dump

🎯 Take a java thread dump  
  
🔖 It will save output to a file and open with text editor set with playground config editor \<editor\> (default is code)

## Usage

```bash
playground debug thread-dump [OPTIONS]
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
playground debug thread-dump
```

```bash
playground debug thread-dump --container broker
```


