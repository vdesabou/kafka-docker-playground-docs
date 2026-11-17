# playground ec2 auto-stop

⏰ Stop your EC2 instances left running, every evening, automatically

- **enable**: schedule it (default 20:00), then show what it would stop
- **disable**: remove the schedule
- **status**: is it scheduled, when, and what the last runs did
- **run**: what the job does, now (`--dry-run` to only show it)

Every day at `--time`, your playground instances (pg-`<user>`-\*) still  
running are stopped, like `playground ec2 stop`: the disk is kept,  
`playground ec2 start` gets your work back. A macOS notification tells  
which ones.

An instance is kept when:  
🔥 it was busy: its CPU (CloudWatch CPUUtilization, 5 minute averages)  
reached 5% in the last `--idle-minutes` (default 60), so a long run  
or benchmark started detached goes on. `--idle-minutes` 0 stops it  
whatever it is doing  
🕐 it was started less than `--idle-minutes` ago  
🏷️ it has the tag playground-keep-running=true (aws ec2 create-tags  
`--resources` `<instance id>` `--tags` Key=playground-keep-running,Value=true)

macOS: a launchd agent (~/Library/LaunchAgents), which also runs when the  
Mac wakes up if it was asleep at that time. Linux: a crontab line. The  
aws CLI must work without a prompt: ~/.aws/credentials (no SSO login to  
renew) and a region (`AWS_REGION` or ~/.aws/config).

## Usage

```bash
playground ec2 auto-stop COMMAND
```

## Commands

- [enable](playground%20ec2%20auto-stop%20enable) - ⏰ Schedule the auto-stop, then show what tonight's run would stop
- [disable](playground%20ec2%20auto-stop%20disable) - 🛑 Remove the auto-stop schedule
- [status](playground%20ec2%20auto-stop%20status) - 🔎 Is the auto-stop scheduled, at what time, and what did its last runs do
- [run](playground%20ec2%20auto-stop%20run) - ⏰ Stop now your idle EC2 instances still running, as the scheduled job does


