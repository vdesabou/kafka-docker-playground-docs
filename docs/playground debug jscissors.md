# playground debug jscissors

✂️ jscissors is an instrumentation framework and can help to analyse control flow and perform some specific logging  
  
* Control Flow Tracing: By dynamically instrumenting Java code, the tool meticulously tracks the precise sequence of executed methods at runtime. This capability offers invaluable insights into how an application navigates its logic. The tool provides a way to generate a stack trace when a method is called.   
* Additional Logging: This enhanced logging capability provides a way to print the input arguments to a method and return value from a method.   
* Delve into heap area: Generating heap dump at a method call will be crucial to analyze the state of JVM at a given point. The tool has capabilities to generate thread dump as well to track the state of all the threads when a method is called. 

## Usage

```bash
playground debug jscissors [OPTIONS]
```

## Options

#### *--container, -c CONTAINER*

🐳 Container name  
  
🎓 Tip: you can pass multiple containers by specifying --container multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | connect

#### *--operation OPERATION*

🥼 operation to perform:  
  
* VALUES: print method input arguments  
* RETURN_VALUE: print method return value  
* THREADS: print thread dump when method is called  
* HEAP: print heap dump when method is called  
* STACK: print stack trace when method is called  
* EXCEPTION_HEAP: print heap dump when an exception is thrown during method execution  
* DELAY: print time taken for method execution  
  
Default values: VALUES, RETURN_VALUE, DELAY and STACK  
  
🎓 Tip: you can pass multiple operations by specifying --operation multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | ["VALUES", "RETURN_VALUE", "DELAY", "STACK"]
| Allowed Values: | VALUES, RETURN_VALUE, THREADS, HEAP, STACK, EXCEPTION_HEAP, DELAY

#### *--class CLASS*

class name to instrument (it supports regex like oracle.jdbc.*)

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--method METHOD*

method name to instrument (it supports regex like .*find.*)  
  
🎓 Tip: you can pass multiple methods by specifying --method multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | .*

#### *--action ACTION*

🟢 enable or disable

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | enable
| Allowed Values: | enable, disable

## Examples

```bash
playground debug jscissors
```

```bash
playground debug jscissors --container broker
```


