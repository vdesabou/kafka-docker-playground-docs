# playground get-ci-result

🤖 get CI result for current example  
  
Tells you whether the example you are running is green in the nightly CI,  
both for the default environment and for cfk, by reading the published  
badges from kafka-docker-playground.io.  
  
👉 Useful before you spend time debugging: if CI is red too, the breakage  
is probably not on your side. Reproduction models are always reported as  
fine, they are not part of the CI matrix.

## Usage

```bash
playground get-ci-result
```


