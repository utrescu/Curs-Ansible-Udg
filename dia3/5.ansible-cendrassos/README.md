# Configuració de l'Institut Cendrassos

Aquesta Configuració d'Ansible el que fa és configurar dos tipus d'ordinadors de la xarxa del Departament d'Informàtica de l'Institut Cendrassos:

- **alumnes**: Ordinador base dels alumnes
- **servidors**: Servidor LDAP que autentifica els usuaris.

Es parteix d'una màquina amb Ubuntu instal·lat (s'ha provat amb Xubuntu Xenial) que tingui un usuari anomenat _usuari_ (que pugui fer su o sudo) i amb el servidor de SSH instal·lat.

    # apt-get install openssh-server

> La idea és crear un CD d'instal·lació automàtic que ja faci la creació inicial amb tot el que cal:
>
> - Instal·la el sistema bàsic
> - Es crea un usuari (per defecte assumim que és 'usuari')
> - I s'instal·la el servidor SSH

## Directoris

### Variables globals

#### fitxer 'all'

El fitxer **all** del directori _group_vars_ serveix per definir variables globals que s'apliquen a tots els playbooks. En aquest arxiu s'hi defineix l'usuari que pot fer sudo, la versió d'Ubuntu i com es fa per connectar amb els equips:

L'usuari es pot canviar amb la variable **ansible_ssh_user** que està definida a _group_vars/all_.

Per exemple podem canviar l'usuari per _marcelinu_ canviant la línia per:

    ansible_ssh_user: marcelinu

La distribució es defineix amb el nom de versió, i no el numero:

    ubuntu_versio: xenial

#### fitxer 'servidors'

El fitxer servidors serveix per definir la configuració bàsica del servidor OpenLDAP:

    openldap_server_domain_name: cendrinf.ies
    openldap_server_rootpw: qcmmer2saia
    openldap_server_enable_ssl: false

Amb aquesta configuració no fa servir SSL.

### inventari

S'ha de generar una configuració d'inventari per poder definir on s'ha de posar.

> TODO: Donat que en el nostre centre des de que es va instal·lar el tallafocs ja no tenim control sobre els noms de les màquines (s'hauria de mirar pfsense per veure si es pot recuperar) s'haurà de generar un script que generi l'inventari cada cop.
>
> Per solucionar el problema de que no control·lem els noms de les màquines s'ha desenvolupat l'script `generar-llista-ip.sh`
>
> S'executa amb el número de classe i genera un fitxer hosts.list (evidentment les màquines han d'estar en marxa)
>
> ./generar-llista-ip.sh 9
> ./generar-llista-ip.sh 10
> ./generar-llista-ip.sh 16

#### Opció 1

Per defecte està a _/etc/ansible/hosts_ però es pot definir al directori arrel de la configuració.

Les configuracions d'inventari tenen forma d'arxiu .ini:

    [alumnes]
    192.168.9.23
    a309.cendrinf.ies

    [servidors]
    192.168.4.11
    192.168.4.1

#### Opció 2

Es pot definir la configuració d'inventari directament en la carpeta de treball. Hi ha un arxiu **vbox** d'exemple (s'hi poden llistar tots els equips que calgui):

    [alumnes]
    192.168.88.107

    [servidors]
    192.168.88.102

En cas de fer servir una configuració _no estàndard_ s'ha d'especificar en la comanda amb **-i**

    ansible-playbook -K -i vbox site.yml

## Aplicar la configuració

Es pot aplicar la configuració a totes les màquines entrant cada vegada l’usuari i la contrasenya ( --ask-pass o -k ) però com que també la demana per convertir-se en sudo el millor seria copiar la clau pública SSH a les màquines abans de començar:

    ssh-copy-id -i /home/xavier/.ssh/id_rsa.pub usuari@192.168.88.107

Una opció alternativa a enviar les claus és fer que l'script demani la contrasenya de l'usuari en el moment d'executar l'script. Això es fa definint la opció _-k_ en executar l'script

    ansible-playbook -k -K site.yml

Demanarà dues contrasenyes (-k per fer login i -K per convertir-se en sudo).

> Si les dues contrasenyes són la mateixa es pot deixar la segona en blanc.

Els scripts estan pensats per aplicar-se automàticament a totes les màquines o sigui que executant-lo s’executarà a totes les màquines de l’inventari (el **-K** o **--ask-become-pass** és perquè demani la contrasenya de sudo o su):

    ansible-playbook -K site.yml --limit alumnes

O bé cridant el fitxer directament:

    ansible-playbook -K alumnes.yml

Després per aplicar tota la configuració a una màquina concreta, per exemple 192.168.9.12, si la tenim definida a /etc/ansible/hosts executant el playbook amb **--limit**:

    ansible-playbook -K --limit=192.168.9.12 alumnes.yml

Si no es troba en el fitxer d’inventari es pot especificar la seva IP amb la comanda **-i** (per defecte vol un fitxer però es pot simular acabant-lo amb coma):

    ansible-playbook -K -i "192.168.9.12," alumnes.yml

També es pot aplicar alguna configuració concreta amb l'etiqueta de cada role (**--tags**):

    ansible-playbook --tags "virtualbox,docker" alumnes.yml

I es pot fer el contrari amb **--skip-tags**:

    ansible-playbook --skip-tags "virtualbox,docker"

Els he separat segons la meva conveniència però suposo que es podrien separar més o d'una altra forma

### Resum

Per instal·lar les màquines dels alumnes s'ha d'executar:

    ansible-playbook -K alumnes.yml

i esperar ...

## Playbooks

Per facilitar les diferents tasques del manteniment del sistema s'han desenvolupat diferents playbooks:

| Playbook                          | Funció                                                             |
| --------------------------------- | ------------------------------------------------------------------ |
| **installa_servidors.yml**        | Instal·lació d'un servidor LDAP                                    |
| **installa_alumnes.yml**          | Instal·lació base d'un Xubuntu pels alumnes                        |
| **actualitza.yml**                | Actualització de les màquines dels alumnes                         |
| **usuari_canvia-contrasenya.yml** | Canvia la contrasenya de l'usuari SUDO de les màquines             |
| **canvia_grub_password.yml**      | Canvia/defineix la contrasenya de SUDO                             |
| **canvia_de_curs.yml**            | Esborra les carpetes /home i actualitza programari                 |
| **canvia_hostname.yml**           | Canvia el nom del host en funció del que digui l'inventari         |
| **obtenir-mac.yml**               | Playbook que llista els nom, MAC i IP dels ordinadors del playbook |
