# playground refresh-cp-docker-images

🔄 Refresh (pull from Docker) all Confluent Platform docker images related to a version installed locally

Useful when a version tag has been re-published. Images built locally by  
the playground are skipped with a warning.

## Usage

```bash
playground refresh-cp-docker-images [OPTIONS]
```

## Options

#### `--include-cloud-cli`

☁️ Also pull the aws, azure and gcp cli images (several GB), when they have drifted behind the API they talk to

#### `--version VERSION`

🔢 Specific version to pull

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes


