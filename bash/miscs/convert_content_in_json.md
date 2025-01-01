# convert content in json

Use jq in order to convert value in json. 
For example get content formated in json in a txt file and put result in json file
```
cat test_scaleway.txt | jq -r > test_scaleway.json
```

You can also get value from json (here getting data value from json):
```
cat test_scaleway.json | jq -r .data 
```

