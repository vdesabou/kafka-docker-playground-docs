# playground secrets check

✅ Show what an example needs, and what is missing  
  
One line per variable, saying where the value comes from (environment,  
or which backend and which reference) or how to store it. AWS and GCP  
examples also get their ~/.aws/credentials and keyfile.json checked.  
  
The list comes from the example itself: every variable it declares with  
the standard 'Export it as environment variable or pass it as argument'  
error string, which is also what 'playground run' loads.  
  
Exits 1 when something is missing.  
  
🎓 Tip: run it before a long example, it fails in a second instead of  
several minutes into the environment startup.

## Usage

```bash
playground secrets check [OPTIONS]
```

## Options

#### *--file, -f FILE*

📄 Example script (default is the last example ran)

#### *--profile PROFILE*

🗂️ Secrets profile to use (default is the active one)

## Examples

```bash
playground secrets check
```

```bash
playground secrets check -f ccloud/fm-splunk-sink/fully-managed-splunk-sink.sh
```


