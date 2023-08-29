# playground topic consume

📥 Consume topic from beginning

## Usage

```bash
playground topic consume [OPTIONS]
```

## Options

#### *--verbose, -v*

🐞 Show command being ran.

#### *--topic, -t TOPIC*

🗳 Topic name

#### *--max-messages MAX-MESSAGES*

Max number of messages to display (default is 50)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 50

#### *--min-expected-messages MIN-EXPECTED-MESSAGES*

Minimum expected number of messages to be present in topic, returns an error if this is not the case  
  
Note: --topic should be specified in this case.

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 

#### *--grep GREP*

Verify that topic content contains record which contains specified string

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 

#### *--timeout TIMEOUT*

Max number of seconds to wait when --min-expected-messages is used.  
  
Default is 60 seconds

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 60

#### *--tail*

Tail on logs.

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | *--min-expected-messages, --max-messages*

#### *--plot-latencies-timestamp-field TIMESTAMP*

🗳 Timestamp field name that represents when record was created in source system


