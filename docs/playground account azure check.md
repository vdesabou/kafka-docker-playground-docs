# playground account azure check

🩺 Check that the stored Azure service principal works for the Azure examples

Logs in with `AZ_CLIENT_ID`, `AZ_CLIENT_SECRET` and `AZ_TENANT_ID` exactly like  
the examples do (client credentials), explains a rejection, then checks  
the subscription `AZURE_SUBSCRIPTION_NAME`, the roles of the service  
principal on it, the resource providers the examples use, the extra  
service principals of the CI (AZURE_LOGS_\*, AZURE_DATALAKE_\*,  
AZURE_COGNITIVE_\*) when they are set, and the resource groups your  
examples left behind.

Read-only, needs neither az nor Docker, takes a few seconds.

Exits with 1 when the service principal can't log in.

## Usage

```bash
playground account azure check [OPTIONS]
```

## Options

#### `--subscription, -s SUBSCRIPTION`

🗂️ Subscription name (stored as `AZURE_SUBSCRIPTION_NAME`)

Default: `AZURE_SUBSCRIPTION_NAME` (environment, then secrets store),  
else the only subscription the account can see.

## Examples

```bash
playground account azure check
```


