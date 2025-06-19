# playground connector-plugin display-last-updated

🆕 List last updated connector plugins from confluent hub https://www.confluent.io/hub/

## Usage

```bash
playground connector-plugin display-last-updated [OPTIONS]
```

## Options

#### *--days DAYS*

📅 Number of days to look back  
  
Default is 3 days

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 3

#### *--vendor VENDOR*

🏢 Only display results for this vendor

## Examples

```bash
playground connector-plugin display-last-updated --days 7
playground connector-plugin display-last-updated --days 7 --vendor confluentinc

```


