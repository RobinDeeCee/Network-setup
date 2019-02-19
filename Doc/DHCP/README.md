# DHCP opzetten
om de DHCP op te zetten hebben we volgende rollen gebruikt:
- bertvv.rh-base
- bertvv.dhcp

# Configuratie bestand

```
rhbase_firewall_allow_services: [dhcp]

dhcp_global_domain_name_servers: 192.16.0.2

dhcp_global_domain_name: avalon.lan

dhcp_global_domain_name_servers:
- 192.0.2.10
- 192.0.2.11

dhcp_global_routers: 172.16.255.254

dhcp_subnets:
- ip: 172.16.0.0
  netmask: 255.255.0.0
  domain_name_servers:
    - 192.0.2.10
    - 192.0.2.11
  default_lease_time: 432000
  range_begin: 172.16.192.1
  range_end: 172.16.255.253
  allow: unknown-clients
  routers: 172.16.255.254
```
# De rol rh-base
Deze rol gaan we vooral gebruiken  om de de firewall aan te spreken. De firewall zal de service dhcp moeten toevoegen. Dit doen we met volgend commando.
```
rhbase_firewall_allow_services: [dhcp]
```

# De rol DHCP
In deze rol gaan we alles van DHCP configuratie doen.
Dit volgens volgende stappen:
```
dhcp_global_domain_name_servers: 192.16.0.2
```
Hier geven we het ip-adress mee van de dns server.  
```
dhcp_global_domain_name: avalon.lan
```
Geef hier de naam van je domein in.  
```
dhcp_global_domain_name_servers:
- 192.0.2.10
- 192.0.2.11
```
Hier geven we een lijst met ip-adressen van de dns server in.
```
dhcp_global_routers: 172.16.255.254
```
Hier moet het ip-adress van de router in.
```
dhcp_subnets:
- ip: 172.16.0.0
  netmask: 255.255.0.0
  domain_name_servers:
    - 192.0.2.10
    - 192.0.2.11
  default_lease_time: 432000
  range_begin: 172.16.192.1
  range_end: 172.16.255.253
  allow: unknown-clients
  routers: 172.16.255.254
```

Hier doe je alle configuratie van het subnet.
- ip : ip van het subnet **(yes)**
- netmask :hier komt het netmask van het ip-adress 
- domain_name_servers : opnieuw voor de dns
- default_lease_time : the leasetime voor dit subnet( altijd in seconde)
- range_begin: vanaf waar worden deze ip-adressen uitgedeeld
- range_end : tot waar worden deze ip-aderessen uitgedeeld
- allow : welke hosts's zijn toegelaten
- routers: lijst van de routers
