# playground cfk

☸️ Confluent for Kubernetes commands (cfk and cfk-rbac environments)

The day-2 operations of a cluster deployed by CFK: change a custom  
resource and watch the operator roll it, upgrade Confluent Platform,  
upgrade the operator.

- **patch**: change a custom resource, wait for CFK to roll it
- **roll**: restart the pods of a custom resource, the supported way
- **upgrade**: move every custom resource to another Confluent Platform version
- **operator**: upgrade the CFK operator (helm chart, CRDs, init containers)

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

- [patch](playground%20cfk%20patch) - 🩹 Change a custom resource and wait for CFK to roll it
- [roll](playground%20cfk%20roll) - 🔁 Restart the pods of a custom resource, the way CFK supports
- [upgrade](playground%20cfk%20upgrade) - ⬆️ Move every custom resource to another Confluent Platform version
- [operator](playground%20cfk%20operator) - ☸️ The CFK operator
  - [upgrade](playground%20cfk%20operator%20upgrade) - ⬆️ Upgrade the CFK operator, with the CFK upgrade procedure


