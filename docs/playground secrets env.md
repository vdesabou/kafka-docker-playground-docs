# playground secrets env

🐚 Export what an example needs into the current shell  
  
This is the replacement for 'source secret.properties'. Instead of putting  
every credential into every shell, it exports only the variables the example  
at hand declares, read from the secrets store:  
  
  source \<(playground secrets env)  
  
Handy when copy pasting pieces of an example script into a terminal. With no  
--file it uses the last example ran, like 'playground secrets check'.  
  
The shell code goes to stdout and everything else to stderr, so nothing  
unexpected ever gets executed.  
  
🎓 Tip: put a shortcut in your shell profile:  
  
  alias pgenv='source \<(playground secrets env)'

## Usage

```bash
playground secrets env [OPTIONS]
```

## Options

#### *--file, -f FILE*

📄 Example script (default is the last example ran)

#### *--all*

📦 Export the whole profile, not only what the example needs

#### *--force*

🙈 Print to a terminal anyway, showing every value in clear

#### *--profile PROFILE*

🗂️ Secrets profile to use (default is the active one)

## Examples

```bash
source <(playground secrets env)
```

```bash
source <(playground secrets env -f ccloud/fm-splunk-sink/fully-managed-splunk-sink.sh)
```

```bash
source <(playground secrets env --all)
```


