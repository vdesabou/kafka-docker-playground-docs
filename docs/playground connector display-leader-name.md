# playground connector display-leader-name

👑 Display Connect Worker leader name using JMX MBean leader-name from kafka.connect:type=connect-worker-rebalance-metrics  
  
This is useful when you have multiple connect workers and want to know which one is the leader.  
  
For onprem connectors, this is basically a shortcut for "playground container exec -c connect -- bash -c 'export JMX_PORT=9404; jmxterm -l localhost:9404 -n -v silent -u admin -p admin123 -e \"get -b kafka.connect:type=connect-worker-rebalance-metrics name=leader-name\"'", --connector flag is not relevant  
  
For Fully Managed connectors, this is not available as JMX is not accessible.

## Usage

```bash
playground connector display-leader-name
```


