# 🎁 Tips & Tricks

Below is a collection of tips and tricks.

## 🐳 Docker tips

### Tail container logs

Example with `connect` container:

```bash
docker container logs --tail=100 -f connect
```

or use [🧠 CLI](/cli) with:

```bash
playground container logs -c connect
```

### Redirect all container logs to a file

Example with `connect` container:

```bash
docker container logs connect > connect.log 2>&1
```

or use [🧠 CLI](/cli) with:

```bash
playground container logs -c connect --open
```

Output:

```bash
23:10:30 ℹ️ Opening /tmp/connect-2023-02-27-23-10-30.log with editor code
```

> [!TIP]
> The editor is set with `playground config editor <editor>` (default is `code`).

### Filter container logs

Keep only the lines that matter, or only the recent ones:

```bash
playground container logs -c connect --grep "ERROR"
playground container logs -c connect --since 10m
playground container logs -c connect --grep "Caused by" --no-follow
```

Get a de-duplicated digest of ERROR/FATAL records:

```bash
playground container logs -c connect --errors --since 10m
```

### Wait for a log line

Instead of using `sleep`, block until a log line shows up (useful in reproduction models):

```bash
playground container logs -c connect --wait-for-log "Finished starting connectors and tasks" --max-wait 120
```

### Display errors of all containers

The first command to run when an example misbehaves and you do not yet know which component is at fault:

```bash
playground container display-error-all
```

### SSH into container

Example with `connect` container:

```bash
docker exec -it connect bash
```

or use [🧠 CLI](/cli) with:

```bash
playground container ssh -c connect
```

### Kill all docker containers

```bash
docker rm -f $(docker ps -qa)
```

or use [🧠 CLI](/cli) with:

```bash
playground container kill-all
```

### Recover from Docker error `max depth exceeded`

When running an example you get:

```log
docker: Error response from daemon: max depth exceeded.
```

This happens from time to time and the only way to resolve this, as far as I know, is to remove all images using:

```bash
docker image rm $(docker image list | grep -v "oracle/database"  | grep -v "db-prebuilt" | awk 'NR>1 {print $3}') -f
```

### Run some commands

Example with `connect` container:

```bash
docker exec connect bash -c "whoami"
```

or use [🧠 CLI](/cli) with:

```bash
playground container exec -c connect --command "whoami"
```

### Run some commands as root

Example with `connect` container:

```bash
docker exec --privileged --user root connect bash -c "whoami"
```

or use [🧠 CLI](/cli) with:

```bash
playground container exec -c connect --command "whoami" --root
```

### Copy files between local filesystem and container

```bash
docker cp ./file.txt connect:/tmp/file.txt
```

or use [🧠 CLI](/cli) with:

```bash
playground container cp --source ./file.txt --destination connect:/tmp/file.txt
playground container cp --source connect:/tmp/file.txt --destination ./file.txt
```

### Change the JDK version of a container

Uses Azul Zulu JDK (works with UBI8 images only):

```bash
playground container change-jdk --container connect --version 21
```

### Get IP address of running containers

```bash
docker inspect -f '{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq)
```

Example:

```log
/control-center - 172.21.0.6
/connect - 172.21.0.5
/schema-registry - 172.21.0.4
/broker - 172.21.0.2
/controller - 172.21.0.3
```

or use [🧠 CLI](/cli) with:

```bash
playground container get-ip-addresses
```

### Get number of records in a topic

```bash
docker exec -i broker bash << EOF
kafka-run-class org.apache.kafka.tools.GetOffsetShell --bootstrap-server broker:9092 --topic a-topic --time -1 | awk -F ":" '{sum += \$3} END {print sum}'
EOF
```

or use [🧠 CLI](/cli) with:

```bash
playground topic get-number-records --topic a-topic
```

> [!NOTE]
> On CP < 7.7, the class is `kafka.tools.GetOffsetShell`. See [playground topic get-number-records](/playground%20topic%20get-number-records) for all options.

### Check Kafka Connect offsets topic

```bash
docker exec connect kafka-console-consumer --bootstrap-server broker:9092 --topic connect-offsets --from-beginning --property print.key=true --property print.timestamp=true
```

or use [🧠 CLI](/cli) with:

```bash
playground connector offsets get
```

or consume the topic directly:

```bash
playground topic consume --topic connect-offsets
```

> [!TIP]
> To display the content of `__consumer_offsets`, use [playground topic display-consumer-offsets](/playground%20topic%20display-consumer-offsets).

## 🧠 CLI tips

### Get a status of what is running

```bash
playground status
```

It shows the example currently running, the state of every container, the connectors (versions, status, configuration) and the topics.

### Check that the container engine is ready

```bash
playground doctor
```

It reports which engine is used (Docker or Podman) and checks compose v2, memory and, with Podman, the extra requirements. It is the command to run first when an example fails before a single container starts.
