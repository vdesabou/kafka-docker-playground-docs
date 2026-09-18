# playground container recreate

💫 Recreate container(s)  
  
👉 Check documentation https://kafka-docker-playground.io/#/how-to-use?id=%e2%99%bb%ef%b8%8f-re-create-containers  
  
Replays the docker compose command of the example, so a container is  
rebuilt from its current definition. This is what applies a change  
made with 'playground container set-environment-variables' or  
'playground container update', and what you use to restart a component  
from scratch without re-running the whole example.

## Usage

```bash
playground container recreate [OPTIONS]
```

## Options

#### *--ignore-current-versions*

Ignore current confluent platform version  
  
By default, the current version is used


