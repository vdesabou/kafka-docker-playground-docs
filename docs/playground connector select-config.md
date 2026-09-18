# playground connector select-config

🗜️ Easily select config from all possible configuration parameters of connector  
  
An fzf picker over everything the plugin accepts. Type a few letters,  
pick the properties you want and they are printed, with their default  
value when there is one, ready to paste into a connector configuration.  
On macOS they are copied to your clipboard as well.  
  
Faster than show-config-parameters when you already know roughly what  
you are after and just want the exact property names.  
  
🎓 Tip: use \<tab\> to select multiple config at once, then press \<enter\> to confirm

## Usage

```bash
playground connector select-config [OPTIONS]
```

## Dependencies

#### *fzf*

visit https://github.com/junegunn/fzf#installation to install

## Options

#### *--connector, -c CONNECTOR*

🔗 Connector name  
  
🎓 Tip: If not specified, the command will apply to all connectors


