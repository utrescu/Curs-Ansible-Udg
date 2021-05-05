# Dia1

## Configurar SSH

ssh-genkey

ssh-copy-id

## Comandes a localhost

ansible all -i "localhost," -m ping

## Inventari

Generar inventari

## commandes: adhoc interessants

### Mòduls

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

### setup

```bash
ansible xinxan.local -u pi -m setup
```

```bash
ansible xinxan.local -i hosts -u pi -m setup -a "filter=ansible_distribution*"
```

```bash
ansible xinxan.local -i hosts -u pi -m setup -a "gather_subset=min"
```

### Copiar arxius?

```bash
ansible xinxan.local -i hosts -u pi -m copy -a "src='./hosts' dest='/home/pi/hosts'"
```

### Gestió de programes

Instal·lar un programa: (yum i apt?? ) become (-b), ask password -k sudo password -K)

```bash
ansible xinxan.local -u pi -b -m apt "name=joe state=present"
```

Comprovar que no el torna a provar d'instal·lar "changed:false"

Treure'l:

```bash
ansible xinxan.local -b -m apt "name=joe state=present"
```

### Gestió de Serveis

```bash
ansible xinxan.local -b -K -m service -a "name=nginx state=started enabled=yes"
```

## Inventaris

```bash
ansible all -i hosts --list-hosts
```

### Inventaris dinàmics

Els inventaris dinàmics es formen a partir de scripts o fent servir algun dels
plugins que existeixen:

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

#### executar comandes a virtualbox

Bàsicament és el mateix però fent servir el plugin
