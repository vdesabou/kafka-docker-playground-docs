# playground stop

🛑 Stop currently running example  
  
Tears down every container of the environment and of the example, and  
removes their volumes, by replaying the docker compose command stored in  
playground.ini. Nothing is left behind, so the next example starts clean.  
  
❕ Data is not kept: topics, connectors and the content of the databases  
   started by the example are gone.  
  
For a Confluent Cloud example, the connectors and topics it created are  
listed and deleted too, after asking for confirmation. Change this with  
'playground config cleanup-ccloud-resources-after-run ask|true|false'.

## Usage

```bash
playground stop
```


