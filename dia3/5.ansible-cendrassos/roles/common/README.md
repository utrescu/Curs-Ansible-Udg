Common
=========

Configuració comuna a tots els ordinadors de la xarxa. 

Bàsicament el que fa és:
- Impedir la connexió SSH als alumnes 
  - Es fa perquè es va posar de moda apagar els ordinadors dels altres connectant-s'hi a través de SSH


Requirements
------------

Cap

Role Variables
--------------

Cap

Dependencies
------------

Cap

Example Playbook
----------------

S'executa amb un Playbook que tingui una forma com aquesta:

    - hosts: servers
      roles:
         - { role: common  }

License
-------

BSD

