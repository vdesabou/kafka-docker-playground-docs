# playground connector display-metrics-api-with-grafana

📊 Display metrics api for fully managed connector in Grafana dashboard  
  
Same metrics as display-metrics-api, but plotted over time in Grafana  
instead of printed once. Use it when you need to see a trend, a spike or  
the moment throughput dropped, rather than the current value.  
  
It starts its own prometheus and grafana containers with a dashboard  
already provisioned, so there is nothing to enable beforehand and it  
does not interfere with the grafana of the example.  
  
Not supported for custom connectors.

## Usage

```bash
playground connector display-metrics-api-with-grafana [OPTIONS]
```

## Options

#### *--connector, -c CONNECTOR*

🔗 Connector name  
  
🎓 Tip: If not specified, the command will apply to all connectors


