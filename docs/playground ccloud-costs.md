# playground ccloud-costs

💰  Retrieve ccloud costs for a range of dates  
  
All you have to do is to be already logged in with confluent CLI. It is using https://docs.confluent.io/cloud/current/billing/overview.html#retrieve-costs-for-a-range-of-dates  
  
Cost data can take up to 72 hours to become available.  
  
Start date can reach a maximum of one year into the past  
  
One month is the maximum window between start and end dates  
  
For accuracy, Confluent recommends using a start_date that is at least 72 hours prior to the current date and time.

## Usage

```bash
playground ccloud-costs [OPTIONS]
```

## Dependencies

#### *confluent*

visit https://docs.confluent.io/confluent-cli/current/overview.html to install

## Options

#### *--start-date START_DATE*

🗓️ start date in format yyyy-mm-dd  
  
Default is 30 days ago

#### *--end-date END_DATE*

🗓️ end date in format yyyy-mm-dd  
  
  Default is 3 days ago


