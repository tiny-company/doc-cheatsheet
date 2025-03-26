# MQTT broker troubleshooting

- show all clients actually connected on the broker
```
mosquitto_sub -h localhost -t '$SYS/broker/clients/connected' -v
```

## Sources :

- [MQTT protocol status code](https://www.emqx.com/en/blog/mqtt5-new-features-reason-code-and-ack)