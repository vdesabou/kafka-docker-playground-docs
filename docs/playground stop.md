# playground stop

🛑 Stop currently running example  
  
Tears down every container of the environment and of the example, and  
removes their volumes, by replaying the docker compose command stored in  
playground.ini. Nothing is left behind, so the next example starts clean.  
  
❕ Data is not kept: topics, connectors and the content of the databases  
   started by the example are gone.

## Usage

```bash
playground stop
```


