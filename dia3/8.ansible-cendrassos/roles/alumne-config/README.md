# alumne-config

El que fa és definir una configuració específica dels ordinadors que fan servir els alumnes.

Per ara fa:

- Crea un usuari per poder-lo usar sense connexió LDAP
  - Es crea un usuari local perquè a vegades hi ha problemes en la xarxa i els ordinadors no poden connectar amb el servidor LDAP. Això fa que els alumnes no puguin entrar en el sistema.

## Requirements

Cap

## Role Variables

Les variables defineixen l'usuari i la seva contrasenya en format hash

- **user_username**: Nom de l'usuari que es crearà (per defecte 'alumne')
- **user_password**: Hash de la contrasenya d'aquest usuari

## Dependències

Cap

## Exemple Playbook

```yaml
    - hosts: servers
      roles:
         - { role: alumne-config, user_username: pepet }
```

## License

BSD
