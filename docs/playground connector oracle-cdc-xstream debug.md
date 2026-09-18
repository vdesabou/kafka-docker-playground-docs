# playground connector oracle-cdc-xstream debug

🐞 Execute various SQL commands to debug xstream components  
  
Runs a series of queries against the XStream views inside the oracle  
container and prints the results, with a link to the Oracle  
documentation of each view:  
  
  capture processes   their status, SCN values and latencies  
  redo logs           the files each capture process still needs  
  outbound server     general state, current transaction, low position  
  parameters          capture and apply settings actually in effect  
  rules               the rules the XStream components are using  
  
Read it top to bottom when a connector is RUNNING but idle: a capture  
process not in CAPTURING CHANGES, or an SCN that never moves, tells  
you the problem is in the database and not in the connector.  


## Usage

```bash
playground connector oracle-cdc-xstream debug
```


