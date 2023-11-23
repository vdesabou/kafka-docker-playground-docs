# playground debug heap-dump

👻 Take a heap dump  
  
🔖 It will save output to a .hprof file. VisualVM (https://visualvm.github.io/) or MAT (https://www.eclipse.org/mat/) can be used to read the file.

## Usage

```bash
playground debug heap-dump [OPTIONS]
```

## Options

#### *--container, -c CONTAINER*

🐳 Container name

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | connect

## Examples

```bash
playground debug heap-dump
```

```bash
playground debug heap-dump --container broker
```


