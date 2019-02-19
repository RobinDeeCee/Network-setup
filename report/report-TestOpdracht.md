# Physical
- cables OK
# Network access
- interfaces zijn up OK
# Internet Layer
- ip adress voor eth1 niet toegewezen NOK
  - check /etc/sysconfig/network-scripts/ifcfg-eth1 OK
  - service network restart OK
    - Ip voor eth OK
- DG ingesteld OK
- ping naar DG OK
- ping van host naar web OK
# Transport Layer
- uit systemctl list-unit-files | grep besluit ik dat htppd niet aanstaat NOK
  - starten en enable van httpd OK
    - httpd status OK
- sudo ss -tulpn/tlnp zegt dat poort 8080 luisterd en niet 80 OK
  - /etc/httpd/conf/httpd.conf port aanpassen naar 80 OK
  - service herstarten OK
    - httpd poort veranderen OK
-	Uit firewall-cmd --list-all leer ik dat er geen http/https is toegepast NOK
  - http en https aan firewall toevoegen en permanent insteken OK
    - http/https in firewall OK
# Transport Layer
- curl naar 192.168.56.72 OK
- test op hostsystseem OK
- test op 192.168.56.72/test.php NOK
# SELinux
- cgetenforce is Enforcing OK
- ls -Z /var/www/html/test.php staat niet juist NOK
  - verander naar content httpd_sys_content_t OK
  - db gebruiken NOK
    - httpd_can_network_connect_db op on zetten OK
      - connectie met de DB OK
