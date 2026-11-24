# playground account ccloud

🌤️ Set up your own Confluent Cloud clusters for the fully managed examples, and check them

- **setup**: a personal environment, one Basic cluster per cloud, their API keys, stored in a secrets profile
- **check**: verify what the profile holds: environment, clusters, API keys, Schema Registry, regions, exported variables that hide it

The examples then run on these clusters with no bootstrap to wait for. To  
see what is still running, or delete it: 'playground cloud-resources ccloud  
list' and `playground cloud-resources cleanup --resource ccloud`.

🌙 Then let the playground delete what your examples leave running, every  
night: `playground cloud-resources nightly-cleanup enable`.

## Usage

```bash
playground account ccloud COMMAND
```

## Commands

- [check](playground%20account%20ccloud%20check) - 🩺 Check the environment, clusters and API keys of the fully managed examples
- [setup](playground%20account%20ccloud%20setup) - 🏗️ Create (or complete) your personal environment and clusters, and store them in a secrets profile


