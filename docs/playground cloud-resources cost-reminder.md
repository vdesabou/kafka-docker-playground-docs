# playground cloud-resources cost-reminder

💸 Every week, a notification when your cloud spend went above a threshold, or something billed is still running for you. Read-only, it never deletes anything

- **enable**: schedule it (default every Monday at 09:00), then run it once now
- **disable**: remove the schedule
- **status**: is it scheduled, when, and what the last runs found
- **run**: the check, now

The cleanups (nightly-cleanup) delete what the playground knows it  
created. This reminder covers the rest: what they keep on purpose (your  
own clusters of `playground account ccloud setup`), what was created by hand, or  
a cloud you did not schedule for cleanup. For each `--resource` it gives:

- **ccloud**: 💰 the cost of the last `--days` days of your resources, by name (connectors \*_`<user>`, clusters and environments pg-`<user>`-\*), next to the total of the organization; and what still runs for you: connectors (RUNNING ones), clusters, environments (playground cloud-resources ccloud list)
- **aws**: 💰 the cost of the resources tagged cflt_managed_id=`<user>` (Cost Explorer), and the number of resources still up (playground cloud-resources aws list)
- **azure**: 💰 the same with Cost Management (cloud-resources azure)

A macOS notification only when your cost is at least `--threshold` (USD,  
default 50), a connector still runs for you (RUNNING, billed per  
task-hour), or a cloud could not be checked; otherwise the result is only  
logged. Your own clusters alone never notify: they are there on purpose. Billing data lags (Confluent Cloud up to 72 hours,  
AWS 24 to 48 hours): the last days of the period can be incomplete.

Nothing interactive: a cloud whose credentials can't be read without a  
prompt is skipped and said so, as for the nightly cleanup (confluent  
login `--save`, ~/.aws/credentials, an Azure service principal or a saved  
az login session). The Confluent Cloud cost needs a role that can read  
the billing of the organization.

macOS: a launchd agent (~/Library/LaunchAgents), which also runs when the  
Mac wakes up if it was asleep at that time. Linux: a crontab line (logged,  
no notification).

## Usage

```bash
playground cloud-resources cost-reminder COMMAND
```

## Commands

- [disable](playground%20cloud-resources%20cost-reminder%20disable) - 🛑 Remove the weekly cost reminder schedule
- [enable](playground%20cloud-resources%20cost-reminder%20enable) - 💸 Schedule the weekly cost reminder, then run it once now
- [run](playground%20cloud-resources%20cost-reminder%20run) - 💸 Check now what your clouds cost over the last `--days` days and what still runs for you, as the weekly job does
- [status](playground%20cloud-resources%20cost-reminder%20status) - 🔎 Is the weekly cost reminder scheduled, when, and what did its last runs find


