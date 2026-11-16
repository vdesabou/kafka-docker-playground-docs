# playground ansible playbook

▶️ Run the playbook again on the hosts

Runs ansible-playbook -i /inventory/hosts.yml confluent.platform.all in  
the ansible-controller container, writes the output to  
/tmp/playground-ansible-playbook.log, prints the PLAY RECAP and, when it  
fails, the error of each host. Then hands the cluster over to the  
playground commands again.

`--rolling` sets deployment_strategy=rolling: one host at a time, what the  
cp-ansible procedures use to change a running cluster (upgrades,  
security changes).

## Usage

```bash
playground ansible playbook [OPTIONS] [--] [ANSIBLE-PLAYBOOK ARGUMENTS...]
```

## Options

#### `--limit HOSTS`

🖥️ Only these hosts or groups (ansible `--limit`), for example connect or kafka_broker

#### `--tags TAGS`

🏷️ Only the tasks with these tags (ansible `--tags`), for example kafka_broker

#### `--skip-tags TAGS`

🏷️ Skip the tasks with these tags (ansible `--skip-tags`), for example package

#### `--rolling`

🔁 One host at a time (-e deployment_strategy=rolling)

#### `--playbook PLAYBOOK`

📒 Playbook of the confluent.platform collection (confluent.platform.restart, confluent.platform.health_check, confluent.platform.fetch_logs...)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `confluent.platform.all`

#### `--verbose, -v`

🐞 ansible-playbook -vvv

## Examples

```bash
playground ansible playbook
```

```bash
playground ansible playbook --limit connect
```

```bash
playground ansible playbook --rolling --skip-tags package
```

```bash
playground ansible playbook --playbook confluent.platform.restart --limit kafka_broker
```

```bash
playground ansible playbook -- -e deployment_strategy=rolling -e pause_rolling_deployment=true
```


