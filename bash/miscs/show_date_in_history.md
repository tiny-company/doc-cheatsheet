# show date in history cmd 

# one time edition 

- export env var "HISTTIMEFORMAT" : 
```
export HISTTIMEFORMAT="%d/%m/%y %T "
```

# permanent change 

- edit .bashrc file : 
```
echo 'export HISTTIMEFORMAT="%d/%m/%y %T "' >> ~/.bash_profile
source ~/.bash_profile
```
