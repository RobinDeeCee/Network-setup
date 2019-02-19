# Ansible

Ansible is een zeer krachtige tool dat automatisering en configuratie van programma's en systemen mogelijk maakt.  
Hierover moet je ook niet alles tot in detail weten, ansible heeft ansible galaxy.  
Dit is een platform waar mensen zogenaamde rollen op kunnen zetten, deze rollen kunnen worden herbruikt door andere gebruikers.  
Een rol bestaat uit 1 en vaak meerdere taken.
Deze taken kunnen alles omvatten, installeren van packages,configuratie van bestanden wijzigen enz.

 
# Vagrant

Vagrant is een software programma waarmee je snel en gemakkelijk systemen kunt opzetten.  
Dit werkt via het commando "Vagrant box" , deze "boxen" gebruiken we in dit geval voor virtuele machines.  
Hoe doe je dat ? 
 - installeer vagrant op je computer.
 - zoek een box uit die je wilt hercreëren op je systeem. De boxen vind je op https://app.vagrantup.com/boxes/search
 - voer het commando "vagrant init [met hier in de path naar de box in]" , in de juiste map dat je wilt, merk op dat er een Vagrantfile wordt aangemaakt.
  - doe vagrant up om de machine aan te maken.
 
 ## Voordelen
 - Je machine wordt maar 1 keer gedownload, deze wordt opgeslagen op het systeem en daarvan wordt een clone gemaakt die je uiteindelijk gaat gebruiken als virtual machine. Loopt er iets fout met de virtual machine? Geen probleem,  verwijder de machine en doe terug vagrant up.

 # Combinatie tussen Vagrant en Anisible
 Door Vagrant en Anisible te combineren kunnen we één of meerdere machine's volledig zelfstandig laten installeren en configureren. Dit wordt mogelijk gemaakt door de Vagrantfile. Wij maken gebruik van al gemaakte Vagrantfile's die worden geprovisioneerd door Anisible , deze vindt u hier: https://github.com/bertvv/ansible-skeleton.  

