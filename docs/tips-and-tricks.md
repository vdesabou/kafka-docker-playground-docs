# 🎁 Tips & Tricks

Below is a collection of tips and tricks

# 🐳 Docker tips

## Tail container logs

Example with `connect` container:

```bash
docker container logs --tail=100 -f connect
```

or use [🧠 CLI](https://kafka-docker-playground.io/#/how-to-use?id=%f0%9f%a7%a0-cli) with:

```bash
playground logs connect
```

## Redirect all container logs to a file

Example with `connect` container:

```bash
docker container logs connect > connect.log 2>&1
```

or use [🧠 CLI](https://kafka-docker-playground.io/#/how-to-use?id=%f0%9f%a7%a0-cli) with:

```bash
playground logs connect -o code
```

Output:

```bash
23:10:30 ℹ️ Opening /tmp/connect-2023-02-27-23-10-30.log with editor code
```

## SSH into container

Example with `connect` container:

```bash
docker exec -it connect bash
```

or use [🧠 CLI](https://kafka-docker-playground.io/#/how-to-use?id=%f0%9f%a7%a0-cli) with:

```bash
playground ssh connect
```

## Kill all docker containers

```bash
docker rm -f $(docker ps -qa)
```

or use [🧠 CLI](https://kafka-docker-playground.io/#/how-to-use?id=%f0%9f%a7%a0-cli) with:

```bash
playground kill-all-containers
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

## Run some commands

Example with `connect` container:

```bash
docker exec connect bash -c "whoami"
```

or use [🧠 CLI](https://kafka-docker-playground.io/#/how-to-use?id=%f0%9f%a7%a0-cli) with:

```bash
playground exec connect "whoami"
```

## Run some commands as root

Example with `connect` container:

```bash
docker exec --privileged --user root connect bash -c "whoami"
```

or use [🧠 CLI](https://kafka-docker-playground.io/#/how-to-use?id=%f0%9f%a7%a0-cli) with:

```bash
playground exec connect "whoami" --root
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

or use [🧠 CLI](https://kafka-docker-playground.io/#/how-to-use?id=%f0%9f%a7%a0-cli) with:

```bash
playground get-ip-address-container
```

## Get number of records in a topic

```bash
docker exec -i broker bash << EOF
kafka-run-class kafka.tools.GetOffsetShell --broker-list broker:9092 --topic a-topic --time -1 | awk -F ":" '{sum += \$3} END {print sum}'
EOF
```

or use [🧠 CLI](https://kafka-docker-playground.io/#/how-to-use?id=%f0%9f%a7%a0-cli) with:

```bash
playground get-number-records-topic <topic>
```

## Check Kafka Connect offsets topic

```bash
docker exec connect kafka-console-consumer -bootstrap-server broker:9092 --topic connect-offsets --from-beginning --property print.key=true --property print.timestamp=true
```

