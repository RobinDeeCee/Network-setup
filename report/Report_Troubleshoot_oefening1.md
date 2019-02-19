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
Hierna leggen we meteen een ssh verbinding met met de virtuele machine			**OK**  



### Phase 1: Network access  
- check cables										NOK  
  - cable hostonly zit niet in  
    - cable insteken 									**OK**  
- check of de interface's up zijn (ip link)					**OK**  

### Phase 2: Internet Layer  
- check ip adressen (ip a)								NOK  
  -  check in /etc/sysconfig/network-scripts/ifcfg-*) voor een ip  
     - schrijf fout in configuratie (in adress)						**OK**  
-ping naar 192.168.56.42								**OK**  
-ping host naar 192.168.56.42							**OK**  
-ping naar 10.0.2.15									**OK**  
-check default gateway (ip r)							**OK**  

### Phase 3: Transport Layer  
- check services									NOK  
  - enable/start ngix									NOK  
      - check journalctl -xe  
	- fout kan bestand niet vinden (typfout)  
	- veranderen de fout in ssl_certificate						**OK**  
- check of dat de juiste poorten luisteren						NOK  
  - poort 80 (http)									**OK**  
  - poort 443 (https)								**OK**  
  - poort 8443 (mag niet luisteren wordt bezien als de https poort)			NOK    
  - veranderen 8443 naar 443 (in /etc/nginx/nginx.conf)					**OK**  
  - herstarten van service								**OK**  
- bekijk of de juiste services zijn toegevoegd (firewall-cmd --list-all)		NOK  
  - voeg https toe zowel nu als permanent					**OK**  
  - reload firewall									**OK**  

### Phase 4: Application Layer  
- check de output van curl							**OK**  

### Phase 5: SELinux  
- check of mode op Enforcing staat (getenforce)						**OK**  
- bekijk of ls -Z /usr/share/nginx/html/index.html httpd_sys_content is			**OK**  
- bekijk of ls -Z /usr/share/nginx/html/index.php httpd_sys_content is			**OK**  

## End result

- Alle test geslaagt

## Resources

List all sources of useful information that you encountered while completing this assignment: books, manuals, HOWTO's, blog posts, etc.
