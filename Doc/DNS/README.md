# Dns opzetten
Om de dns op te zetten hebben we volgende rollen gebruikt:
- bertvv.rh-base
- bertvv.bind

# Configuratie bestand
```
rhbase_firewall_allow_services: [dns]

bind_zone_master_server_ip: 192.0.2.10

bind_listen_ipv4: ['any']

bind_allow_query: ['any']

bind_zone_domains:

    - name: avalon.lan
      name_servers:
        - pu001
        - pu002
      mail_servers: 
        - name: pu003
          preference: 10
      networks:
        - "192.0.2"
        - "172.16"
      hosts:

      - name: router
        ip: 192.0.2.254
        ip: 172.16.255.254
        aliases:
          - gw

      - name: pu001
        ip: 192.0.2.10
        aliases:
          - ns1

      - name: pu002
        ip: 192.0.2.11
        aliases:
         - ns2

      - name: pu003
        ip: 192.0.2.20
        aliases:
          - mail

      - name: pu004
        ip: 192.0.2.50
        aliases:
          - www

      - name: pr001
        ip: 172.16.0.2
        aliases:
          - dhcp

      - name: pr002
        ip: 172.16.0.3
        aliases:
          - directory

      - name: pr010
        ip: 172.16.0.10
        aliases:
          - inside

      - name: pr011
        ip: 172.16.0.11
        aliases:
          - files
      
```

# De rol rh-base
Deze rol gaan we vooral gebruiken  om de de firewall aan te spreken. De firewall zal de service dns moeten toevoegen. Dit doen we volgens volgend commando:
```
rhbase_firewall_allow_services: [dns]
```
# De rol bind
In deze rol gaan we alles van DNS configuratie doen.
Dit volgens volgende stappen:
```
bind_zone_master_server_ip: 192.0.2.10
```
Dit is het ip adress van de hoofd dns. Aangezien we de hoofd dns aan het maken zijn, is het IP adress het adres van het systeem waar we op dit moment opzitten.  Dit vindt je terug in de *vagrant-hosts.yml* file.

```
bind_listen_ipv4: ['any']
```
Hierin staat een lijst met all interface's die moeten luisteren naar de dns, in dit geval luisteren ze allemaal.
```
bind_allow_query: ['any']
```
Hierin staat een lijst met host's die allemaal kunnen querien op de dns server, in dit geval is dat iedereen.  

In de *bind_zone_domains:* vullen we paar dingen in:

- name: dit zal de naam van het domain aannemen (verplicht)
- name_servers: hierin komt een lijst met de dns master en de dns slave('s)
- mail_servers: hierin komen de mail servers in
- networks: de verschillende netwerken
- hotst: hier komt een oplijsting van alle hosts, dit bevat een naam, een ip-adress en  aliases

# dns slave
**Note** gelieve pu001 te bekijken voor meer info

# Configuratie bestand
```
  rhbase_firewall_allow_services: [dns]  

  bind_listen_ipv4: ['any']

  bind_allow_query: ['any']

  bind_zone_master_server_ip: 192.0.2.10

  bind_zone_domains:
  - name: avalon.lan
    networks:
      - "192.0.2"
      - "172.16"
```

# extra info
Dit is niet de minimale opzet voor een slave server, de minimale opzet voor een server bestaat uit
- bind_zone_domains
- name
- bind_listen_ipv4
- bind_allow_query

**voorbeeld code**
```
    bind_listen_ipv4: ['any']
    bind_allow_query: ['any']
    bind_zone_master_server_ip: 192.168.111.222
    bind_zone_domains:
      - name: example.com
```

# Bronnen

https://www.youtube.com/watch?v=eSrC-7yeF7c
