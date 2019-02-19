# Cheat sheets and checklists

- Student name: Robin De Cock
- Github repo: https://github.com/HoGentTIN/elnx-1819-sme-robinHogent/edit/master

## Basic commands

| Task                | Command ( */* met opties en *(extra uitleg)*) | Bottom-up |
| :---                | :---    |:---       |
| Check cables | --  | Network access |
| Check ip vim-adressen | ip link  | Network access |
|  -------------------               |  -------------------  |      ------------------- |
| Check ip adressen | ip a  | Internet Layer |
| Check Default gateway | ip r  | Internet Layer |
| Check DNS service | vi /etc/resolv.conf  | Internet Layer |
| Juist ip-adress, subnet, DHCP/FIXED | vi /etc/sysconfig/network-scripts/ifcfg-* | Internet Layer |
| Controle op DHCP en IP |sudo journalctl -f  | Internet Layer |
| Check Defaulft Gateway,subnet,network configuration | ip route  | Internet Layer |
| ping tussen pc's | ping ip-aderss  | Internet Layer |
| Ping default GW/DNS| ping ip-aderss  | Internet Layer |
| Query DNS | dig, nslookup, getent | Internet Layer |
|        -------------------     -------------------    |  -------------------   |  -------------------     |
| bekijk de servicesop het systeem | sudo systemctl list-unit-files | Transport Layer |
| Draaien de services's ? | sudo systemctl status/enable/start [httpd] | Transport Layer |
| Juiste poorten/interface's | sudo ss -tulpn/tlnp(tcp)/ulnp(udp) | Transport Layer |
| Juiste poort nummer |vi /etc/services | Transport Layer |
| Firewall overzicht/instellingen |sudo firewall-cmd --list-all | Transport Layer |
|       -------------------          |   -------------------  |   -------------------  -------------------  |
| Browers |curl | Application Layer |
| Check the log files |journalctl: journalctl -f -u httpd.service / tail -f /var/log/httpd/error_log | Application Layer |
| READ THE FUCKING MANUAL!!|https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/| Application Layer |
| -------------------| -------------------| -------------------|
| file naar default value | sudo restorecon -R /var/www//| SELinux |
| verwijder permissive domain melding | ssudo semanage permissive -d httpd_t| SELinux |

## Bottom-up

| Layer               | Protocols | Keywords |
| :---                | :---    |:---       |
| Application | HTTP, DNS, SMB, FTP, … | |
| Transport | TCP, UDP | sockets, port numbers |
| Internet | IP, ICMP | routing, IP address |
| Network access | Ethernet | switch, MAC address |
| Physical || cables |

## /etc/sysconfig/network-scripts/ifcfg-*

### DHCP
```
TYPE=Ethernet  
BOOTPROTO=dhcp  
NAME=enp0s3  
DEVICE=enp0s3  
ONBOOT=yes  
```

#### Common causes
**DHCP unreachable** = No IP  
**DHCP won’t give an IP**= No IP  
**169.254.x.x** = No DHCP offer, “link-local” address (pipa adress)  
**Unexpected subnet** = Bad config (fixed IP set?)  


### FIXED
```
BOOTPROTO=none  
ONBOOT=yes  
IPADDR=192.168.56.73  
NETMASK=255.255.255.0  
DEVICE=enp0s8  
```

Steeds **service network restart**

## DIG, Nslookup, Getent

- dig icanhazip.com
- nslookup icanhazip.com
- getent ahosts icanhazip.com

## Firewall

**--add-service** voeg service toe ( doe dit niet samen met --add-port )  
**--add-port** voeg een poort toe ( doe dit niet samen met --add-service )  
**--permanent** stel ze in voor altijd  
**--reload** herstart firewall roles  
```
$ sudo firewall-cmd --add-service=http --permanent
$ sudo firewall-cmd --add-service=https --permanent
$ sudo firewall-cmd --reload
```

**Sudo firewall-cmd --add-interface=eth1** interface toevoegen

## SELinux

**getenforce** laat zien welke mode je inzit  
**sestatus** geeft een overzicht  
**vi /etc/selinux/config** om wijzigen aan te brengen  
**semanage boolean -l | less** alles kijken  
**getsebool service** te kijken welke service die heeft  
**setsebool service on/off** service aan of af zetten  
**ls -Z /var/www/html/test.php** check de content  
**sudo chcon -t httpd_sys_content_t /var/www/html/test.php** verander content  


## Know your environment (Nginx)
**READ IT**  
https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-in-ubuntu-16-04





# Samengevat
Network Access layer
- Kabels etc
Internet layer
- ping en ip addressen
- Routing in the lan
Transport layer
- Services
- Ports
- Firewall
Application Layer
- Logs
- Config files



# BRONNEN 
https://hogenttin.github.io/elnx-syllabus/troubleshooting/#/thats-it
