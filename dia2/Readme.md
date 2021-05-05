# Dia 2

## YAML?

Funcionamemt bàsic

```yaml
nom: "valor"
numero: 2
senseres: null

llista:
  - "un"
  - "dos"

llista2: ["un", "dos"]

pi_family:
  - nom: "Pere"
    cognom: "Pi"
  - nom: "Pau"
    cognom: "Pi"
  - { nom: "Maria", cognom: "Pi" }

descripcio: >
  aaaaaaaaaaaaa
  aaaaaaaaaaaaa
  aaaaaaaaaaaaa
```

## Obtenir variables

### setup

```bash
ansible xinxan.local -i inventari -m setup
```

Es pot executar amb filtres

```bash
ansible xinxan.local -i inventari -m setup -a "filter=ansible_distribution*"
```

### Extra variables

```bash
ansible xinxan.local -i inventari -e Hola="Pere" -m shell -a "echo {{Hola}}"
```

## Primer playbook

### Ping playbook

```yaml
---
- hosts: xinxan.local
  user: pi

  tasks:
    - name: Comprovar que està viu
      ping:
```

fer servir debug per veure com es sobreescriuren les variables. Si executem això:

```yaml
---
- hosts: xinxan.local
  user: pi

  tasks:
    - name: Llista hosts
      debug:
        msg: "{{ansible_nodename}}"
```

Amb

```bash
ansible-playbook -i inventari debugnodename.yml
```

Imprimeix el node que treu de les variables Ansible, però si li passem la variable per línia de
comandes el resultat és diferent

```bash
ansible-playbook -i inventari -e ansible_nodename="patata" debugnodename.yml
```

## Instal·lar joe playbook

## Instal·lar NGinx playbook
