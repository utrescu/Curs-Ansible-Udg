# Dia 3

## 1 Roles

### 1.1 Crear el role bàsic

```bash
mkdir roles
cd roles
ansible-galaxy init viu
ansible-galaxy init editor
```

Posem cada cosa al seu lloc i després només cal definir el playbook:

```yaml
---
- hosts: xinxan.local
  user: pi
  become: true

  roles:
    - viu
    - editor
```

### 1.2 usar role

Fem servir un role de Ansible Galaxy. Per exemple instal·lar git:

```bash
mkdir roles
ansible-galaxy install geerlingguy.git -p roles/
```

Fer playbook:

```yaml
---
- hosts: xinxan.local
  become: yes

  roles:
    - geerlingguy.git
```

### Crear role de nginx

```bash

```

## 2 Ansible Vault

### xifrar i desxifrar

El contingut secret és:

```yaml
secret_token: XXXXoXXXX
```

```bash
ansible-vault encrypt fitxer.yml
```

Puc carregar les variables al playbook:

```yaml
---
- host: xinxan.local
  become: yes

  tasks:
  - name: read secret vars
    include_vars: "fitxer.yml"

  - name: Usar-les
    debug:
      msg: "{{secret_token}}
```

En un playbook l'hem de cridar demananant per la contrasenya de vault

```bash
ansible-playbook --ask-vault-pass fitxer.yml
```

o bé definint-la en un fitxer:

```bash
ansible-playbook --vault-password-file contra fitxer.yml
```

Es desxifrar, xifrar un string, ...

```bash
ansible-vault encrypt-string --vault-password-file contra 'patata' --name 'var'
```

En els roles es pot definir directament en el directori de variables del sistema:

```text
group_vars
├── all
│  ├── vars.yml
│  └── vault.yml
├── alumnes
│  ├── vars.yml
│  └── vault.yml
└── servidors.yml
```

## 3 Plugins and collections

```bash
mkdir collections
touch requirements.yml
```

I hi poso les dependències:

```yaml
---
collections:
  - name: community.docker
  - name: containers.podman
```

també es pot definir un repositori de git:

```yaml
collections:
  - name: git@github.com:utrescu/avahi.git
    type: git
    version: devel
```

I les descarrego

```bash
ansible-galaxy install -r requirements.yml -p collections/
```

## 3.0 Arrancar mongo en Docker

```yaml
---
- name: Arrancar un contenidor
  hosts: localhost
  vars:
   - image: "mongo"
   - ports: [ "27017:27017" ]

  collections:
    - community.docker
  tasks:
    - name: Inicia un contenidor '{{ image }}'
      docker_container:
        name: "my{{image}}"
        image: "{{ image }}"
        state: started
        published_ports: "{{ ports }}"
        state: started
        detach: yes
        auto_remove: yes
        restart: yes
```

## 3.1 Carregar la col·lecció de Podman

Desplegar un contenidor Podman de nginx

```yaml
---
- name: Arrancar un contenidor
  hosts: localhost
  collections:
    - containers.podman
  tasks:
    - name: Inicia un contenidor nginx
      podman_container:
        name: mymongo
        image: mongo
        expose: "27017:27017"
        state: present
        recreate: yes
```

## 3.2 Crear una col·lecció

Primer creem l'estructura:

```bash
mkdir collections
cd collections
mkdir ansible_collections
cd ansible_collections
ansible-galaxy collection init udg.prova
```

Després només cal col·locar el role en el lloc que toca.

La podem usar instal·lant-la o bé fent un import manual:

```yaml
---
- hosts: ubuntot.local
  become: true
  collections:
    - xaviersala.avahi

  roles:
    - localdomain
```

## 7. Ansible Tower

Tower i AWX

## 8 Cendrassos

Veure playbooks amb roles del Cendrassos
