# Enterprise Linux Lab Report - Troubleshooting

- Student name: Robin De Cock
- Class/group: TIN-TI-3B (Gent)

## Instructions

- Write a detailed report in the "Report" section below (in Dutch or English)
- Use correct Markdown! Use fenced code blocks for commands and their output, terminal transcripts, ...
- The different phases in the bottom-up troubleshooting process are described in their own subsections (heading of level 3, i.e. starting with `###`) with the name of the phase as title.
- Every step is described in detail:
    - describe what is being tested
    - give the command, including options and arguments, needed to execute the test, or the absolute path to the configuration file to be verified
    - give the expected output of the command or content of the configuration file (only the relevant parts are sufficient!)
    - if the actual output is different from the one expected, explain the cause and describe how you fixed this by giving the exact commands or necessary changes to configuration files
- In the section "End result", describe the final state of the service:
    - copy/paste a transcript of running the acceptance tests
    - describe the result of accessing the service from the host system
    - describe any error messages that still remain

## Report
qwert aanpassen aan azerty 							**OK**  
```
sudo localectl set-keymap be
```


### Phase 1: Network access  
- check cables										NOK  
  - cable hostonly is niet juist  
    - oplossen van hostonly								**OK**  
- check of de interface's up zijn (ip link)						**NOK**  
  - hostonly staat down									**NOK**
    - aanpassen in /etc/sysconfig/network-scripts/ifcfg-enp0s8 onboot zetten op yes	**OK**

### Phase 2: Internet Layer  
- check ip adressen (ip a)								OK 
-check default gateway (ip r)								**OK**  
-kijken of de dns inorde is ( in /etc/resolv.conf )					**NOK**
 - eigen ip adress toevoegen								**OK**
-ping naar 192.168.56.42								**OK**  
-ping host naar 172.22.10.155								**OK**  
-ping naar 10.0.2.15									**OK**  

### Phase 3: Transport Layer  
- enable/start named ( dns )								NOK  
   - check journalctl -xe  
#### fout in /etc/named.conf (dit word normaal in de Application layer gedaan, maar ik voor de duidelijkheid doe ik het hier) 							
- //listen-on port 53 { 127.0.0.1; } moet worden listen-on port 53 { any; };
- het aan passen van de zone 56.168.192.in-addr.arpa"
  - 'file "192.168.56.in-addr.arpa"' naar 'file "56.168.192.in-addr.arpa"'
     - normaal klopt dit wel , maar de configurtie staat gewoon op een andere plaats
- testen of de conf inorde staat (named-checkconf /etc/named.conf)			**OK**
  - enable/start named ( dns )								NOK  
      - check journalctl -xe
#### fout in /var/named/cynalco.com (dit word normaal in de Application layer gedaan, maar ik voor de duidelijkheid doe ik het hier) 
- butterfree           IN  A      192.168.56.13
  - moet butterfree           IN  A      192.168.56.12 zijn
- beedle               IN  A      192.168.56.12
  - moet beedle           IN  A      192.168.56.13 zijn
- De 2de dns moet er ook in
  - IN  NS     tamatama.cynalco.com.
- files                IN  CNAME  mankey moet toegevoegd worden
- kijken of het goed is (named-checkzone example.com /var/named/example.conf) 		**OK**

#### fout in /var/named/192.168.56.in-addr.arpa (dit word normaal in de Application layer gedaan, maar ik voor de duidelijkheid doe ik het hier) 
- 13       IN  PTR  butterfree.cynalco.com.
  - moet 12       IN  PTR  beedle.cynalco.com. zijn
- 12       IN  PTR  beedle.cynalco.com.
  - moet 13       IN  PTR  beedle.cynalco.com. zijn
  
- enable/start named ( dns )								**OK**
- check services vooral poort 53 ( sudo ss -tulpn )					**OK**
- contole op firewall (firewall-cmd --list-all)						**NOK**
  - voeg ofwel de service toe of zet de port 53 udp open


### Phase 4: Application Layer  
- dns fx										**OK**  

### Phase 5: SELinux  
- check of mode op Enforcing staat (getenforce)						**OK**  

## End result

- Alle test geslaagt									**OK**
- Kan nslookup van host naar het domein lukt						**OK**

## Resources

http://www.zytrax.com/books/dns/ch4/  
https://stackoverflow.com/questions/20840012/ssh-remote-host-identification-has-changed


