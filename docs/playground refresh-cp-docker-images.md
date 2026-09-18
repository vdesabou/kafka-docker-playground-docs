# playground refresh-cp-docker-images

🔄 Refresh (pull from Docker) all Confluent Platform docker images related to a version installed locally  
  
    It also refreshes images for aws, gcp and azure cli  
  
Useful when a version tag has been re-published, or when the cloud CLI  
images have drifted behind the API they talk to.

## Usage

```bash
playground refresh-cp-docker-images [OPTIONS]
```

## Options

#### *--version VERSION*

🔢 Specific version to pull 

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes


