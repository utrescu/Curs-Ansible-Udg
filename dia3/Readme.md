# Dia 3

## 1 Roles

### usar role

Fem servir un role de Ansible Galaxy. Per exemple instal·lar git:

```bash
mkdir roles
ansible-galaxy install geerlingguy.git -p roles/
```

Fer playbook:

```yaml
---
- hosts: xinxan.local

  roles:
    - geerlingguy.git
```

### Crear role de nginx

###

## 2 Ansible Vault

## 3 B

## 4 C

## 5 Cendrassos

Veure playbooks amb roles del Cendrassos
