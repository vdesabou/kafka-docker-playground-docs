# playground consumer-group

👥 Consumer group commands

Inspect any consumer group (not only the ones of sink connectors): which  
groups exist, their state and members, and the committed offsets and lag  
per partition. Works on plaintext, secured environments, cfk and  
Confluent Cloud.

- **list**: consumer groups, optionally with their state
- **describe**: committed offsets and lag, or `--state`, or `--members`
- **reset-offsets**: rewind or fast-forward a group (earliest, latest, datetime...)
- **delete**: delete a group, or its offsets for one topic

🎓 Tip: for a sink connector, `playground connector show-lag` follows the  
lag until it reaches 0.

## Usage

```bash
playground consumer-group COMMAND
```

## Topic commands

- [list](playground%20consumer-group%20list) - 👥 List consumer groups
- [describe](playground%20consumer-group%20describe) - 🔬 Describe consumer group
- [reset-offsets](playground%20consumer-group%20reset-offsets) - ⏪ Reset the committed offsets of a consumer group
- [delete](playground%20consumer-group%20delete) - 🗑️ Delete a consumer group, or its offsets for one topic


