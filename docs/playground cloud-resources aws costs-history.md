# playground cloud-resources aws costs-history

👛  Retrieve aws costs for each month since last year

One line per month over the past year, drawn as a histogram, which  
makes a month that went wrong obvious at a glance. Use costs when you  
then want to know which service it was.

By default it will only display total cost in dollars. Use the `--detailed` flag to see more information.

🌐 Also writes a self-contained HTML report in `--output-dir`, opened in the browser in an interactive terminal (`--no-open` to skip): cost per month, per service and usage type, the month x service matrix, the top usage types with the ones still billing, and the details of each month.

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


