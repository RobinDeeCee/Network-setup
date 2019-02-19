# Componenten

#Vargant file

Bertvv heeft in zijn project "ansible-skeleton" al een mooie basis gegenereerd van virtuele boxen met vagrant en het provisioneren ervan met anisible. Net als in elk vagrant project is het van belang wat er in de vagrant file staat. We leggen hiervan de belangrijkste zaken uit.

```
DEFAULT_BASE_BOX = 'bento/centos-7.5'
```

Ergens in het begin van de vargant file zie je deze lijn, deze lijn is van belang om te weten welke box je wil aanmaken.

```
vagranthosts = ENV['VAGRANTS_HOST'] ? ENV['VAGRANTS_HOST'] : 'vagrant-hosts.yml'
hosts = YAML.load_file(File.join(__dir__, vagranthosts))
```

Hierna vindt je dit blokje tekst, dit maakt het mogelijk om aparte yml file's toe te voegen. Deze zijn zeer nuttig bij het uitvoeren van provision met ansible.

```
  config.vm.provision ansible_mode do |ansible|
    ansible.playbook = host.key?('playbook') ?
        "ansible/#{host['playbook']}" :
        "ansible/site.yml"
    ansible.become = true
  end
end
```

Dit zorgt ervoor dat je kan provisioneren met ansible, dit stuk is voor mac/linux gebuikers, dit is een fallback voor windows gebruikers maar hier gaan we niet verder op in. De provisionering gaat via een playbook.

```
def network_options(host)
  options = {}

  if host.key?('ip')
    options[:ip] = host['ip']
    options[:netmask] = host['netmask'] ||= '255.255.255.0'
  else
    options[:type] = 'dhcp'
  end

  options[:mac] = host['mac'].gsub(/[-:]/, '') if host.key?('mac')
  options[:auto_config] = host['auto_config'] if host.key?('auto_config')
  options[:virtualbox__intnet] = true if host.key?('intnet') && host['intnet']
  options
end

def custom_synced_folders(vm, host)
  return unless host.key?('synced_folders')
  folders = host['synced_folders']

  folders.each do |folder|
    vm.synced_folder folder['src'], folder['dest'], folder['options']
  end
end
```
Dit stukje dient vooral voor de netwerking aan te passen binnen de virtual boxen, je kan zelf je ip adress ingeven, verschillende adapter's ingeven enz.
```
def forwarded_ports(vm, host)
  if host.has_key?('forwarded_ports')
    ports = host['forwarded_ports']

    ports.each do |port|
      vm.network "forwarded_port", guest: port['guest'], host: port['host']
    end
  end
end
```
Bertvv heeft het ook mogelijk gemaakt om port-forwarders in de code te zetten. dit doe je via de bovenstaande code.

## mappen structuur


    ├── vagrant-hosts.yml       # Dit zorgt ervoor dat de hosts worden aangemaakt, dit is vooral voor de naam, ip adress en andere confugratie.
    ├── ansible                 # Hierin zitten alle ansible files, en de configuratie.
      ├── group_vars            # Hierin zit een YML file die voor de algemene configuratie van de viruele boxen zorgt.
      ├── host_vars             # Hierin zitten YML file's die voor de aparte configuratie van deze verschillende boxen zorgen.
      ├── roles                 # Hierin zitten de verschillende rollen die je gebruikt in je project, deze installeer je in deze map via het commando > ansible-galaxy install -p /roles
      ├── site.yml              # Hierin zitten je al je virtuele machines.         
    ├── scripts
      ├── role-deps.sh          # Dit zorgt ervoor dat alle rollen die je hebt geinstalleerd worden geinstalleerd indien je het zou proberen op een ander systeem.
      
      
### vagrant-hosts.yml 
Deze file zorgt ervoor dat de configuartie en het maken van deze virtual boxen goed verloopt. Een voorbeeld hiervan is:
```
- name: pu004
  ip: 192.0.2.50
```
Je stelt de naam en ipadress in. 

### site.yml 

Deze file zorgt ervoor dat er 1 of meerdere virtuele hosts worden gemaakt, je kan hier ook de naam en de role('s) instellen.
Hierbij een voorbeeld:
```
- hosts: pu001
  become: true
  roles: [bertvv.rh-base,bertvv.bind]
```

De naam van de virtual host is "pu001", hij wordt gemaakt door de "become: true" en de roles staan in een array (dus die zet je tussen [] ) of je scheidt ze door ze op te sommen via de "-"

# Basis commando's
```
ansible-galaxy install -p /roles
```

Rol installeren in een specifieke map.

```
sudo ./script/test/runbats.sh
```

Dit controleert of alle zaken goed zijn opgezet door ansible (enkel mogelijk in vm).
```
./role-deps.sh
```
Installeerd alle rollen die gebruikt worden.
