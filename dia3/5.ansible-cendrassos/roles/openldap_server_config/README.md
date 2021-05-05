OpenLDAP Server Config
=========

Configura el servei OpenLDAP i hi afegeix uns quants usuaris. 

Requirements
------------

Cap 

Role Variables
--------------

* **openldap_server_config_usuaris** és un array que té els alumnes a afegir amb dos elements: nom i contra (les contrasenyes ja estan xifrades amb SHA)

~~~
openldap_server_config_usuaris:
  - { nom: alumne1smx, contra: "{SHA}HQi6qzB5W122okz/84MeF8UMIRI=" }
  - { nom: alumne2smx, contra: "{SHA}nGiqEdTDJwd6eiocuxl1RyYaHP0=" }
  - { nom: alumne1daw, contra: "{SHA}FeMcwCNdfjXNLNPbq4nBZmrlm7w=" }
  - { nom: alumne2daw, contra: "{SHA}+ILmdv5f1K3TDXGuy/ly+rZEpRA=" }
~~~

Dependencies
------------

Cal tenir OpenLDAP instal·lat per tant depèn de *openldap_server*

Example Playbook
----------------


    - hosts: servers
      roles:
         - { role: openldap_server_config }

License
-------

BSD

