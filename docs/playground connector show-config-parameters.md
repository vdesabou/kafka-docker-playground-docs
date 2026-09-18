# playground connector show-config-parameters

🔩 Show all possible configuration parameters of connector  
  
The full reference of what the plugin accepts, with types, defaults,  
importance and documentation, read from the plugin itself rather than  
from the website. Use it to check the exact spelling of a property, or  
to discover the knob you need.  
  
Use --open to read it in your editor, --only-show-json to get it as  
json.

## Usage

```bash
playground connector show-config-parameters [OPTIONS]
```

## Options

#### *--verbose, -v*

🐞 Show command being ran.

#### *--connector, -c CONNECTOR*

🔗 Connector name  
  
🎓 Tip: If not specified, the command will apply to all connectors

#### *--open, -o*

🔖 Save output to a file and open with text editor set with playground config editor \<editor\> (default is code)

#### *--force-refresh*

☢️ Force refresh.

#### *--only-show-json*

📗 Only show list of all available parameters for connector (with default value when applicable)


