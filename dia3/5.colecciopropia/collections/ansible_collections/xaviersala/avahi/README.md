# Ansible Collection - xaviersala.avahi

This repo hosts the `xaviersala.avahi` Ansible Collection.

## Documentation

Installs Avahi to access to the hosts using .local domain.

Tested with Fedora, Ubuntu and Debian

## Installation and Usage

### Installing the Collection from Ansible Galaxy

### Playbooks

To use a module from Xaviersala collection, please reference the full namespace, collection name,
and modules name that you want to use:

```yaml
---
- name: Using Xaviersala collection
  hosts: localhost
  tasks:
    - name: Run configure avahi
      import_role:
        name: avahi
```

Or you can add full namespace and collection name in the `collections` element:

```yaml
---
---
- hosts: localhost
  become: true
  collections:
    - xaviersala.avahi

  tasks:
    - name: Run configure avahi
      import_role:
        name: avahi
```

## Contributing

This is only a test

## More Information

TBD

## License

GPL-2.0-or-later
