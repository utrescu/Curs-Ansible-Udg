Docker
=========

Instal·lació de Docker-Engine en Ubuntu

Requirements
------------

Parteix de la idea de que hi ha un usuari 'alumne' que s'ha d'afegir al grup de 'docker'.

> TODO: S'ha de parametritzar l'usuari 'alumne'
> TODO: Afegir 'docker' als grups LDAP

Role Variables
--------------

Hi ha dues variables bàsiques: 

* La variable **ubuntu_distribucio** es fa servir per definir la distribució d'Ubuntu. Per defecte descobreix la versió amb els facts d'Ansible però es pot forçar.
* La variable **docker_compose_version** es fa servir per definir la versió de docker-compose que es vol descarregar

Dependencies
------------

Cap.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: docker, ubuntu_distribucio: xenial }

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
