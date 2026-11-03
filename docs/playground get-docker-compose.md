# playground get-docker-compose

🐋 Get docker-compose

Prints the fully resolved docker compose configuration of the running  
example: every file merged, every profile applied and every variable  
substituted. This is what Docker actually received, which is the thing to  
look at when a container did not get the image, port or setting you  
expected.

The output is the YAML alone (the logs are not printed on stdout), ready  
to be redirected to a file. Not available on cfk, where the components  
are pods.

## Usage

```bash
playground get-docker-compose
```

## Examples

```bash
playground get-docker-compose
```

```bash
playground get-docker-compose > /tmp/docker-compose.yml
```

```bash
playground get-docker-compose | yq '.services.connect.environment'
```


