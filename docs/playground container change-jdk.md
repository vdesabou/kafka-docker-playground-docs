# playground container change-jdk

🤎 Change java JDK version using Azul JDK (https://www.azul.com/downloads/#downloads-table-zulu)  
  
PS: It works for UBI8 docker images only

## Usage

```bash
playground container change-jdk [OPTIONS]
```

## Options

#### *--container, -c CONTAINER*

🐳 Container name  
  
🎓 Tip: you can pass multiple containers by specifying --container multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | connect

#### *--version VERSION*

🤎 JDK version to use

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes
| Allowed Values: | 8, 11, 17, 21, 22, 25

## Examples

```bash
playground change-jdk --container connect --version 17
```


