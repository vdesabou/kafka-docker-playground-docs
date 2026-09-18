# playground debug tcp-dump

🕵️‍♂️ Take a tcp dump (sniffing network)  
  
Captures the traffic in or out of a container for --duration seconds and  
brings the capture file back, ready to open in Wireshark. Narrow it with  
--port when you know which one you care about.  
  
❕ On an encrypted listener you will see the handshake and the failures,  
   but not the records themselves.

## Usage

```bash
playground debug tcp-dump [OPTIONS]
```

## Options

#### *--container, -c, --pod, -p CONTAINER*

🐳 container name (or pod name when cfk environment is used)  
  
🎓 Tip: you can pass multiple containers by specifying --container multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
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


