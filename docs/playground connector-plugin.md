# playground connector-plugin

🔌 Connector-plugin commands

Questions about connector plugins on Confluent Hub, answered without a  
running environment:

- **versions**: every released version of a plugin
- **changelog**: what changed between two versions (release notes)
- **display-last-updated**: what was published recently, by vendor
- **search-jar**: which jars ship in it, and which class is where
- **config-key**: what a config key does, its default, since when, who sets it
- **sourcecode**: open the source on GitHub

🎓 Tip: search-jar answers "is this class really in the plugin, and with  
which signature", which is the question behind most NoSuchMethodError and  
ClassNotFoundException reports.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-connector-plugin  
🎬 Bite size session: https://kafka-docker-playground.io/#/sessions?id=%F0%9F%A7%91%F0%9F%92%BB-the-source-code-of-a-connector-at-the-customers-version

## Usage

```bash
playground connector-plugin COMMAND
```

## Commands

- [search-jar](playground%20connector-plugin%20search-jar) - ☕ List jars for a connector plugin from confluent hub https://www.confluent.io/hub/
- [versions](playground%20connector-plugin%20versions) - 💯 List versions for a connector plugin from confluent hub https://www.confluent.io/hub/
- [changelog](playground%20connector-plugin%20changelog) - 📜 Show the release notes of a connector plugin between two versions
- [display-last-updated](playground%20connector-plugin%20display-last-updated) - 🆕 List last updated connector plugins from confluent hub https://www.confluent.io/hub/
- [config-key](playground%20connector-plugin%20config-key) - 🔑 Explain a connector configuration key: documentation, type, default, since when, and which examples set it
- [sourcecode](playground%20connector-plugin%20sourcecode) - 🧑‍💻 Open source code url in your browser (or in your editor when used with `--open`)


