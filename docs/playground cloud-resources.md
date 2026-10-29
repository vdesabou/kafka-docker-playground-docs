# playground cloud-resources

☁️ What the playground left behind in your cloud accounts, and what it costs

Examples that talk to a real cloud create real resources, and an  
interrupted run leaves them behind. These commands show what is still  
alive and what you are being billed for:

- **cloud-resources aws list**: resources still up, scoped to you
- **cloud-resources aws costs**: spend over a range of dates
- **cloud-resources aws costs-history**: spend per month over the last year

The same three exist for azure.

🧹 Nothing is deleted here. To actually remove the resources, use  
`playground cleanup-cloud-resources`.

## Usage

```bash
playground cloud-resources COMMAND
```

## Commands

- [aws](playground%20cloud-resources%20aws) - ☁️ What is still running in AWS, and what it costs
  - [list](playground%20cloud-resources%20aws%20list) - 📋 List all active resources
  - [costs](playground%20cloud-resources%20aws%20costs) - 💰 Show aws costs
  - [costs-history](playground%20cloud-resources%20aws%20costs-history) - 👛  Retrieve aws costs for each month since last year
- [azure](playground%20cloud-resources%20azure) - ☁️ What is still running in Azure, and what it costs
  - [list](playground%20cloud-resources%20azure%20list) - 📋 List all active resources
  - [costs](playground%20cloud-resources%20azure%20costs) - 💰 Show azure costs
  - [costs-history](playground%20cloud-resources%20azure%20costs-history) - 👛  Retrieve azure costs for each month since last year


