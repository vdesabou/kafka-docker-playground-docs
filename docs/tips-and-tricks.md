# 🎁 Tips & Tricks

Below is a collection of tips and tricks

# 🐳 Docker tips

## Tail container logs

Example with `connect` container:

```bash
docker container logs --tail=100 -f connect
```

## Redirect all container logs to a file

Example with `connect` container:

```bash
docker container logs connect > connect.log 2>&1
```

## SSH into container

Example with `connect` container:

```bash
docker exec -it connect bash
```

## Kill all docker containers

```bash
docker rm -f $(docker ps -qa)
```

## Recover from Docker error `max depth exceeded`

When running an example you get:

```log
docker: Error response from daemon: max depth exceeded.
```

This happens from time to time and the only way to resolve this, as far as I know, is to remove all images using:

```bash
docker image rm $(docker image list | grep -v "oracle/database"  | grep -v "db-prebuilt" | awk 'NR>1 {print $3}') -f
```

## Run some commands as root

Example with `connect` container:

```bash
docker exec --privileged --user root connect bash -c "your command"
```

## Get IP address of running containers

```bash
docker inspect -f '{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq)
```

Example:

```
/control-center - 172.21.0.6
/connect - 172.21.0.5
/schema-registry - 172.21.0.4
/broker - 172.21.0.2
/zookeeper - 172.21.0.3
```

## Get number of records in a topic

```bash
docker exec -i broker bash << EOF
kafka-run-class kafka.tools.GetOffsetShell --broker-list broker:9092 --topic a-topic --time -1 | awk -F ":" '{sum += \$3} END {print sum}'
EOF
```

## Check Kafka Connect offsets topic

```bash
docker exec connect kafka-console-consumer -bootstrap-server broker:9092 --topic connect-offsets --from-beginning --property print.key=true --property print.timestamp=true
```

