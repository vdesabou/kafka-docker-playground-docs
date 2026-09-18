# playground connector plugins

🎨 Show all connector plugins installed. You can also display transforms, converters and predicates using --all flag  
  
The first thing to check when a connector fails to be created with  
"Failed to find any class that implements Connector": the class you  
asked for is not in this list, so the plugin was not installed or not  
picked up from the plugin path.

## Usage

```bash
playground connector plugins [OPTIONS]
```

## Options

#### *--verbose, -v*

🐞 Show command being ran.

#### *--all*

🌕 Show also transforms, converters, predicates available


