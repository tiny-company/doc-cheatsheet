# Tcp dump usage

## tcmdump usefull commands 

- See available interface for tcpdump :
```
tcmpdump -D
```

- Read a pcap file : 
```
tcpdump -nn -r webserver.pcap
```

## basic capture 

capture http traffic example : 
```
tcpdump -i ens33 -nn -s0 -v port 443
```

-nn : un seul (n) ne résoudra pas les noms d’hôte. Un double (nn) ne résoudra pas les noms d’hôte ou les ports. Ceci est pratique non seulement pour visualiser les numéros IP / port, mais également lors de la capture d’une grande quantité de données, car la résolution du nom ralentira la capture.
-i <interface> :	Ecouter une interface réseau spécifique, .e.g. “-i igb0”
-w <filename> :	Enregistrez la capture au format pcap dans <nom de fichier>, par exemple “-W /tmp/wan.pcap”
-s	Durée de capture: quantité de données à capturer à partir de chaque image
-c <packets> : Quitter après avoir reçu un nombre spécifique de paquets
-p :	Ne mettez pas l’interface en mode promiscuité
-v :	Mode Verbose (bavard)
-e	: Imprimer l’en-tête de la couche de liaison sur chaque ligne

a more advanced command example : 
```
tcpdump -nn -s0 -v -i eth0 -w /tmp/11_10_2023_capture.pcap host 109.190.117.17 and port 443 and port 80 
```

## manage tcpdump output

- file output (using "-w") :
```
tcpdump -i any -w webserver.pcap
```

## tcpdump filter 

- filter by ip address (using host) :
```
tcpdump host 212.122.15.13
```

- filter by packet source or destination : 
```
tcpdump src 212.122.15.13
tcpdump dst 212.122.15.13
```

- filter by network :
```
tcpdump net 1.2.3.0/24
```


## Sources : 

- [tcp dump linux documentation](https://lea-linux.org/documentations/Tcpdump)