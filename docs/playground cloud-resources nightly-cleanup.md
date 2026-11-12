# playground cloud-resources nightly-cleanup

🌙 Delete what your fully managed examples left running in Confluent Cloud, every night, automatically

- **enable**: schedule it (default 02:00), then show what tonight's run would delete
- **disable**: remove the schedule
- **status**: is it scheduled, when, and what the last runs did

Every night it runs 'playground cloud-resources cleanup `--resource` ccloud  
`--force`', limited to what costs money or clutters a shared cluster:

🤖 connectors named \*_`<user>`, on any cluster of the organization, with  
their dlq, success and error topics  
🌐 environments pg-`<user>`-sa-\* (the stacks the playground created when  
no `CLUSTER_NAME` was set), with their clusters  
📝 on shared clusters, the topics recorded as created by your own runs

It keeps your own clusters and their topics (playground ccloud setup),  
and never deletes service accounts or API keys: the secrets store may be  
locked at night, so the keys in use can't be told apart. Run  
`playground cloud-resources cleanup --resource ccloud` yourself for those.

macOS: a launchd agent (~/Library/LaunchAgents), which also runs when the  
Mac wakes up if it was asleep at that time. Linux: a crontab line. The  
`confluent CLI must stay logged in: 'confluent login --save'.`

## Usage

```bash
playground cloud-resources nightly-cleanup COMMAND
```

## Commands

- [enable](playground%20cloud-resources%20nightly-cleanup%20enable) - 🌙 Schedule the nightly cleanup, then show what tonight's run would delete
- [disable](playground%20cloud-resources%20nightly-cleanup%20disable) - 🛑 Remove the nightly cleanup schedule
- [status](playground%20cloud-resources%20nightly-cleanup%20status) - 🔎 Is the nightly cleanup scheduled, at what time, and what did its last runs do


