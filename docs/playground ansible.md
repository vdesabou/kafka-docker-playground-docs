# playground ansible

🅰️ cp-ansible commands (ansible and ansible-sasl-ssl environments)

The day-2 operations of a cluster deployed by cp-ansible: change the  
inventory, run the playbook again, upgrade Confluent Platform.

- **playbook**: run confluent.platform.all (or another playbook) again
- **inventory**: read and change environment/ansible/inventory/hosts.yml
- **add-host**: add hosts to the running cluster (brokers, controllers, workers...)
- **upgrade**: move the cluster to another Confluent Platform version

After each playbook run, the cluster is handed over to the playground  
commands again (wrappers of the binaries of the new version, client  
security of each host, CA of the https REST APIs).

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-ansible

## Usage

```bash
playground ansible COMMAND
```

## Run commands

- [playbook](playground%20ansible%20playbook) - ▶️ Run the playbook again on the hosts
- [inventory](playground%20ansible%20inventory) - 📋 Read and change the inventory of the ansible environment
  - [get](playground%20ansible%20inventory%20get) - 🔎 Display the inventory, or the value of a yq path
  - [set](playground%20ansible%20inventory%20set) - ✏️ Set the value of a yq path, and print the change
  - [delete](playground%20ansible%20inventory%20delete) - 🗑️ Remove a yq path from the inventory, and print the change
- [add-host](playground%20ansible%20add-host) - 🖥️ Add hosts to the running cluster
- [upgrade](playground%20ansible%20upgrade) - ⬆️ Upgrade (or downgrade) Confluent Platform with cp-ansible


