# playground config cleanup-ccloud-resources-after-run

🧹 delete the Confluent Cloud resources left by the last ccloud example  
  
Connectors and topics created by a ccloud 'playground run' are recorded  
with the run. On 'playground stop', and at the start of the next  
'playground run', the ones still alive are listed and deleted:  
  
  ask     list them and ask for confirmation (default)  
  true    delete them without asking  
  false   never delete them  
  
Fully managed connectors are billed while they exist, and an  
interrupted example never reaches its final 'playground connector  
delete'. Resources of older runs, or created outside a run, are left  
alone: use 'playground cleanup-cloud-resources --resource ccloud'.

## Usage

```bash
playground config cleanup-ccloud-resources-after-run [MODE]
```

## Arguments

#### *MODE*



| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | ask
| Allowed Values: | ask, true, false

## Examples

```bash
playground config cleanup-ccloud-resources-after-run ask
```

```bash
playground config cleanup-ccloud-resources-after-run true
```

```bash
playground config cleanup-ccloud-resources-after-run false
```


