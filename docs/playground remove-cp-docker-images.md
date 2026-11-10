# playground remove-cp-docker-images

🧹 Remove all Confluent Platform docker images related to a version installed locally (a confirmation will be required for every version present)

Each Confluent Platform version you have ever run keeps a dozen images on  
disk, so this is usually where the space went. You are asked before every  
version (y remove, n skip it, a all remaining, q quit), unless you name one  
with `--version`.

Never proposed for removal: the default version used by the playground, the  
version of the current run (`--tag`), and any version used by a container,  
running or stopped (another session, for example).

## Usage

```bash
playground remove-cp-docker-images [OPTIONS]
```

## Options

#### `--version VERSION`

🔢 Specific version to remove (refused when a container uses it)


