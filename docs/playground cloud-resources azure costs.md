# playground cloud-resources azure costs

💰 Show azure costs  
  
Spend over a range of dates for your subscription, using the Azure  
Cost Management API. You need to be logged in with the az CLI.  
  
Defaults cover the last month, ending 3 days ago because the data  
takes a couple of days to consolidate. --start-date cannot go back  
more than one year.  


## Usage

```bash
playground cloud-resources azure costs [OPTIONS]
```

## Options

#### *--start-date START_DATE*

🗓️ start date in format yyyy-mm-dd  
  
Default is 30 days ago

#### *--end-date END_DATE*

🗓️ end date in format yyyy-mm-dd  
  
  Default is 3 days ago


