# terraform import

## Description

"terraform import" permit to import existing ressources created without terraform into terraform managed ressources.

## Usage

To import existing ressources, you will need to know the ressources IDs. The best way to get these IDs is to use the provider API.
Example for  contabo below (using cntb cli) :
```
cntb get instances
  INSTANCEID  NAME        DISPLAYNAME              STATUS   IMAGEID  REGION   PRODUCTID  IPV4             IPV6                                     DEFAULTUSER    
  200946   vmi946004   CONTABO-DE-P2P-DEMO-TC1  running           EU       V12        38.242.158.231   2a02:c206:2094:6004:0000:0000:0000:0001  admin          
  200950   vmi950298   CONTABO-UK-P2P-DS-TC1    running           UK       V12        149.102.148.191  2a02:c204:2095:0298:0000:0000:0000:0001  admin          
  20090   vmi909725   CONTABO-DE-P2P-DS-TC4    running           EU       V1         185.249.225.6    2a02:c206:2090:9725:0000:0000:0000:0001  admin          
  200946   vmi946000   TC-P2P-DEMO-US           running           US-east  V12        86.48.25.110     2605:a142:2094:6000:0000:0000:0000:0001  admin 
```

Then add the ressource and associate it to a ressource (example of main.tf) :
```
import {
  to = contabo_instance.test_instance
  id = "20154023"
}

resource "contabo_instance" "test_instance" {
    display_name = var.test_instance_name
}
```

## Sources :

- [terraform import blocks official doc](https://developer.hashicorp.com/terraform/language/import)
- [tutorial to import infrastructure into terraform](https://spacelift.io/blog/importing-exisiting-infrastructure-into-terraform)
- [official documentation to generate terraform configuration](https://developer.hashicorp.com/terraform/language/import/generating-configuration#generating-configuration)