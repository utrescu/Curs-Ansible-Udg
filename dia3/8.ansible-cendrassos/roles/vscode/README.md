# vscode

Instal·lar Visual Studio Code

## Requirements

Cap

## Role Variables

Es poden sobreescriure la versió de VSCode, vscode_version, i la URL des d'on la descarreguem vscode_url_deb

- TODO: Ja hi ha el repositori debian o sigui que es podria integrar  en els programes normals

## Example Playbook

S'executa amb:

```yaml
- hosts: alumnes
  roles:
      - { role: vscode, vscode_version: "1.55.2" }
```

## License

BSD

