# Cheat sheets and checklists

- Student name: Robin De Cock
- Github repo: https://github.com/HoGentTIN/elnx-1819-sme-robinHogent/edit/master

## files

| commando               |  wat doet het / voor wat is het | check |
| :---                | :---    |:---       |
|systemctl status named| kijken naar de services waar zit het fout ||
|sudo journalctl -f -u named.service | check errors||
|named-checkconf /etc/named.conf | controle op conf in main file||
|named-checkzone example.com /var/named/example.conf |controle op conf in zone files||


## files

| file               |  inhoud | check |
| :---                | :---    |:---       |
|/etc/hosts|||
|/etc/named.conf|||
|/var/named/domein.lan|||
|/var/named/192.16.in-addr.arpa|||
|/etc/resolv.conf| hierin komt de dns||
||||
||||
||||
||||



## /etc/hosts

Voorbeeld:
```
# IP-address   hostname    aliases
127.0.0.1      localhost   localhost.localdomain
::1            localhost6  localhost6.localdomain6

172.22.255.254 router4038  gw gw.netlab.hogent.be
172.22.0.2     server4038  server4038.netlab.hogent.be
172.22.0.3     printer4038 printer4038.netlab.hogent.be
```

## /etc/named.conf

Voorbeeld:
```
options {
  listen-on port 53 { any; };
  listen-on-v6 port 53 { any; };
  directory   "/var/named";

  // ...

  allow-query     { any; };
  allow-transfer  { any; };

  recursion no;

  rrset-order { order random; };

  // ...
};
```

- listen-on: port number + network interfaces
   - any;
   - 127.0.0.0/8; 192.168.56.0/24
- allow-query: welke hosts mogen queryen
- allow-transfer: van welke root mag de slave de info overnemen
 - recursion: no bij authoritative name server
 
 het maken van een Forward lookup zone : 
 ```
 zone "example.com" IN {
  type master;
  file "example.com";
  notify yes;
  allow-update { none; };
};
```

en de slave

```
zone "example.com" IN {
  type slave;
  masters { 192.168.56.10; };
  file "slaves/example.com";
};
```

Reverse lookup zone (ip steeds omgekeerd)
```
zone "56.168.192.in-addr.arpa" IN {
  type master;
  file "56.168.192.in-addr.arpa";
  notify yes;
  allow-update { none; };
};
```

stappen plan tot Reverse lookup zone
1. Take the “dotted quad”, e.g. 192.168.56.0/24
2. Drop the host part: 192.168.56
3. Reverse the quads: 56.168.192
4. Add in-addr.arpa.:
   -56.168.192.in-addr.arpa.


## /var/named/domein.lan

```
$ORIGIN example.com
$TTL 1W

@ IN SOA ns1.example.com. hostmaster.example.com. (
  18042020 1D 1H 1W 1D )

                     IN  NS     ns1
                     IN  NS     ns1

ns1                  IN  A      192.168.56.10
ns2                  IN  A      192.168.56.11
dc                   IN  A      192.168.56.40
web                  IN  A      192.168.56.172
www                  IN  CNAME  web
db                   IN  A      192.168.56.173

priv0001             IN  A      172.16.0.10
priv0002             IN  A      172.16.0.11
```

Resource records

```
web  IN  A      192.168.56.172
www  IN  CNAME  web
```

- A: name to IP
- AAAA: name to IPv6
- PTR: IP to name
- CNAME: alias
- SOA: start of authority, info over het domain
- NS: authoritative name server(s)
- MX: mail server
- SRV: service
- TXT: text record

```
@ IN SOA ns1.example.com. hostmaster.example.com. (
  18042020 1D 1H 1W 1D )
  ```
- ns1.example.com.: primary name server
- hostmaster.example.com.: email adress
- 18042020: serial
- 1D: zal de 2de ns proberen de zone te refreshen
- 1H: tussen updates
- 1W: wanneer de zone niet meer authoritative is (slave alleen)
- 1D: hoelang een NAME ERROR result zal onthouden worden

/var/named/192.16.in-addr.arpa
  ```
$TTL 1W
$ORIGIN 16.172.in-addr.arpa.

@ IN SOA ns1.example.com. hostmaster.example.com. (
  18042020
  1D 1H 1W 1D )

                 IN  NS   ns1.example.com.
                 IN  NS   ns2.example.com.

10.0             IN  PTR  priv0001.example.com.
11.0             IN  PTR  priv0002.example.com.
  ```
