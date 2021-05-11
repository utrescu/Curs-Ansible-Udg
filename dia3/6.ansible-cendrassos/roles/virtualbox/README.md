virtualbox
=========

Instal·la VirtualBox en una màquina

Requirements
------------

Cap

Role Variables
--------------

Hi ha una variable que permet definir quina versió de VirtualBox es vol instal·lar

* **virtualbox_version**: Per defecte instal·la la versió 5.1.26
* **ubuntu_distribucio** serveix per definir quina distribució d'Ubuntu s'afegeix. En principi l'hauria de detectar automàticament però es pot forçar sobreescrivint la variable

> TODO: s'hauria de parametritzar l'usuari 'alumne' pels alumnes en Offline

> TODO: Comprovar el grup dels usuaris LDAP

Dependencies
------------

Cap

Example Playbook
----------------

Per executar:

    - hosts: all
      roles:
         - { role: virtualbox, virtualbox_version: 5.1.26, ubuntu_distribucio: xenial }

License
-------

BSD

