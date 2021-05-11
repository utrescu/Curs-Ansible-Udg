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

## 2 Ansible Vault

## 3 B

## 4 C

## 5 Cendrassos

Veure playbooks amb roles del Cendrassos
