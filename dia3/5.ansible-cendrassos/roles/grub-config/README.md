# Grub-config

Posa contrasenya a l'edició de les entrades de Grub.

## Requirements

Cap

## Role Variables

Hi ha dues variables bàsiques:

- La variable **grub_admin** es l'usuari que farà servir Grub
- **grub_password** és la contrasenya codificada de Grub. Es genera amb _grub-mkpasswd-pbkdf2_

## Dependencies

Cap.

## Example Playbook

Per usar-lo només cal especificar el role i definir-hi les variables bàsiques

    - hosts: grub-config
      roles:
        - { role: grub-config,
            grub_user: admin, grub_password: grub.pbkdf2.sha512.10000.FC58373BCA15A797C418C1EA7FFB007BF5A5 }

Per facilitar-ho també es pot definir la contrasenya de root al fitxer defaults/main.yml i d'aquesta forma es podrà executar simplement amb:

    - hosts: x
      roles:
        - { role: grub-config }

## License

BSD
