# Programes

Instal·la la llista de programes demanats pel professorat

TODO:

- Afegir la llista en una variable global de manera que no calgui modificar el role per afegir programes nous.

## Requirements

Cap

## Role Variables

Hi ha una llista de programes agrupat en desenvolupament i diversos:

- desenvolupament: llista de programes de desenvolupament
- smx: llista de programes de SMX

## Dependencies

Cap

## Example Playbook

Per executar:

```yaml
- hosts: servers
  roles:
      - role: programes
        vars:
          desenvolupament:
            - git-flow
            - wireshark
          smx:
            - gimp
            - vlc
```

## License

BSD

