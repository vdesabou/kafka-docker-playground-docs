# playground connector delete

🗑️  Delete connector  
  
Removes the connector and its configuration. Its offsets survive in the  
Kafka internal topics, so re-creating it under the same name resumes  
where it stopped rather than starting over.  
  
For a fully managed or custom connector, the topics the connector  
created on its own are deleted as well: dead letter queue and, for  
connectors with a reporter, success and error topics (dlq-lcc-xxxx,  
success-lcc-xxxx, error-lcc-xxxx, or the names set in the config with  
errors.deadletterqueue.topic.name, reporter.error.topic.name and  
reporter.result.topic.name). Keep them with --keep-related-topics.

## Usage

```bash
playground connector delete [OPTIONS]
```

## Options

#### *--verbose, -v*

🐞 Show command being ran.

#### *--connector, -c CONNECTOR*

🔗 Connector name  
  
🎓 Tip: If not specified, the command will apply to all connectors

#### *--keep-related-topics*

🔰 Do not delete the dlq, success and error topics of a fully managed or custom connector


