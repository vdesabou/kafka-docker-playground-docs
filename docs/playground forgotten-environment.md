# playground forgotten-environment

🔔 Get a macOS notification every evening when a local environment was left running with nobody using it. It never stops anything

- **enable**: schedule the check (default every day at 19:00), then run it once now
- **disable**: remove the schedule
- **status**: is it scheduled, when, and what the last checks found
- **run**: the check, now

An environment left running all night eats CPU, RAM and battery. The check  
looks at the containers running on the engine (every session and worktree  
shares it) and notifies when both are true:

🐳 the most recent container started more than `--idle-hours` ago  
(default 3)  
💤 no playground activity for `--idle-hours` in the checkout (or worktree)  
that started them: no write to its playground.ini (playground run,  
connector, topic… commands) nor to its playground-run-history

The notification gives the example, the checkout, how long it has been  
running and the memory it uses, and suggests playground stop. It never stops  
anything by itself: another session, a long benchmark or a repro waiting  
for a customer can run on purpose. Nothing happens when the container  
engine is not running or no container runs.

macOS: a launchd agent (~/Library/LaunchAgents), which also runs when the  
Mac wakes up if it was asleep at that time. Linux: a crontab line (the  
check is logged, no notification).

## Usage

```bash
playground forgotten-environment COMMAND
```

## Commands

- [disable](playground%20forgotten-environment%20disable) - 🛑 Remove the schedule of the forgotten environment check
- [enable](playground%20forgotten-environment%20enable) - 🔔 Schedule the evening check of a forgotten local environment, then run it once now
- [run](playground%20forgotten-environment%20run) - 🔔 Check now whether a local environment runs with nobody using it, as the scheduled job does
- [status](playground%20forgotten-environment%20status) - 🔎 Is the forgotten environment check scheduled, when, and what did its last checks find


