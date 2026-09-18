# playground container

🐳 Container commands  
  
Work on the containers of the running example without having to remember  
their names, their users or their file layout. The same commands work  
against Kubernetes pods when the example runs on the cfk environment,  
which is why 'pod' is an accepted alias.  
  
🔍 Look inside  
  logs                 tail logs, grep them, or block until a line appears  
  display-error-all    every ERROR and FATAL across all containers  
  get-properties       the properties file a component actually loaded  
  get-ip-addresses     addresses on the docker network  
  exec / ssh           run a command, or get a shell  
  
🔁 Act on them  
  restart / kill / pause / resume  
  recreate             re-create with the same compose definition  
  update               edit the compose or Kubernetes definition, apply it  
  set-environment-variables   add settings, then recreate  
  cp                   copy files in and out  
  change-jdk           swap the JDK, to reproduce a JVM-specific issue  
  kill-all             kill everything and prune volumes  
  
Most commands accept --container several times to act on a few containers  
at once.  
  
🎓 Tip: the usual names are broker, connect, schema-registry,  
control-center, ksqldb-server, plus whatever the example adds.

| Attributes       | &nbsp;
|------------------|-------------
| Alias:           | pod

## Usage

```bash
playground container COMMAND
```

## == Commands ==

- [get-properties](playground%20container%20get-properties) - 📝 Get properties file from a container

## Container commands

- [recreate](playground%20container%20recreate) - 💫 Recreate container(s)
- [update](playground%20container%20update) - ✍️ Edit and apply runtime container/pod definition
- [get-ip-addresses](playground%20container%20get-ip-addresses) - 🖥️  Get ip address of running containers
- [kill-all](playground%20container%20kill-all) - 💀 Kill all containers and prune all volumes
- [logs](playground%20container%20logs) - 🕵️  Tail and follow container logs
- [display-error-all](playground%20container%20display-error-all) - 🔥 Display all ERROR/FATAL logs in all containers/pods. Useful for quick troubleshooting
- [ssh](playground%20container%20ssh) - 🛬 SSH into container
- [change-jdk](playground%20container%20change-jdk) - 🤎 Change java JDK version using Azul JDK (https://www.azul.com/downloads/#downloads-table-zulu)
- [exec](playground%20container%20exec) - 🪄 Execute command in a container
- [cp](playground%20container%20cp) - 🪄 Copy files between local filesystem and container
- [restart](playground%20container%20restart) - 🔁 Restart a container
- [pause](playground%20container%20pause) - ⏸️  Pause a container
- [resume](playground%20container%20resume) - ⏯️  Resume a container
- [kill](playground%20container%20kill) - 🔫 Kill a container
- [set-environment-variables](playground%20container%20set-environment-variables) - 📦  Set environment variable(s) for a container


