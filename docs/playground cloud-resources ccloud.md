# playground cloud-resources ccloud

☁️ What is still running in Confluent Cloud, and what it costs

- **list**: your connectors, environments, clusters, service accounts, API keys and recorded topics, org-wide
- **costs**: spend over a range of dates, by product
- **costs-history**: spend per month over the last year

Uses the organization your confluent CLI is logged into. Nothing is  
deleted here, use `playground cloud-resources cleanup` for that.

## Usage

```bash
playground cloud-resources ccloud COMMAND
```

## Commands

- [list](playground%20cloud-resources%20ccloud%20list) - 📋 List what the playground left running for you in Confluent Cloud, across the whole organization
- [costs](playground%20cloud-resources%20ccloud%20costs) - 💰  Retrieve ccloud costs for a range of dates
- [costs-history](playground%20cloud-resources%20ccloud%20costs-history) - 👛  Retrieve ccloud costs for each month since last year


