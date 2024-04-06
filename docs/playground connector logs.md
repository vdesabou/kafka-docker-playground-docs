# playground connector logs

🕵️  Tail and follow connect logs  
  
This is basically a shortcut for "playground container logs --container connect"  
  
It does not work for Fully Managed connectors, except if you're a Confluent employee, this will open log in our internal tools (make sure to follow this first https://github.com/confluentinc/kafka-docker-playground-internal#how-to-use)

## Usage

```bash
playground connector logs [OPTIONS]
```

## Options

#### *--open, -o*

🔖 Save output to a file and open with text editor set with playground config editor \<editor\> (default is code)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | *--wait-for-log*

#### *--wait-for-log, -w LOG*

😴 Wait until log appears

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | *--open*

#### *--max-wait, -m MAX_WAIT*

⏳ Max time in seconds to wait when using --wait-for-log (default 600s)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 600
| Conflicts With: | *--open*

#### *--lcc-id LCC-ID*

☁️ Fully Managed lcc id (only for Confluent employees)


