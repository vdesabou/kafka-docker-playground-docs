# playground account salesforce check

🩺 Check that the stored Salesforce credentials work

Logs in with the OAuth JWT bearer flow, exactly like a connector with  
salesforce.grant.type=`JWT_BEARER` (stored `SALESFORCE_USERNAME`,  
`SALESFORCE_CONSUMER_KEY_WITH_JWT`, `SALESFORCE_INSTANCE` and the keystore),  
explains a rejection, then checks that the org has MyPlatformEvent__e and  
Change Data Capture on Contact (warnings: only some examples need them).  
Needs neither Docker nor the sf CLI.

Exits with 1 when the login fails.

## Usage

```bash
playground account salesforce check [OPTIONS]
```

## Options

#### `--suffix SUFFIX`

🧩 Store the variables with this suffix, e.g. `KDP_CDC` gives `SALESFORCE_USERNAME_KDP_CDC`

#### `--account2`

2️⃣ Store the variables of the second org (`SALESFORCE_USERNAME_ACCOUNT2`…), used by the sink examples

#### `--keystore KEYSTORE`

🔐 PKCS12 keystore (password confluent) holding the JWT private key and certificate

setup: it becomes your keystore (~/.config/kafka-docker-playground/salesforce-confluent.keystore.jks),  
copied into the Salesforce example folders.  
check: default is your keystore, else connect/connect-salesforce-cdc-source/salesforce-confluent.keystore.jks.

## Examples

```bash
playground account salesforce check
```

```bash
playground account salesforce check --suffix KDP_CDC
```

```bash
playground account salesforce check --account2
```


