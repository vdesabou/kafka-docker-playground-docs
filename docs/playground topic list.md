# playground topic list

🔘 List topics

Add `--show-internal` to also see the topics Kafka and Connect maintain  
for themselves, such as the connect configs, offsets and status  
topics.

Add `--sort-by-size` to show the size and number of partitions of each  
topic, largest first (same as `playground topic get-size`).

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-topic-administration  
🎬 Bite size session: https://kafka-docker-playground.io/#/sessions?id=%F0%9F%AA%9B-a-producer-gets-recordtoolargeexception

## Usage

```bash
playground topic list [OPTIONS]
```

## Options

#### `--show-internal`

🫥 Display internal topics

#### `--sort-by-size`

📏 Display size and number of partitions of each topic, largest first

## Examples

```bash
playground topic list
```

```bash
playground topic list --sort-by-size
```

## Example output

```text
$ playground topic list
17:22:16 ℹ️ 🔘 List of topics (internal topics are excluded)
filestream
```


