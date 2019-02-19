# Lamp opzetten

De Lamp opzetten doen we met ansible, zoals hiervoor besproken.
We gebruiken hiervoor volgende rollen:

- bertvv.rh-base
- bertvv.httpd
- bertvv.mariadb
- bertvv.wordpress

# Configuratie bestand
De configuratie van de LAMP server ( te vinden in de filr *pu004.yml*) ziet er als het volgt uit:

```
rhbase_firewall_allow_services: [http,https]

mariadb_databases:
  - name: wp_db

mariadb_users:
  - name: wp_user
    password: CorkIgWac
    priv: '*.*:ALL,GRANT'

mariadb_root_password: fogMeHud8    

wordpress_database: wp_db

wordpress_user: wp_user

wordpress_password: CorkIgWac

httpd_ssl_certificate_key_file: 'privateKey.key'

httpd_ssl_certificate_file: 'csrKey.crt'
```

# De rol rh-base
In deze rol gaan we vooral de firewall aanspreken. De firewall zal de service http en https moeten toevoegen.
Dit doen we volgens volgend commando. 
```
rhbase_firewall_allow_services: [http,https]
```

# De rol httpd
Deze rol zal eigenlijk niet veel meer doen dan apache omgeving opzetten. Met een al aangegeven IP-adress komt hier niet veel configuratie aan te pas, enkel nog bijkomstig niet de standaard ssl key gebruiken. Deze kan je heel makkelijk meegeven met volgend commando.
```
httpd_ssl_certificate_key_file: 'privateKey.key'

httpd_ssl_certificate_file: 'csrKey.crt'
```
Zo'n ssl key maak je door het commando:  
*openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout privateKey.key -out crsKey.crt*


# De rol mariadb
Zoals de naam van de rol al doet vermoeden voegen we hier een databank toe aan ons project. Hier komt toch wat configuratie bij kijken. Hier vindt je een uitleg voor wat, wat staat.
```
mariadb_databases:
  - name: wp_db

```
Hier stellen we de naam in van de databases.

```
mariadb_users:
  - name: wp_user
    password: CorkIgWac
    priv: '*.*:ALL,GRANT'

```
Hier stellen we de gebruiker in van de database, ook geven hem via da *priv* alle toegang.
```
mariadb_root_password: fogMeHud8    

```
Hier stellen we het root password in, zo geraak je als root gebruiker tot aan je database.
