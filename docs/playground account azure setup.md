# playground account azure setup

🛠️ Configure an Azure subscription for the Azure examples

With the az CLI installed on your machine:

• registers the resource providers the examples use (Storage,  
DocumentDB, EventHub, ServiceBus, Kusto, Search, Web,  
OperationalInsights, Insights, Sql)  
• creates the service principal kdp-playground-`<user>` (reused if it  
exists) with the roles Contributor and Role Based Access Control  
Administrator on the subscription, and a client secret valid 1 year

then waits until the service principal can log in, and stores  
`AZ_CLIENT_ID`, `AZ_CLIENT_SECRET`, `AZ_TENANT_ID`, `AZURE_SUBSCRIPTION_NAME` and  
`AZ_USER` with `playground secrets set`: the examples then log in with it,  
no browser.

Without `--current-login`, 'az login' opens the browser once, in an az  
configuration of its own: your own az login is left alone. Running it  
again changes nothing while the stored secret still works.

⚠️ Contributor on the whole subscription: use a subscription for tests,  
not a production one.

## Usage

```bash
playground account azure setup [OPTIONS]
```

## Options

#### `--subscription, -s SUBSCRIPTION`

🗂️ Subscription name (stored as `AZURE_SUBSCRIPTION_NAME`)

Default: `AZURE_SUBSCRIPTION_NAME` (environment, then secrets store),  
else the only subscription the account can see.

#### `--current-login`

🔑 Use the account your own az is already logged into (az account show): no browser

#### `--tenant TENANT`

🏢 Tenant id or domain to log into (az login `--tenant`), when your account belongs to several

#### `--service-principal SERVICE_PRINCIPAL`

🤖 Display name of the service principal (default kdp-playground-`<user>`)

Never pg`<user>`: the data lake example resets the secrets of that app.

#### `--new-secret`

♻️ Add a new client secret even if the stored one still works

#### `--dry-run`

🧪 Only print the providers, the service principal and the roles, change nothing

#### `--no-store`

📋 Print the export commands instead of storing the variables

## Examples

```bash
playground account azure setup --subscription "My test subscription"
```

```bash
playground account azure setup --current-login
```

```bash
playground account azure setup --dry-run
```


