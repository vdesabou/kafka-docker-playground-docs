# playground schema set-compatibility

🛡️ Set subject-level compatibility  
  
Overrides the rule for one subject:  
  
  BACKWARD     new schema can read data written with the previous one  
  FORWARD      previous schema can read data written with the new one  
  FULL         both  
  NONE         anything is accepted  
  *_TRANSITIVE checked against all past versions, not just the last  
  
Set it to NONE when you deliberately want to register an incompatible  
schema, typically to reproduce what it does to consumers downstream.

## Usage

```bash
playground schema set-compatibility [OPTIONS]
```

## Options

#### *--subject SUBJECT*

📛 Subject name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--verbose, -v*

🐞 Show command being ran.

#### *--compatibility COMPATIBILITY*

Schema Registry compatibility rule

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes
| Allowed Values: | BACKWARD, BACKWARD_TRANSITIVE, FORWARD, FORWARD_TRANSITIVE, FULL, FULL_TRANSITIVE, NONE


