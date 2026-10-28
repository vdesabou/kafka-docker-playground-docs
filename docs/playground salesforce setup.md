# playground salesforce setup

🛠️ Configure a Salesforce org for the Salesforce examples

Deploys, with the Salesforce CLI (sf) installed on your machine:

• an External Client App with the OAuth JWT bearer flow, trusting the  
certificate of salesforce-confluent.keystore.jks, pre-authorized for  
the profile of your user (no browser approval) and with IP  
restrictions relaxed  
• the Platform Event MyPlatformEvent__e with the text field Message__c  
• Change Data Capture on Contact

then reads the consumer key back, waits until a JWT bearer login works  
(a new app takes 2 to 10 minutes to be active), and stores  
`SALESFORCE_USERNAME`, `SALESFORCE_INSTANCE` and  
`SALESFORCE_CONSUMER_KEY_WITH_JWT` with `playground secrets set`.

Without `--target-org`, 'sf org login web' opens the browser once to log  
in: that is the only manual step. Running it again on the same org  
changes nothing.

`SALESFORCE_PASSWORD` and `SALESFORCE_SECURITY_TOKEN` can't be read from  
Salesforce: the command tells you how to store them.

🎓 Tip: use `--suffix` `KDP_CDC` (or `--account2` for the second org of the  
sink examples) to store the per-test variables read by  
salesforce_use_test_creds.

## Usage

```bash
playground salesforce setup [OPTIONS]
```

## Options

#### `--target-org, -o TARGET_ORG`

🔑 Alias or username of an org the sf CLI is already logged into

Without it, 'sf org login web' opens the browser to log in.

#### `--alias ALIAS`

🏷️ Alias given to the org by 'sf org login web' (ignored with `--target-org`)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `kdp-salesforce`

#### `--instance-url INSTANCE_URL`

🌐 Login URL, stored as `SALESFORCE_INSTANCE`

https://test.salesforce.com for a sandbox.

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `https://login.salesforce.com`

#### `--app-name APP_NAME`

📛 API name of the External Client App

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `kdp_jwt`

#### `--suffix SUFFIX`

🧩 Store the variables with this suffix, e.g. `KDP_CDC` gives `SALESFORCE_USERNAME_KDP_CDC`

#### `--account2`

2️⃣ Store the variables of the second org (`SALESFORCE_USERNAME_ACCOUNT2`…), used by the sink examples

#### `--keystore KEYSTORE`

🔐 PKCS12 keystore (password confluent) holding the JWT private key and certificate

Default is connect/connect-salesforce-cdc-source/salesforce-confluent.keystore.jks,  
downloaded from the playground S3 bucket when missing (Confluent employees only).

#### `--generate-keystore`

🆕 Generate a new key pair when the keystore is missing

It is copied into every Salesforce example folder, so the examples use it.

#### `--max-wait MAX_WAIT`

⏳ Max seconds to wait for the JWT bearer login to work after the deploy (default 600)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `600`

#### `--dry-run`

🧪 Only render the metadata in /tmp/playground-salesforce-setup, deploy and store nothing

#### `--no-store`

🚫 Print the values instead of storing them with `playground secrets set`

## Examples

```bash
playground salesforce setup
```

```bash
playground salesforce setup --target-org my-dev-org --suffix KDP_CDC
```

```bash
playground salesforce setup --account2
```

```bash
playground salesforce setup --instance-url https://test.salesforce.com --no-store
```


