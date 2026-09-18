# playground remove-cp-docker-images

🧹 Remove all Confluent Platform docker images related to a version installed locally (a confirmation will be required for every version present)  
  
Each Confluent Platform version you have ever run keeps a dozen images on  
disk, so this is usually where the space went. You are asked before every  
version, unless you name one with --version.  
  
The default version used by the playground is never proposed for removal.

## Usage

```bash
playground remove-cp-docker-images [OPTIONS]
```

## Options

#### *--version VERSION*

🔢 Specific version to remove


