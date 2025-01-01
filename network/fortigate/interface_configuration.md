# fortigate interface configuration

- confi an interface named "external" :
```
config system interface
    edit external
        set mode static
        set ip 172.16.21.2 255.255.255.0
end
```

## Sources :

- [FortiOs 5.0 documentation](https://docs.fortinet.com/product/fortigate/5.0)