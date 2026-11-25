# playground cloud-resources

☁️ What the playground left behind in your cloud accounts, what it costs, and cleaning it up

Examples that talk to a real cloud create real resources, and an  
interrupted run leaves them behind. These commands show what is still  
alive and what you are being billed for:

- **cloud-resources aws list**: resources still up, scoped to you
- **cloud-resources aws costs**: spend over a range of dates
- **cloud-resources aws costs-history**: spend per month over the last year

The same three exist for azure and ccloud (Confluent Cloud).

🧹 Only one command deletes anything:

- **cloud-resources cleanup**: delete the leftovers in aws, gcp, azure, ccloud and salesforce (`--resource`, `--dry-run` first)

🌙 and it can run by itself every night (Confluent Cloud, and AWS, GCP, Azure  
with `--resource`):

cloud-resources nightly-cleanup enable|disable|status

💸 and a weekly reminder of what it cost and what still runs (read-only):

cloud-resources cost-reminder enable|disable|status|run

## Usage

```bash
playground cloud-resources COMMAND
```

## Commands

- [aws](playground%20cloud-resources%20aws) - ☁️ What is still running in AWS, and what it costs
  - [costs](playground%20cloud-resources%20aws%20costs) - 💰 AWS costs
  - [costs-history](playground%20cloud-resources%20aws%20costs-history) - 👛 AWS costs for each month since last year
  - [list](playground%20cloud-resources%20aws%20list) - 📋 List all active resources
- [azure](playground%20cloud-resources%20azure) - ☁️ What is still running in Azure, and what it costs
  - [costs](playground%20cloud-resources%20azure%20costs) - 💰 Azure costs
  - [costs-history](playground%20cloud-resources%20azure%20costs-history) - 👛 Azure costs for each month since last year
  - [list](playground%20cloud-resources%20azure%20list) - 📋 List all active resources
- [ccloud](playground%20cloud-resources%20ccloud) - ☁️ What is still running in Confluent Cloud, and what it costs
  - [costs](playground%20cloud-resources%20ccloud%20costs) - 💰 Confluent Cloud costs for a range of dates
  - [costs-history](playground%20cloud-resources%20ccloud%20costs-history) - 👛 Confluent Cloud costs for each month since last year
  - [list](playground%20cloud-resources%20ccloud%20list) - 📋 List what the playground left running for you in Confluent Cloud, across the whole organization
- [cleanup](playground%20cloud-resources%20cleanup) - 🧹 Cleanup cloud resources that were created by running examples from the playground
- [cost-reminder](playground%20cloud-resources%20cost-reminder) - 💸 Every week, a notification when your cloud spend went above a threshold, or something billed is still running for you. Read-only, it never deletes anything
  - [disable](playground%20cloud-resources%20cost-reminder%20disable) - 🛑 Remove the weekly cost reminder schedule
  - [enable](playground%20cloud-resources%20cost-reminder%20enable) - 💸 Schedule the weekly cost reminder, then run it once now
  - [run](playground%20cloud-resources%20cost-reminder%20run) - 💸 Check now what your clouds cost over the last `--days` days and what still runs for you, as the weekly job does
  - [status](playground%20cloud-resources%20cost-reminder%20status) - 🔎 Is the weekly cost reminder scheduled, when, and what did its last runs find
- [nightly-cleanup](playground%20cloud-resources%20nightly-cleanup) - 🌙 Delete what your examples left running in Confluent Cloud (and AWS, GCP, Azure with `--resource`), every night, automatically
  - [disable](playground%20cloud-resources%20nightly-cleanup%20disable) - 🛑 Remove the nightly cleanup schedule
  - [enable](playground%20cloud-resources%20nightly-cleanup%20enable) - 🌙 Schedule the nightly cleanup, then show what tonight's run would delete
  - [status](playground%20cloud-resources%20nightly-cleanup%20status) - 🔎 Is the nightly cleanup scheduled, at what time, and what did its last runs do


