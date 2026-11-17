# playground cfk operator upgrade

⬆️ Upgrade the CFK operator, with the CFK upgrade procedure

The steps of docs.confluent.io/operator/current/co-upgrade-cfk.html:  
reconciliation blocked on every custom resource  
(platform.confluent.io/block-reconcile=true), the CRDs of the new chart  
applied (helm never upgrades them; CFK 3.4.0 and later manage their own  
CRDs), helm upgrade of confluent-operator, the init container image of  
every custom resource staged, then reconciliation enabled again one  
component at a time, controllers first: each component rolls once, with  
the new operator and the new init container together.

`--no-block-reconcile` shows the classic mistake: the new operator  
reconciles every component as soon as it starts (controllers, brokers,  
connect... roll at the same time), then the new init container images  
roll everything a second time.

## Usage

```bash
playground cfk operator upgrade [OPTIONS]
```

## Options

#### `--to VERSION`

🎯 CFK version, for example 3.4.0

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--no-block-reconcile`

💥 Don't block reconciliation during the upgrade (the classic mistake)

#### `--skip-crds`

📜 Don't apply the CRDs of the new chart (CFK before 3.4.0)

#### `--keep-init-images`

🧷 Don't change the init container image of the custom resources

#### `--timeout SECONDS`

⏱️ How long to wait for the roll of each custom resource

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `1200`

## Examples

```bash
playground cfk operator upgrade --to 3.4.0
```

```bash
playground cfk operator upgrade --to 3.3.1 --no-block-reconcile
```


