# playground container get-ip-addresses

🖥️  Get ip address of running containers

The address each container has on the docker network, which is what  
you need when a component must be reached by IP rather than by name,  
or when you are checking what a client actually connected to.

## Usage

```bash
playground container get-ip-addresses
```

## Examples

```bash
playground container get-ip-addresses
```

## Example output

```text
$ playground container get-ip-addresses
17:22:19 ℹ️ Get IP address of running containers
/controller - 10.89.0.2
/broker - 10.89.0.4
/schema-registry - 10.89.0.6
/connect - 10.89.0.7
```


