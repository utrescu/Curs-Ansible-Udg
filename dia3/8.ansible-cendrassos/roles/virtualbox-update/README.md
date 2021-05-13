# Role Name

Actualitza les extensions oficials d'Oracle.

El problema és que com que VirtualBox en Ubuntu afegeix el programa en un repositori s'actualitza
normalment però després d'actualitzar la versió del programa i la de l'extension pack no quadren
amb la versió de VirtualBox i en algun cas ha portat problemes.

Aquest 'role' comprova si la versió de les extensions quadra amb la versió de VirtualBox instal·lada
i en cas de que no quadri les actualitza.

## Requirements

Necessita tenir VirtualBox instal·lat perquè el control d'errors és rudimentari.

## Example Playbook

```yaml
- hosts: servers
  roles:
    - { virtualbox-update }
```

## License

BSD
