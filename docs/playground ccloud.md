# playground ccloud

🌤️ Set up your own Confluent Cloud clusters for the fully managed examples

- **ccloud setup**: a personal environment, one Basic cluster per cloud, their API keys, stored in a secrets profile

The examples then run on these clusters with no bootstrap to wait for. To  
see what is still running, or delete it: 'playground cloud-resources ccloud  
list' and `playground cloud-resources cleanup --resource ccloud`.

🌙 Then let the playground delete what your examples leave running, every  
night: `playground cloud-resources nightly-cleanup enable`.

## Usage

```bash
playground ccloud COMMAND
```

## Commands

- [setup](playground%20ccloud%20setup) - 🏗️ Create (or complete) your personal environment and clusters, and store them in a secrets profile


