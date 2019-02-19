# Componenten
### Vagrantfile
Dit is het hart van vagrant, zonder dit kun je geen vagrant boxen op je systeem zetten. 
# Basis commando's
```
vagrant init
```
 Als je dit commando uitvoert in een map wordt er zo'n vagrant file gemaakt, naast een heleboel commentaar vindt je dit terug.

 ```
Vagrant.configure("2") do |config|
 config.vm.box = "base"
end
```

Dit is de meest standaard vagrant file die je kunt hebben, het belangrijkste is de lijn config.vm.box = "base" daar zal uiteindelijk het path van de vargantbox moeten komen. Je kan ook een box zoeken op: https://app.vagrantup.com/boxes/search en daar de vagrant file copiëren en plakken in je zelfgemaakte vagrant file.

 ``` 
vagrant init path/machine
 ```
 

Hiermee maak je geen standaard vagrant file, maar een vagrant file die er op is voorbereid om de machine "path/machine" op je systeem te zetten.  
Een concreet voorbeeld: we willen deze box gaan gebruiken https://app.vagrantup.com/centos/boxes/7
in de terminal : 

```console
vagrant init centos/7
 ```
De vagant file ziet er als het volgt uit:


 ```
Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
end
```
```
vagrant up
 ```
 
Hiermee ga je echt je box van het internet halen en installeren op het hostsysteem.

 ```
 vagrant ssh [target systeem]
```
 
Eenmaal als de vagrant up is gelukt, kun je er naar ssh'en, dit maakt de communicatie altijd makkelijker, we raden ook steeds aan om het target systeem erbij te zetten , zodat vagrant weet naar welk systeem hij moet ssh'en.  
###### opmerking
 als je een gui wil gebruiken zal dit niet werken via ssh , er is wel een work-around (https://stackoverflow.com/questions/18878117/using-vagrant-to-run-virtual-machines-with-desktop-environment)
