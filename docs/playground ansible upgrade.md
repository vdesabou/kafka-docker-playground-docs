# playground ansible upgrade

⬆️ Upgrade (or downgrade) Confluent Platform with cp-ansible

Downloads the archive of the version to the cache (installation_method  
archive), sets confluent_package_version (and confluent_archive_file_source)  
in the inventory, installs the confluent.platform collection of the same  
major.minor in the controller (or `--ansible-cp-version`), then runs the  
playbook with deployment_strategy=rolling: one host at a time, the  
procedure of cp-ansible.

## Usage

```bash
playground ansible upgrade [OPTIONS]
```

## Options

#### `--to VERSION`

🎯 Confluent Platform version, for example 8.4.1

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--ansible-cp-version VERSION`

🅰️ Version of the confluent.platform collection (default the latest patch of the same major.minor)

#### `--parallel`

⚡ Every host at once (deployment_strategy=parallel, the default of cp-ansible), instead of rolling

#### `--no-playbook`

⏸️ Only change the inventory and the collection, run the playbook yourself

## Examples

```bash
playground ansible upgrade --to 8.4.1
```

```bash
playground ansible upgrade --to 8.4.1 --ansible-cp-version 8.4.0
```


