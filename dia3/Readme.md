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

## 3 B

## 4 C

## 5 Cendrassos

Veure playbooks amb roles del Cendrassos
