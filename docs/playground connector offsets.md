# playground connector offsets

💈 Handle source and sink connectors offsets  
  
Where a connector is in its data: for a source, the position it keeps in  
the system it reads from (a SCN, a binlog position, a file offset); for a  
sink, the consumer group offsets of the topics it consumes.  
  
  get                          show them  
  alter                        edit them in your editor, then apply  
  reset                        start over from the beginning  
  get-offsets-request-status   did the last change go through  
  
This uses the first-class offsets API (KIP-875), so it needs CP 7.5 for  
get and CP 7.6 for alter and reset. On older CP the playground falls back  
to kafka-consumer-groups, which only covers sink connectors.  
  
The connector must not be running while its offsets change: alter and  
reset stop it and resume it for you.  
  
🎓 Tip: a sink that reprocesses everything and a source that re-snapshots  
are usually offsets problems, not connector problems. Look here first.  


## Usage

```bash
playground connector offsets COMMAND
```

## == Commands ==

- [get](playground%20connector%20offsets%20get) - 🏹 Get current offsets for source and sink connectors
- [reset](playground%20connector%20offsets%20reset) - 🆕 Reset offsets for source and sink connectors
- [alter](playground%20connector%20offsets%20alter) - ⛏️ Alter offsets for source and sink connectors
- [get-offsets-request-status](playground%20connector%20offsets%20get-offsets-request-status) - 👁️‍🗨️ Get the status of the previous offset request


