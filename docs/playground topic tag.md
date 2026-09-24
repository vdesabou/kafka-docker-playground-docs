# playground topic tag

🏷️ Stream Catalog tags (Confluent Cloud only)  
  
Tag definitions live in the Stream Catalog of the environment, served  
by the Schema Registry endpoint. Create a tag once, then assign it to  
topics and search topics by tag.  
  
  list     tag definitions  
  create   create a tag definition  
  delete   delete a tag definition  
  add      assign a tag to a topic  
  remove   remove a tag from a topic  
  show     tags assigned to a topic  
  search   topics having a tag  
  
🎓 Tip: a newly created topic can take a minute to show up in the  
Stream Catalog before a tag can be assigned to it.

## Usage

```bash
playground topic tag COMMAND
```

## == Commands ==

- [list](playground%20topic%20tag%20list) - 🏷️ List tag definitions
- [create](playground%20topic%20tag%20create) - 🆕 Create a tag definition
- [delete](playground%20topic%20tag%20delete) - ❌ Delete a tag definition
- [add](playground%20topic%20tag%20add) - 🏷️ Assign a tag to a topic
- [remove](playground%20topic%20tag%20remove) - 🧽 Remove a tag from a topic
- [show](playground%20topic%20tag%20show) - 🔎 Show tags assigned to a topic
- [search](playground%20topic%20tag%20search) - 🔎 Search topics having a tag


