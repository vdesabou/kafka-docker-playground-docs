# playground container kill-all

💀 Kill all containers and prune all volumes

Kills every container on your machine, playground or not, and prunes  
the volumes. It first lists each container it kills (name, image,  
status), or each pod with the cfk environment. Used automatically  
before each `playground run` to guarantee a clean slate; disable that with  
`playground config container-kill-all-before-run false`.

## Usage

```bash
playground container kill-all
```


