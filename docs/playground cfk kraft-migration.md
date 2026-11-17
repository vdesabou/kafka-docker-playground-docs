# playground cfk kraft-migration

🚚 ZooKeeper to KRaft migration with a KRaftMigrationJob

The steps of docs.confluent.io/operator/current/co-migrate-kraft.html,  
like the kubectl confluent cluster kraft-migration plugin, with every  
kubectl command printed:

- **start**: KRaftController on HOLD + KRaftMigrationJob, until DUAL-WRITE
- **status**: phase, sub-phase, the CRs, the locks, what to do next
- **finalize**: the finalize annotation (irreversible), wait for COMPLETE
- **release-lock**: release the locks on the CRs, remove use-log4j1

🍪 Deep dive: https://kafka-docker-playground.io/#/day-2-operations

## Usage

```bash
playground cfk kraft-migration COMMAND
```

## CFK commands

- [start](playground%20cfk%20kraft-migration%20start) - 🚚 Start the migration and wait for DUAL-WRITE
- [status](playground%20cfk%20kraft-migration%20status) - 🔎 Phase, sub-phase, the CRs, the locks and what to do next
- [finalize](playground%20cfk%20kraft-migration%20finalize) - 🏁 Finalize the migration (irreversible) and wait for COMPLETE
- [release-lock](playground%20cfk%20kraft-migration%20release-lock) - 🔓 Release the locks of the migration on the CRs


