# playground cloud-resources aws costs-history

👛  Retrieve aws costs for each month since last year

One line per month over the past year, drawn as a histogram, which  
makes a month that went wrong obvious at a glance. Use costs when you  
then want to know which service it was.

By default it will only display total cost in dollars. Use the `--detailed` flag to see more information.

🌐 Also writes a self-contained HTML report in `--output-dir`, opened in the browser in an interactive terminal (`--no-open` to skip): cost per month, per service and usage type, the month x service matrix, the top usage types, and the details of each month.

🪣 When S3 costs something, the report adds the Amazon S3 details: cost and volume (GB, requests) of each kind of S3 usage per month (storage, requests, Standard-IA retrieval, data sent to the Internet or to another region), the S3 buckets tagged cflt_managed_id=`<user>` (region, size per storage class, objects, access logging, lifecycle) and hints. Cost Explorer has no cost per bucket: that needs the resource-level data of the payer account.

## Usage

```bash
playground cloud-resources aws costs-history [OPTIONS]
```

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

🧪 Sample of tools/cloud-costs/samples: writes the HTML report from this dummy cost data, without calling AWS

To see what the report looks like before running it on your account.

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `aws_dummy`

## Examples

```bash
playground cloud-resources aws costs-history
```

```bash
playground cloud-resources aws costs-history --sample aws_dummy
```


