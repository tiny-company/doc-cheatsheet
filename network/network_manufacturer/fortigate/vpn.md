# vpn on fortigate

## Description 

This note will quickly explain how IPSEC works and how to configure an IPSEC VPN tunnel on a fortigate.

Before we can protect any IP packets, we need two IPsec peers that build the IPsec tunnel.
To establish an IPsec tunnel, we use a protocol called IKE (Internet Key Exchange).

The entire process of IPsec consists of five steps:

-Initiation: something has to trigger the creation of our tunnels. For example when you configure IPsec on a router, you use an access-list to tell the router what data to protect. When the router receives something that matches the access-list, it will start the IKE process. It’s also possible to manually initiate the tunnel.
-IKE phase 1: we negotiate a security association to build the IKE phase 1 tunnel (ISAKMP tunnel).
-IKE phase 2: within the IKE phase 1 tunnel, we build the IKE phase 2 tunnel (IPsec tunnel).
-Data transfer: we protect user data by sending it through the IKE phase 2 tunnel.
-Termination: when there is no user data to protect then the IPsec tunnel will be terminated after awhile.

But for more classic usage (when VPN is built and trigger manually), it depend only on 2 steps (two phases to build an IPsec tunnel):

- [IKE phase 1](#set-ipsec-ike-phase-1-key-exchange) 
- [IKE phase 2](#set-ipsec-ike-phase-2-security-assocation)


### Set IPSEC (IKE) phase 1 (Key Exchange)

In IKE phase 1, two peers will negotiate about the encryption, authentication, hashing and other protocols that they want to use and some other parameters that are required. In this phase, an ISAKMP (Internet Security Association and Key Management Protocol) session is established. This is also called the ISAKMP tunnel or IKE phase 1 tunnel.

The collection of parameters that the two devices will use is called a SA (Security Association). The two peers will negotiate about the following items:

- Hashing: we use a hashing algorithm to verify the integrity, we use MD5 or SHA for this.
- Authentication: each peer has to prove who he is. Two commonly used options are a pre-shared key or digital certificates.
-DH (Diffie Hellman) group: the DH group determines the strength of the key that is used in the key exchange process. The higher group numbers are more secure but take longer to compute.
-Lifetime: how long does the IKE phase 1 tunnel stand up? the shorter the lifetime, the more secure it is because rebuilding it means we will also use new keying material. Each vendor uses a different lifetime, a common default value is 86400 seconds (1 day).
-Encryption: what algorithm do we use for encryption? For example, DES, 3DES or AES.


The IKE phase 1 tunnel is only used for management traffic. We use this tunnel as a secure method to establish the second tunnel called the IKE phase 2 tunnel or IPsec tunnel and for management traffic like keepalives.



### Set IPSEC (IKE) phase 2 (Security assocation)

Once IKE phase 2 is completed, we have an IKE phase 2 tunnel (or IPsec tunnel) that we can use to protect our user data. This user data will be sent through the IKE phase 2 tunnel.

IKE builds the tunnels for us but it doesn’t authenticate or encrypt user data. We use two other protocols for this:

- AH (Authentication Header)
- ESP (Encapsulating Security Payload)

AH and ESP both offer authentication and integrity but only ESP supports encryption. Because of this, ESP is the most popular choice nowadays.

Both protocols support two different modes:

- Transport mode
- Tunnel mode



## Source : 

- [Very good tutorial about IPSEC VPN](https://networklessons.com/cisco/ccie-routing-switching/ipsec-internet-protocol-security#IKE_Internet_Key_Exchange)
- [Video explaining IPSEC VPN](https://www.youtube.com/watch?v=15amNny_kKI&ab_channel=LearnCantrill)
- [Video tutorial to set VPN on fortigate](https://www.youtube.com/watch?v=xwYELqt4mPo&ab_channel=KBTrainings)
- [Video explaining VPN datagram](https://www.youtube.com/watch?v=RZUZk8EJflY&ab_channel=L%27informateur)
- [Fortinet documentation about setting IPSEC VPN](https://docs.fortinet.com/document/fortigate/6.2.9/cookbook/790613)
- [juniper tutorial on IPSEC vpn](https://www.juniper.net/documentation/fr/fr/software/junos/vpn-ipsec/topics/topic-map/security-ipsec-basics.html)