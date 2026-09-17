# playground secrets check

✅ Show what an example needs, and what is missing  
  
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


