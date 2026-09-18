# playground cloud-resources aws costs

💰 Show aws costs  
  
Spend over a range of dates, broken down by AWS service, using the  
Cost Explorer API. Run it after a week of heavy examples to see which  
service the money actually went to, then use  
'playground cloud-resources aws list' to find what is still up.  
  
Defaults cover the last month, ending 3 days ago because AWS needs a  
couple of days to consolidate. --start-date cannot go back more than  
one year.  


## Usage

```bash
playground cloud-resources aws costs [OPTIONS]
```

## Options

#### *--start-date START_DATE*

🗓️ start date in format yyyy-mm-dd  
  
Default is 30 days ago

#### *--end-date END_DATE*

🗓️ end date in format yyyy-mm-dd  
  
  Default is 3 days ago


