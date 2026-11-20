# playground cfk

☸️ Confluent for Kubernetes commands (cfk and cfk-rbac environments)

The day-2 operations of a cluster deployed by CFK: change a custom  
resource and watch the operator roll it, upgrade Confluent Platform,  
upgrade the operator.

- **patch**: change a custom resource, wait for CFK to roll it
- **roll**: restart the pods of a custom resource, the supported way
- **upgrade**: move every custom resource to another Confluent Platform version
- **operator**: upgrade the CFK operator (helm chart, CRDs, init containers)
- **kraft-migration**: ZooKeeper to KRaft with a KRaftMigrationJob (start, status, finalize, release-lock)

Each change waits for the operator: the statefulset changed or not, every  
pod restarted on the new revision (printed as they roll), the custom  
resource back to RUNNING, then the events of the custom resource and its  
pods since the change.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-cfk

## Usage

```bash
playground cfk COMMAND
```

## CFK commands

- [kraft-migration](playground%20cfk%20kraft-migration) - 🚚 ZooKeeper to KRaft migration with a KRaftMigrationJob
  - [finalize](playground%20cfk%20kraft-migration%20finalize) - 🏁 Finalize the migration (irreversible) and wait for COMPLETE
  - [release-lock](playground%20cfk%20kraft-migration%20release-lock) - 🔓 Release the locks of the migration on the CRs
  - [start](playground%20cfk%20kraft-migration%20start) - 🚚 Start the migration and wait for DUAL-WRITE
  - [status](playground%20cfk%20kraft-migration%20status) - 🔎 Phase, sub-phase, the CRs, the locks and what to do next
- [operator](playground%20cfk%20operator) - ☸️ The CFK operator
  - [upgrade](playground%20cfk%20operator%20upgrade) - ⬆️ Upgrade the CFK operator, with the CFK upgrade procedure
- [patch](playground%20cfk%20patch) - 🩹 Change a custom resource and wait for CFK to roll it
- [roll](playground%20cfk%20roll) - 🔁 Restart the pods of a custom resource, the way CFK supports
- [upgrade](playground%20cfk%20upgrade) - ⬆️ Move every custom resource to another Confluent Platform version


