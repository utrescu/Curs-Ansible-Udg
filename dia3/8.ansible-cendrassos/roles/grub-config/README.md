# Grub-config

Posa contrasenya a l'edició de les entrades de Grub.

## Requirements

Cap

## Role Variables

Hi ha dues variables bàsiques:

- La variable **grub_admin** es l'usuari que farà servir Grub
- **grub_password** és la contrasenya codificada de Grub. Es genera amb *grub-mkpasswd-pbkdf2*

## Dependencies

Cap.

## Example Playbook

Per usar-lo només cal especificar el role i definir-hi les variables bàsiques

```yaml
  - hosts: grub-config
    roles:
      - role: grub-config
        vars:
          grub_user: admin
          grub_password: grub.pbkdf2.sha512.10000.FC58373BCA15A797C418C1EA7FFB007BF5A5
```

Si s'executa directament es generarà però farà servir la contrasenya per defecte.

```yaml
- hosts: x
  roles:
    - grub-config
```

## License

BSD
