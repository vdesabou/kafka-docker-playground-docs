# playground tools redos-check

🪖 Check topics.regex for ReDos vulnerabilities using recheck (https://github.com/makenowjust-labs/recheck)  
  
Some regular expressions take exponential time on certain inputs. A sink  
connector using such a pattern in topics.regex can pin a CPU and stall  
the whole worker on a topic name that happens to hit the bad case, with  
nothing in the logs to explain it.  
  
Give it the regex and it answers safe, vulnerable, or timeout when the  
analysis itself takes longer than --timeout. The exit code matches:  
0 safe, 1 vulnerable, 2 timeout.  
  
🎓 Tip: worth running whenever a customer reports a connect worker at  
100% CPU with no progress and a topics.regex in the configuration.

## Usage

```bash
playground tools redos-check [OPTIONS]
```

## Options

#### *--topic-regex REGEX*

🔣 Topic regex to test

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--timeout TIMEOUT*

Max number of seconds to wait for ReDos check.  
  
Default is 1 second

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 1


