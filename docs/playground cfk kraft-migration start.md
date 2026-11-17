# playground cfk kraft-migration start

🚚 Start the migration and wait for DUAL-WRITE

Creates the KRaftController CR with the images of the Kafka CR and the  
annotations kraft-migration-hold-krc-creation (status HOLD, no pod yet)  
and use-log4j1 (CP 7.x with CFK 3), then the KRaftMigrationJob CR, and  
prints each phase and sub-phase as the operator goes through SETUP,  
MIGRATE and DUAL-WRITE, with the time spent in each. From then on the  
ZooKeeper, Kafka and KRaftController CRs are locked.

## Usage

```bash
playground cfk kraft-migration start [OPTIONS]
```

## Options

#### `--controllers NUMBER`

🗳️ Replicas of the KRaftController (an odd number)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `3`

#### `--preflight`

🔎 Enable the ZooKeeper metadata preflight check (annotation kraft-migration-enable-preflight)

#### `--name NAME`

🏷️ Name of the KRaftMigrationJob

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `kraftmigrationjob`

#### `--timeout SECONDS`

⏱️ How long to wait for DUAL-WRITE

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `3600`

## Examples

```bash
playground cfk kraft-migration start
```

```bash
playground cfk kraft-migration start --controllers 1 --preflight
```


