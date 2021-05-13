# openldap_client

Configura un sistema amb Ubuntu perquè es converteixi en client del servidor LDAP i permeti als usuaris fer login gràficament.

## Requirements

Hi ha d'haver un servidor OpenLDAP funcionant

## Role Variables

- **localgroups**:
  - Defineix els grups als que ha de pertànyer l'usuari (default: "*;*;*;Al0000-2400;audio,cdrom,dialout,floppy,docker,vboxusers")
- **ldap_config**: Llista amb la configuració del client

## Dependencies

Cap

## Example Playbook

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```yaml
    - hosts: servers
      roles:
         - openldap_client
```

o expecificant les variables:

```yaml
- hosts: localhost
  roles:
   - role: openldap_client
       base: "dc=cendrinf,dc=ies"
       uri: "ldap://localhost"
       rootbinddn: "cn=admin,dc=cendrinf,dc=ies"
       port: 389
       secret: {{ ldap_password }
```

## License

BSD
