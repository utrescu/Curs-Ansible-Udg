# Instal·lar NetCore

Instal·lació d'Oracle Java en Ubuntu fent servir PPA

## Requirements

Cap

## Role Variables

* ubuntu_distribution: Distribució d'Ubuntu (per defecte xenial)
* dotnet_version: paquet a instal·lar (per defecte 5.0)

## Dependencies

Cap

## Example Playbook

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```yaml
- hosts: localhost
  roles:
      - { role: dotnet, dotnet_version: "5.1" }
```

## License

BSD
