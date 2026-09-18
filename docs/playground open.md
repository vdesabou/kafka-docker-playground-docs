# playground open

👐 When --file is not provided, simply open last example you ran with \<playground run\>  
  
Otherwise, open any file from the playground using --file.  
  
Opens in the editor of your choice: 'playground config editor code'  
(or vi, nano, sublime, etc). Add --open-docker-compose to also open the  
docker-compose override file the example uses, which is where the  
containers around Kafka are defined.

## Usage

```bash
playground open [OPTIONS]
```

## Dependencies

#### *fzf*

visit https://github.com/junegunn/fzf#installation to install

## Options

#### *--file, -f FILE*

🔎 Search any file and open it.  
  
❕ It must be absolute full path  
  
🎓 Tip: use \<tab\> completion to trigger fzf completion  
        use \<option+enter\> to use the value you typed manually

#### *--open-docker-compose*

🐳 Also open associated docker-compose file for the current example


