# playground connector oracle-cdc-xstream

🅾️ Specific Oracle CDC Xstream commands  
  
With XStream, half of the interesting state lives in the database, not  
in Connect. A connector that shows RUNNING while no change arrives is  
almost always a capture process or an outbound server that is stuck on  
the Oracle side, and the connect logs say nothing about it.  
  
  debug             query the XStream views from the Oracle container  
  generate-report   run the official diagnostics script  
  
Only available when an oracle container is running.  


## Usage

```bash
playground connector oracle-cdc-xstream COMMAND
```

## == Commands ==

- [generate-report](playground%20connector%20oracle-cdc-xstream%20generate-report) - ⚙️ Generate and open oracle cdc xstream connector diagnostics
- [debug](playground%20connector%20oracle-cdc-xstream%20debug) - 🐞 Execute various SQL commands to debug xstream components


