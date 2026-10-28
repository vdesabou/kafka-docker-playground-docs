# playground salesforce check

🩺 Check that the stored Salesforce credentials work

Logs in with the OAuth JWT bearer flow, exactly like a connector with  
salesforce.grant.type=`JWT_BEARER` (stored `SALESFORCE_USERNAME`,  
`SALESFORCE_CONSUMER_KEY_WITH_JWT`, `SALESFORCE_INSTANCE` and the keystore),  
explains a rejection, then checks that the org has MyPlatformEvent__e and  
Change Data Capture on Contact. Needs neither Docker nor the sf CLI.

Exits with 1 when something is missing.

## Usage

```bash
playground salesforce check [OPTIONS]
```

## Options

#### `--suffix SUFFIX`

🧩 Store the variables with this suffix, e.g. `KDP_CDC` gives `SALESFORCE_USERNAME_KDP_CDC`

#### `--account2`

2️⃣ Store the variables of the second org (`SALESFORCE_USERNAME_ACCOUNT2`…), used by the sink examples

#### `--keystore KEYSTORE`

🔐 PKCS12 keystore (password confluent) holding the JWT private key and certificate

Default is connect/connect-salesforce-cdc-source/salesforce-confluent.keystore.jks,  
downloaded from the playground S3 bucket when missing (Confluent employees only).

## Examples

```bash
playground salesforce check
```

```bash
playground salesforce check --suffix KDP_CDC
```

```bash
playground salesforce check --account2
```


