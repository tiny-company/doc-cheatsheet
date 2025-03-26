# vlan configuration on fortigate 

- to add vlan subinterface :
```
config system interface
    edit VLAN_100
        set vdom root
        set interface internal
        set type vlan
        set vlanid 100
        set mode static
        set ip 10.1.1.1 255.255.255.0
        set allowaccess https ping
    next
```

## source :  

- [Video tutorial that describe the whole basic configuration on fortigate 80D](https://www.youtube.com/watch?v=RB0DfizwroI&ab_channel=KBTrainingsEnFran%C3%A7ais)
- [FortiOs 5.0 documentation](https://docs.fortinet.com/product/fortigate/5.0)