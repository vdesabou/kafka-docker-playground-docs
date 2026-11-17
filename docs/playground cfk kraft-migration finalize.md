# playground cfk kraft-migration finalize

🏁 Finalize the migration (irreversible) and wait for COMPLETE

Annotation kraft-migration-trigger-finalize-to-kraft=true on the  
KRaftMigrationJob in DUAL-WRITE: the brokers lose their ZooKeeper  
dependency, no rollback after it.

## Usage

```bash
playground cfk kraft-migration finalize [OPTIONS]
```

## Options

#### `--name NAME`

🏷️ Name of the KRaftMigrationJob

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `kraftmigrationjob`

#### `--timeout SECONDS`

⏱️ How long to wait for COMPLETE

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `3600`

## Examples

```bash
playground cfk kraft-migration finalize
```


