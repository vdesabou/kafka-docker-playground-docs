# playground connector-plugin

🔌 Connector-plugin commands  
  
Questions about connector plugins on Confluent Hub, answered without a  
running environment:  
  
  versions              every released version of a plugin  
  display-last-updated  what was published recently, by vendor  
  search-jar            which jars ship in it, and which class is where  
  sourcecode            open the source on GitHub  
  
🎓 Tip: search-jar answers "is this class really in the plugin, and with  
which signature", which is the question behind most NoSuchMethodError and  
ClassNotFoundException reports.

## Usage

```bash
playground connector-plugin COMMAND
```

## == Commands ==

- [search-jar](playground%20connector-plugin%20search-jar) - ☕ List jars for a connector plugin from confluent hub https://www.confluent.io/hub/
- [versions](playground%20connector-plugin%20versions) - 💯 List versions for a connector plugin from confluent hub https://www.confluent.io/hub/
- [display-last-updated](playground%20connector-plugin%20display-last-updated) - 🆕 List last updated connector plugins from confluent hub https://www.confluent.io/hub/
- [sourcecode](playground%20connector-plugin%20sourcecode) - 🧑‍💻 Open source code url in your browser (or in your editor when used with --open)


