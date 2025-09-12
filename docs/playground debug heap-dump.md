# playground debug heap-dump

👻 Take a heap dump  
  
🔖 It will save output to a .hprof file. VisualVM (https://visualvm.github.io/) or MAT (https://www.eclipse.org/mat/) can be used to read the file.  
  
It will run a full gc first. If you don't want this, use 

## Usage

```bash
playground debug heap-dump [OPTIONS]
```

## Options

#### *--container, -c CONTAINER*

🐳 Container name  
  
🎓 Tip: you can pass multiple containers by specifying --container multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | connect

#### *--live*

🧬 dump only live objects; if not specified, all objects in the heap are dumped

#### *--histo*

📊 print histogram of java object heap

## Examples

```bash
playground debug heap-dump
```

```bash
playground debug heap-dump --container broker
```


