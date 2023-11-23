# playground debug tcp-dump

🕵️‍♂️ Take a tcp dump (sniffing network)

## Usage

```bash
playground debug tcp-dump [OPTIONS]
```

## Options

#### *--container, -c CONTAINER*

🐳 Container name

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | connect

#### *--port PORT*

Port on which tcp dump should be done, if not set sniffing is done on every port

#### *--duration DURATION*

Duration of the dump (default is 30 seconds).

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 30

## Examples

```bash
playground debug tcp-dump --container control-center --port 9021 --duration 60
```


