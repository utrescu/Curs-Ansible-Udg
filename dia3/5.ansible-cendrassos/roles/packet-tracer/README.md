Packet-tracer
===============

Instal·lació de Packet Tracer en Ubuntu. 

NOTES: 

* He hagut de modificar l'script d'Instal·lació perquè no aconseguia respondre totes les preguntes de l'instal·lador.
* He hagut de modificar el fitxer desktop perquè no l'instal·la bé

Requirements
------------

Ha de ser Ubuntu perquè no em funciona en Fedora

Role Variables
--------------

Cap

Dependencies
------------

Cap

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: packet-tracer }

License
-------

BSD

