# Samba en svtpt

De file server opzetten doen we met ansible net als hiervoor besproken.
We gebruiken hiervoor volgende rollen:

- bertvv.rh-base
- bertvv.samba
- bertvv.vsftpd

# Configuratie bestand
De configuratie van de Samba en svtpt server ziet er als het volgt uit:

```
rhbase_firewall_allow_services: [samba,ftp]  

samba_netbios_name: FILES

samba_workgroup: AVALON

samba_shares_root: /srv/shares

samba_load_homes: true

vsftpd_anonymous_enable: false

vsftpd_local_root: /srv/shares

vsftpd_local_enable: true

vsftpd_write_enable: true

samba_shares:
  - name: public
    comment: 'publieke map'
    public: 'yes'
    write_list: +employees
    group: employees
    browseable: 'yes' 	
    writable: 'yes'
    directory_mode: '0775'
    
  - name: management
    comment: 'management map'
    write_list: +management
    public : "no"
    valid_users: +management
    group: management
    directory_mode: '0770'

  - name: technical
    comment: 'technical map'
    write_list: +technical
    public : "no"
    valid_users: +management,+sales,+it,+technical
    group: technical
    directory_mode: '0775'

  - name: sales
    comment: 'sales map'
    write_list: +sales
    public : "no"
    valid_users: +sales,+management
    group: sales
    browseable: 'yes'
    writable: 'no'
    directory_mode: '0770'

  - name: it
    comment: 'it map'
    write_list: +it
    public : "no"
    valid_users: +it,+management
    group: it
    directory_mode: '0770'


rhbase_user_groups:
  - management
  - technical
  - sales
  - it
  - employees

rhbase_users:
- name: robin
  comment: 'administrator'
  password: '$1$FhbR0AF5$4rChbfx9RGTCq6Zwbtn3f/'
  groups: [ it,wheel,employees ]
  shell: /bin/bash

- name: stevenh
  comment: Steven Hermans
  password: '$1$sah1RYH2$kcBwZs4LHHT6cmBki52Rb/'
  groups: [ management,employees ]
 
- name: stevenv
  comment: Steven Van Daele
  password: '$1$PFnMWbyU$mojIml7YMg7vXxbhRGW0s/'
  groups: [ technical,employees ]
 
- name: leend
  comment: Leen De Meester
  password: '$1$34YZTccU$pTBk2Q4DjtJwORphr5KgO/'
  groups: [ technical,employees ]

- name: svena
  comment: Sven Aerens
  password: '$1$h/bVeCzk$5eFtVm9X/9IUMZmolACh.0'
  groups: [ sales,employees ]
 
- name: nehirb
  comment: Nehir Başar
  password: '$1$iPP6jZbP$MMd1Y4YWQ52xcL9oTfobg.'
  groups: [ it,employees ]
 
- name: alexanderd
  comment: Alexander De Coninck
  password: '$1$Hg68NX5Z$2MVCr4Z95FYUnwHS47Qpo/'
  groups: [ technical,employees ]
 
- name: krisv
  comment: Kris Vanhaverbeke
  password: '$1$FR51C8md$d0FwFs.VdbmpxgtsiSD.P1'
  groups: [ management,employees ]
 
- name: benoitp
  comment: Benoit Pluquet
  password: '$1$xKufUCO6$OF4qcPkcBRDMpkfwd7iwD/'
  groups: [ sales,employees ]
 
- name: anc
  comment: An Coppens
  password: '$1$LSVk.zZ/$8OXjINRJelFAWdWyMyWxU.'
  groups: [ technical,employees ]
 
- name: elenaa
  comment: Elena Andreev
  password: '$1$DnEEkALp$vh1NPHOuWpW7lKfc6/3Jk/'
  groups: [ management,employees ]
 
- name: evyt
  comment: Evy Tilleman
  password: '$1$PkBSMiq5$5SsNJvQPVyGrfqWKHjDeY/'
  groups: [ technical,employees ]
 
- name: christophev
  comment: Christophe Van der Meersche
  password: '$1$582kWCMA$7Jm.c4VH9SuniR/RdNW/7.'
  groups: [ it,employees ]
 
- name: stefaanv
  comment: Stefaan Vernimmen
  password: '$1$lK8K.cUo$9WsmxYpgjtPaKUYGeenED0'
  groups: [ technical,employees ]


samba_users:

- name: robin
  password: robin

- name: stevenh
  password: stevenh
 
- name: stevenv
  password: stevenv
 
- name: leend
  password: leend
 
- name: svena
  password: svena
 
- name: nehirb
  password: nehirb
 
- name: alexanderd
  password: alexanderd
 
- name: krisv
  password: krisv
 
- name: benoitp
  password: benoitp
 
- name: anc
  password: anc
 
- name: elenaa
  password: elenaa
 
- name: evyt
  password: evyt
 
- name: christophev
  password: christophev
 
- name: stefaanv
  password: stefaanv


vsftpd_extra_permissions:
  - folder: "/srv/shares/sales"
    entity: "management"
    etype: "group"
    permissions: "r-x"

  - folder: "/srv/shares/it"
    entity: "management"
    etype: "group"
    permissions: "r-x"
 
```

# De rol rh-base
In deze rol gaan we vooral de firewall aanspreken. De firewall zal de service http en https moeten toevoegen.
Dit doen we volgens volgend commando:
```
rhbase_firewall_allow_services: [samba,ftp]
```
Ook kunnen de nodige groepen aangemaakt worden met volgend commando:
```
rhbase_user_groups:
  - management
  - technical
  - sales
  - it
  - employees
```
Met deze rol maken we ook users aan. Dit kan als volgt gebeuren, dit doen we voor elke gebruiker.  
**name** Hier wordt de naam van de gebruiker ingesteld.  
**comment** Hier kan je wat extra informatie van de gebruiker instellen.  
**password** Hier wordt het wachtwoord ingesteld van de gebruiker, het is aan te raden deze wachtwoorden te hashen.  
**groups** Als de gebruikers is bepaalde groepen moet zitten, kan je dit hier steeds aangeven.  
**shell** Je kan ook aangeven welke shell de gebruiker moet gebruiken.  
```
rhbase_users:
- name: robin
  comment: 'administrator'
  password: '$1$FhbR0AF5$4rChbfx9RGTCq6Zwbtn3f/'
  groups: [ it,wheel,employees ]
  shell: /bin/bash
```

# De rol samba

De standaard configuratie stel je zo in:  
**netbios** Dit is voor naam oplossing te bieden tussen linux en windows, maar ook voor printers die geen DNS hebben.  
**workgroup** Dit is meestal de groep waar je inzit.  
**shares root** Dit is de root map waar alle shares inzitten.  
**load_homes** Dit zal homefolders van gebruikers laden.  
```
samba_netbios_name: FILES

samba_workgroup: AVALON

samba_shares_root: /srv/shares

samba_load_homes: true
```

Ook zullen we Samba shares moeten aanmaken, we bespreken alle onderdelen opnieuw.
```
samba_shares:
  - name: public
    comment: 'publieke map'
    public: 'yes'
    write_list: +employees
    group: employees
    browseable: 'yes' 	
    writable: 'yes'
    directory_mode: '0775'
```
**name** Hier komt de naam in van de samba share.  
**comment** Hier heb je de optie om wat regels toevoegen met uitleg overde map.   
**public** Hiermee geef je aan of deze map beschikbaar is voor iedereen of niet.  
**write_list** Hiermee voeg je groepen toe die kunnen schrijven.  
**group** Dit is de groep die verantwoordlijk is voor deze schare ( dit kunnen we niet op users zetten omdat dit niet veilig is, bij public group moet je steeds een apparte groep maken met alle users in ).  
**browseable** Hiermee wordt ingesteld of je zaken kunt zien op je systeem.  
**writable** Als schrijven is toegestaan kun je dat hier van toepassing maken.  
**directory_mode** Hiermee stel je in welke permissies je wilt installeren op je map.  

Van elke user moet er een samba user gemaakt worden want een gewone user kan niet standaard op de samba mappen, samba users maak je als volgt.
```
samba_users:

- name: robin
  password: robin
```
# De rol svtpd

Er moeten een paar standaard zaken worden ingesteld:

```
vsftpd_anonymous_enable: false

vsftpd_local_root: /srv/shares

vsftpd_local_enable: true

vsftpd_write_enable: true
```
**vsftpd_anonymous_enable** gaat ervoor zorgen dat anonymous gebruikers de gedeelde files kunnen zien.  
**local root** Laat de root map zien (waar alle files in zitten).    
**write enable** Laat toe om te kunnen schrijven in een map.   

Ook moeten we acl's maken om deze oplossing te laten werken
```
vsftpd_extra_permissions:
  - folder: "/srv/shares/sales"
    entity: "management"
    etype: "group"
    permissions: "r-x"
```

dit kan gemaakt worden op volgende manier:  
**folder** Hierin maak je het path van de map.  
**entity** Hierin wordt beschreven voor wat een ACL is gemaakt.  
**etype** Dit zal zeggen welke type de entity is (bijvoorbeeld group).  
**permissions** Hierin worden de permissions van de map gezet.  


## Thomas oplossing

Wegens een probleem in het pull resquest zal bovenstaande code niet werken.
Thomas heeft een oplossing gevonden voor dit probleem.
In deze oplossing maakt hij in zijn hosts.yml gebruik van taks.
Zijn takes bestaan uit:
 - zelf acl's maken
 - het hercreëren van mappen om premissies te overschrijven

Deze oplossing werkt bij versie v2.1.0 waarbij de pull request nog niet in de role zit.

In samenwerking met Thomas hebben wij (ik en Thomas) een oplossing gevonden voor dit probleem (hierboven beschreven).
Op de github staat de oplossing voor de acl's te maken (deze staat niet op de anisble galaxy), als je deze overschrijft met de huidige rol kan je gewoon de documentatie op anisble galaxy volgen, en maakt het de taks die de acl's maken en de mappen hercreëren vervangbaar.
