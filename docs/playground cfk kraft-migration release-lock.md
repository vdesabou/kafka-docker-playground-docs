# playground cfk kraft-migration release-lock

🔓 Release the locks of the migration on the CRs

Annotation kraft-migration-release-cr-lock=true on the KRaftMigrationJob,  
then waits for the kraft-migration-cr-lock annotations to leave the  
Kafka and KRaftController CRs: until then every change of these CRs is  
rejected (GitOps reconciliations fail). `--remove-log4j1` then removes  
the use-log4j1 annotation of the KRaftController (one roll).

## Usage

```bash
playground cfk kraft-migration release-lock [OPTIONS]
```

## Options

#### `--name NAME`

🏷️ Name of the KRaftMigrationJob

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `kraftmigrationjob`

#### `--remove-log4j1`

🪵 Also remove the use-log4j1 annotation of the KRaftController (it rolls)

## Examples

```bash
playground cfk kraft-migration release-lock --remove-log4j1
```


