# playground ccloud-costs

💰  Retrieve ccloud costs for a range of dates

All you have to do is to be already logged in with confluent CLI. It is using https://docs.confluent.io/cloud/current/billing/overview.html#retrieve-costs-for-a-range-of-dates

Cost data can take up to 72 hours to become available.

Start date can reach a maximum of one year into the past

One month is the maximum window between start and end dates

For accuracy, Confluent recommends using a start_date that is at least 72 hours prior to the current date and time.

🌐 Also writes a self-contained HTML report in `--output-dir`, opened in the browser in an interactive terminal (`--no-open` to skip): cost per day, per product and environment, the resources still billing, the top resources, the resources of each product, the product x environment matrix and the cost per line type.

## Usage

```bash
playground ccloud-costs [OPTIONS]
```

## Dependencies

#### *confluent*

visit https://docs.confluent.io/confluent-cli/current/overview.html to install

## Options

#### `--start-date START_DATE`

🗓️ start date in format yyyy-mm-dd

Default is 30 days ago

#### `--end-date END_DATE`

🗓️ end date in format yyyy-mm-dd

Default is 3 days ago

#### `--output-dir, -o OUTPUT_DIR`

📂 Output directory for the HTML report (default: /tmp/playground-cloud-costs)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `/tmp/playground-cloud-costs`

#### `--no-open`

🚫 Do not open the HTML report in the browser

#### `--sample, -s SAMPLE`

🧪 Sample of tools/cloud-costs/samples: writes the HTML report from the last month of this dummy billing data, without calling Confluent Cloud

To see what the report looks like before running it on your organization.

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `ccloud_dummy`

## Examples

```bash
playground ccloud-costs
```

```bash
playground ccloud-costs --start-date 2026-09-01 --end-date 2026-10-01
```

```bash
playground ccloud-costs --sample ccloud_dummy
```


