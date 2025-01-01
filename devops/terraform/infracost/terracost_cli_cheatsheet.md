# terracost cli cheatsheet

## basic cmd

- get infracost version :
```
infracost --version
```

## API keys mgmt
- get the api key register in file "~/.config/infracost/credentials.yml" :
```
infracost configure get api_key
```

- set the api key :
```
infracost configure set api_key <MY_API_KEY>
```

## Debug 

- Show only unsupported ressources in the breakdown :
```
infracost breakdown --path . --format=json | jq ".summary.unsupportedResourceCounts"
``` 

## source :

- [infracost documentation](https://www.infracost.io/docs/)