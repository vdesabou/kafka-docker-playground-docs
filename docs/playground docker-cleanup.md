# playground docker-cleanup

🧽 Free the disk of the container engine every week, automatically: old Confluent Platform images, dangling images, old build cache

- **enable**: schedule it (default every Sunday at 10:00), then show what it would remove
- **disable**: remove the schedule
- **status**: is it scheduled, when, and what the last runs freed
- **run**: what the job does, now (`--dry-run` to only show it)

Every Confluent Platform version you run keeps a dozen images (several GB),  
and the connect images patched or built locally leave dangling images and  
build cache behind. A full disk of the Docker VM then makes examples fail  
in confusing ways. Every week it runs:

🧹 playground remove-cp-docker-images `--older-than` `<days>` `--yes`: the  
versions not used for `--older-than` days (default 60). Never the  
default TAG, the TAG of the current run, nor a version used by a  
container, running or stopped. A version with no last use known  
(podman records no pull date) is kept `--older-than` days after the  
first time it was listed  
🗑️ docker image prune: the dangling images (`<none>`), never one used by a  
container  
🧱 docker builder prune `--max-used-space` `<GB>`: the build cache above  
`--max-build-cache` GB (default 10), least recently used first. The  
layers it shares with images don't count: they go with the images

None of them touches what a container or a build in progress uses, so it  
also runs while examples run (other sessions included). Volumes are never  
removed. Skipped when the container engine is not running. A macOS  
notification tells how much was freed.

macOS: a launchd agent (~/Library/LaunchAgents), which also runs when the  
Mac wakes up if it was asleep at that time. Linux: a crontab line.

## Usage

```bash
playground docker-cleanup COMMAND
```

## Commands

- [enable](playground%20docker-cleanup%20enable) - 🧽 Schedule the weekly cleanup, then show what it would remove now
- [disable](playground%20docker-cleanup%20disable) - 🛑 Remove the weekly cleanup schedule
- [status](playground%20docker-cleanup%20status) - 🔎 Is the weekly cleanup scheduled, when, and what did its last runs free
- [run](playground%20docker-cleanup%20run) - 🧽 Free the disk of the container engine now, as the weekly job does


