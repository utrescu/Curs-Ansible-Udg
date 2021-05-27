# Dia1

## Instal·lar

Amb pip (per qualsevol plataforma)

```bash
pip install ansible --user
```

Pot ser que en alguns casos li falti alguna dependècia de Python (pywinrm, etc..)


### Linux Master

```bash
apt install ansible
```

I comprovar

```bash
ansible localhost -m ping
```

### Windows Master

Instal·lar:

```powershell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

- **"Windows Subsystem for Linux"**
- Instal·lar un Linux de la Microsoft Store
- `wsl --set-default-version 2`

Instal·lar Ansible:

```bash
sudo apt install ansible
sudo apt-get -y install python-pip python-dev libffi-dev libssl-dev
```

I comprovar:

```bash
ansible localhost -m ping
```

En el flamant Linux, si estem en un domini AD cal instal·lar kerberos:

```
sudo apt install krb5-user
```

I configurar-lo

```ini
[libdefaults]
default = SISTI.UDG.ES
nslookup_realm = false
dns_lookup_kdc = false

# The following krb5.conf variables are only for MIT Kerberos.
        kdc_timesync = 1
        ccache_type = 4
        forwardable = true
        proxiable = true

# The following libdefaults parameters are only for Heimdal Kerberos.
        fcc-mit-ticketflags = true

[realms]
SISTI.UDG.ES = {
   kdc =  dc.udg.edu
   # admin_server =  dc.udg.edu
   default_domain = udg.edu
}

[domain_realm]
.udg.edu = SISTI.UDG.ES
udg.edu = SISTI.UDG.ES
```

## Comprovar ping

```bash
ansible xinxan.local -i inventari -m ping
```

```bash
ansible all -i inventari -m ping
```

### Windows Hosts a administrar

S'ha d'activar `winrm` (Windows Remote Management). En les darreres versions està instal·lat per defecte però el servei no està activat.

#### Windows exemple

Faig inventari en Windows:

```ini
[wins]
spok ansible_host=23.12.24.235

[wins:vars]
ansible_user=u000000@SIS.TI.UDG.ES
ansible_password=LaContrasenya
ansible_connection=winrm
ansible_winrm_transport=kerberos
ansible_winrm_server_cert_validation=ignore
```

```bash
ansible spok -i inventari -k -m win_ping
```

## Comandes a localhost

```bash
ansible all -i "localhost," -m ping
```

## Inventari

Generar inventari manualment:

```ini
localhost
xinxan.local
```

Veure què hi ha:

```bash
ansible all -i hosts --list-hosts
```

### Inventari agrupat

```ini
[fedora]
locahost

[debians]
xinxan.local
```

### Inventari amb variables:

```ini
[fedora]
locahost

[debians]
xinxan.local ansible_user=pi
```

### Inventari amb variables exteses

```ini
[casa]
locahost

[debians]
xinxan.local ansible_user=pi

[all:vars]
ansible_user=xavier
```

### Inventaris dinàmics

Els inventaris dinàmics es poden formar:

- Scripts python
- Fent servir plugins

Per veure els plugins disponibles:

```bash
ansible-doc -t inventory -l
```

#### Virtualbox

Crea arxiu `llista.vbox.yml`

> plugin: virtualbox

i executa:

```bash
ansible-inventory -i list.vbox.yml --graph
```

opcions extres ...

## Mòduls de shell

### Shell POSIX

Comprovar que les màquines estan en marxa

```bash
ansible localhost -m ping
```

Quan de temps fa que estan en marxa

```bash
ansible xinxan.local -u pi -m command -a "uptime"
```

```bash
ansible localhost -m shell -a "echo hola $(hostname)"
```

### shell en Windows

```bash
ansible spok -i inventari -m win_shell -a "echo '$HOSTNAME'"
```

```bash
ansible spok -i inventari -m win_comand -a "ipconfig"
```

## Obtenir informació de la màquina: Setup

```bash
ansible xinxan.local -u pi -m setup
```

```bash
ansible xinxan.local -i hosts -u pi -m setup -a "filter=ansible_distribution*"
```

```bash
ansible xinxan.local -i hosts -u pi -m setup -a "gather_subset=min"
```

### setup windows

```bash
ansible spok -i inventari -m setup
```

No haver de definir l'inventari cada cop?

```ini
[defaults]
inventory = ./inventari
```

## Copiar arxius?

```bash
ansible xinxan.local -i hosts -u pi -m copy -a "src='./hosts' dest='/home/pi/hosts'"
```

```bash
touch readme.txt
ansible spok -i inventari -k -m win_copy -a 'src=readme.txt dest=C:\\readme.txt'
```

Paràmetre `force:yes`

## Gestió de programes

Instal·lar un programa: (**yum**, **apt**, etc... ) become (**-b**), ask password **-k**, sudo password **-K**)

```bash
ansible xinxan.local -u pi -b -m apt "name=joe state=present"
```

Es pot repetir la comanda i comprovar que no el torna a provar d'instal·lar "changed:false"

Treure el programa:

```bash
ansible xinxan.local -b -m apt "name=joe state=absent"
```

### Instal.lar software en Windows

```bash
ansible spok.udg.edu -i inventari -k -m win_chocolatey -a "name=7zip.install state=present"
```

## Serveis

```bash
ansible xinxan.local -b -K -m service -a "name=nginx state=started enabled=yes"
```
