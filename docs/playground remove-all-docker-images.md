# playground remove-all-docker-images

🧨 Remove all docker images (including docker volumes)  
  
Reclaims disk space by wiping your whole local Docker state, not just the  
playground one. Everything has to be pulled again afterwards, so the next  
run is slow.  
  
🎓 Tip: prefer 'playground remove-cp-docker-images' to drop only the  
Confluent Platform versions you no longer test.

## Usage

```bash
playground remove-all-docker-images
```


