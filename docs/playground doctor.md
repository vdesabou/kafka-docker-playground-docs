# playground doctor

🩺 Check that the container engine is ready for the playground  
  
Reports which engine the 'docker' CLI is really talking to — 🐳 Docker or  
🦭 Podman — and checks what has to be right before any example can start:  
the engine is reachable, compose v2 is there, there is enough memory, and,  
with podman, that short image names resolve, that privileged ports can be  
published and that bind mounts will be readable from the host.  
  
This is the one command that still runs when the engine is down, so it is  
what to run first when an example fails before a single container starts.  
  
Exits 1 if it found a blocking problem, 0 otherwise.  
  
👉 Check documentation https://kafka-docker-playground.io/#/how-to-use?id=%f0%9f%a6%ad-using-podman-instead-of-docker

## Usage

```bash
playground doctor
```

## Examples

```bash
playground doctor
```


