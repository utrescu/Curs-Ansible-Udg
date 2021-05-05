Role Name
=========

Actualitza les extensions oficials d'Oracle.

El problema era que com que VirtualBox en Ubuntu afegeix el programa en un repositori s'actualitzava normalment. 

El problema era que després d'actualitzar les versions de 'extension pack' no quadrava amb la versió de VirtualBox.

Aquest 'role' comprova si la versió de les extensions quadra amb la versió de VirtualBox instal·lada.

Requirements
------------

Necessita tenir VirtualBox instal·lat.

Role Variables
--------------

Dependencies
------------

Example Playbook
----------------

    - hosts: servers
      roles:
         - { virtualbox-update }

License
-------

BSD

Author Information
------------------
Xavier Sala
