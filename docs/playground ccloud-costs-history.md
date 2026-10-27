# playground ccloud-costs-history

👛  Retrieve ccloud costs for each month since last year

All you have to do is to be already logged in with confluent CLI. It is using https://docs.confluent.io/cloud/current/billing/overview.html#retrieve-costs-for-a-range-of-dates

By default it will only display total cost in dollars. Use the `--detailed` flag to see more information.

🌐 Also writes a self-contained HTML report in `--output-dir`, opened in the browser in an interactive terminal (`--no-open` to skip): cost per month and per day, per product, environment and line type, the month x product matrix, the top resources with the ones still billing, and the details of each month.

## Usage

```bash
playground ccloud-costs-history [OPTIONS]
```

## Dependencies

#### *confluent*

visit https://docs.confluent.io/confluent-cli/current/overview.html to install

## Options

#### `--detailed`

💹 display all details for each month

#### `--output-dir, -o OUTPUT_DIR`

📂 Output directory for the HTML report (default: /tmp/playground-cloud-costs)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `/tmp/playground-cloud-costs`

#### `--no-open`

🚫 Do not open the HTML report in the browser

#### `--sample, -s SAMPLE`

🧪 Sample of tools/cloud-costs/samples: writes the HTML report from this dummy billing data, without calling Confluent Cloud

To see what the report looks like before running it on your organization.

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `ccloud_dummy`

## Examples

```bash
playground ccloud-costs-history
```

```bash
playground ccloud-costs-history --sample ccloud_dummy
```


