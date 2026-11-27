# playground container recreate

💫 Recreate container(s)

👉 Check documentation https://kafka-docker-playground.io/#/how-to-use?id=%e2%99%bb%ef%b8%8f-re-create-containers

Replays the docker compose command of the example, so a container is  
rebuilt from its current definition. This is what applies a change  
made with `playground container set-environment-variables` or  
`playground container update`, and what you use to restart a component  
from scratch without re-running the whole example.

A recreated container keeps its anonymous volumes (the data folder of a  
broker or a controller, /var/lib/kafka/data): `--fresh-volumes` `<container>`  
removes that container and its anonymous volumes first, so it starts  
with an empty data folder (a KRaft node is formatted again by the image).  
Use it after changing the node id of a broker ("Stored node id 2 doesn't  
match previous node id 3"), its cluster id, or to restart one node from  
empty disks.

## Usage

```bash
playground container recreate [OPTIONS]
```

## Options

#### `--ignore-current-versions`

Ignore current confluent platform version

By default, the current version is used

#### `--fresh-volumes CONTAINER`

🧽 remove this container and its anonymous volumes before recreating it:  
it starts with empty data folders (its topic data is lost on this node)

🎓 Tip: repeat it for several containers

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

## Examples

```bash
playground container recreate
```

```bash
playground container recreate --fresh-volumes broker3
```


