# playground account databricks check

🩺 Check the Databricks workspace of the Databricks examples

Validates the token (and shows its principal, the one the grants must  
target), the SQL warehouse (or cluster) of `DATABRICKS_HTTP_PATH` and its  
state, `DATABRICKS_HOST` for the JDBC examples, and the S3 staging bucket  
with the staging keys, like the Delta Lake sink. Prints the grants the  
Delta Lake sink needs.

Read-only (it does not start the warehouse). Uses curl, and the aws CLI  
or the amazon/aws-cli image for the bucket.

Exits with 1 when the token is refused.

## Usage

```bash
playground account databricks check
```

## Examples

```bash
playground account databricks check
```


