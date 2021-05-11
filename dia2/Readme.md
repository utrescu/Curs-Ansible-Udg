# Dia 2

## Variables

### setup

```bash
ansible xinxan.local -i inventari -m setup
```

Es pot executar amb filtres

```bash
ansible xinxan.local -i inventari -m setup -a "filter=ansible_distribution*"
```

- ansible_os_family (Debian, RedHat, ...)
- ansible_system (Linux, Win32NT)
- ansible_pkg_mgr (apt, dnf, yum ... )
- ansible_distribution
- ansible_env
- ansible_nodename / ansible_hostname / ansible_hstnqn
- ansible_domain
- ansible_lsb
- ansible_user\*
- ansible_machine ansible_memory, ansible_virtualization\*

### Definir inventari en la configuració

Edito `ansible.cfg` i hi poso qui és l'inventari

```ini
[defaults]
inventory = ./inventari
```

### debug

El mòdul debug es pot fer servir per detectar problemes en els playbooks o
simplement per emetre logs

```bash
ansible xinxan.local -i inventari -m debug -a 'msg={ansible_nodename}'
```

```bash
ansible xinxan.local -i inventari -m debug -a '{{ ansible_default_ipv4_address }}'
```

### Extra variables

```bash
ansible xinxan.local -i inventari -e Hola="Pere" -m shell -a "echo {{Hola}}"
```

## Playbooks

### 0. YAML?

Funcionamemt bàsic

```yaml
nom: "valor"
numero: 2
senseres: null

llista:
  - "un"
  - "dos"

llista2: ["un", "dos"]

pi_family:
  - nom: "Pere"
    cognom: "Pi"
  - nom: "Pau"
    cognom: "Pi"
  - { nom: "Maria", cognom: "Pi" }

descripcio: >
  aaaaaaaaaaaaa
  aaaaaaaaaaaaa
  aaaaaaaaaaaaa
```

S'hi pot accedir amb `[]` o amb `.`

### 1. Ping playbook

```yaml
---
- hosts: xinxan.local
  user: pi

  tasks:
    - name: Comprovar que està viu
      ping:
```

### 2. Sobreescriure variables

fer servir debug per **veure com es sobreescriuren les variables**.

Imprimim el nom del host quan executem això:

```yaml
---
- hosts: xinxan.local
  user: pi

  tasks:
    - name: Llista hosts
      debug:
        msg: "{{ansible_nodename}}"
```

Amb

```bash
ansible-playbook -i inventari debugnodename.yml
```

Però si li passem la variable per línia de comandes el resultat és diferent

```bash
ansible-playbook -i inventari -e ansible_nodename="patata" debugnodename.yml
```

### 3. Instal·lar joe playbook (variables)

```yaml
---
- hosts: xinxan.local
  user: pi

  vars:
    - programa: joe

  tasks:
    - name: Comprovar que està viu
      ping:

    - name: Instal·lar {{programa}}
      apt: pkg={{programa}} state=present
      become: yes
```

### 4. Instal·lar VLC en Windows (descarrega i instal·la)

```yaml
---
- hosts: scotty
  vars:
    - url: https://ftp.cixug.es/videolan/vlc/3.0.13/win64/vlc-3.0.13-win64.msi

  tasks:
    - name: Descarregar VideoLan
      win_get_url:
        url: "{{ url }}"
        dest: C:\tmp\vlc.msi

    - name: Instal·lar VLC
      win_package:
        path: C:\tmp\vlc.msi
        state: present
```

Per desinstal·lar-lo en tenim prou amb:

```bash
ansible scotty -m win_package -a 'path=C:\\tmp\\vlc.msi state=absent'
```

### 5. Canviar configuració SSH perquè no admeti usuari i contrasenya

```yaml
- hosts: xinxan.local
  tasks:
    - name: COMMON - Copiar arxiu de configuració SSHd
      copy:
        src: sshd_config
        dest: /etc/ssh
        owner: root
        group: root
        mode: 0644
        backup: yes
        validate: "/usr/sbin/sshd -T -f %s"
      notify:
        - Reiniciar SSHd
  handlers:
    - name: Reiniciar SSHd
      service:
        name: ssh
        state: restarted
```

### 6. Alguna altra cosa?

### 7. Instal·lar Nginx playbook

```yaml
---
- name: Configurar pàgina web amb nginx
  hosts: ubuntot.local
  become: yes

  tasks:
    - name: Instal·lar nginx
      apt: name=nginx update_cache=no

    - name: Copiar pàgina web
      copy:
        src: web
        dest: /var/www/html
        mode: 0644

    - name: desctivar configuració per defecte
      file: path=/etc/nginx/sites-enabled/default state=absent

    - name: copiar configuració de la nova web
      copy: src=nginx.conf dest=/etc/nginx/sites-available/web

    - name: Activar nova configuració
      file:
        dest: /etc/nginx/sites-enabled/web
        src: /etc/nginx/sites-available/web
        state: link

    - name: reiniciar nginx
      service: name=nginx state=restarted
```

Evidentment el que estaria més bé seria que **nginx només es reinicii si cal**:

```yaml
    - name: Activar nova configuració
      file:
        dest: /etc/nginx/sites-enabled/web
        src: /etc/nginx/sites-available/web
        state: link
      notify: reinciar nginx

    handlers:
    - name: reiniciar nginx
      service: name=nginx state=restarted
```

També s'han de **Copiar els tres arxius**

## Templates

### 0. Llista personatges

```yaml
---
- hosts: xinxan.local

  vars:
    pelis:
      - titol: "Star Wars"
        personatges:
          - Luke Skywalker
          - Leia Organa
          - Han Solo
          - Chewbacca
          - Ben Obi-Wan Kenobi
          - C-3PO
          - R2-D2
          - Dart Vader
      - titol: "Star Trek"
        personatges:
          - James T. Kirk
          - Spock
          - Leonard McCoy
          - Montgomery Scott
          - Nyota Uhura
          - Pavel Checkov
          - Hikaru Sulu

  tasks:
    - name: Crea el fitxer
      template:
        src: pelis.txt.j2
        dest: "/home/{{ansible_user}}/pelis.txt"
```

Amb el fitxer:

```jinja
{% for peli in pelis %}

{{ peli.titol }}
----------------
{% for personatge in peli.personatges %}
- {{ personatge }}
{% endfor %}
{% endfor %}
```

### 1. Genera el fitxer hosts amb les màquines (ansible_facts)

```yaml
---
- hosts: xinxan.local
  become: true

  vars:
    - fitxer: llista.txt
    - mostra_loopback: true

  tasks:
    - name: Crea el fitxer de hosts
      template:
        src: "{{ fitxer }}.j2"
        dest: "/home/{{ansible_user}}/{{ fitxer }}"
        backup: true
```

I la plantilla:

```jinja
# {{ ansible_managed }}

{%if mostra_loopback %}
# màquina local
127.0.0.1 {{ inventory_hostname | lower }} {{ inventory_hostname_short | lower }}
{% endif %}

# altres màquines
{% for host in groups['all'] %}
{{ hostvars[host]['ansible_default_ipv4']['address'] | default('#') }} {{ hostvars[host]['ansible_hostname'] | default("")}} {{ host }}{{ '\n' -}}
{% endfor %}
```

### 2. Convertir Nginx a templates?

## Condicions i bucles

### 1. Joe (condicionals)

Instal·lar joe segons el sistema de paquets:

```yaml
---
- hosts:
    - xinxan.local
    - localhost
  become: yes
  tasks:
    - name: Comprovar que està viu
      ping:

    - name: Instal·lar joe (apt)
      apt:
        name: joe
        state: present
      become: yes
      when: ansible_os_family == "Debian"

    - name: Instal·lar joe (yum)
      apt:
        name: joe
        state: present
      become: yes
      when: ansible_os_family == "RedHat"
```

### 2a. Exemple register

```yaml
---
- hosts: xinxan.local
  user: pi

  tasks:
    - name: pintar Hola
      shell: echo Hola
      register: resultat

    - name: Ha funcionat tot bé
      debug:
        var: resultat
      when: resultat.rc == 0
```

### 2. Actualitzar Windows (condicio, register)

```yaml
---
- hosts: scotty

  tasks:
    - name: instal·lar actualitzacions crítiques i de seguretat
      win_updates:
        category_names:
          - CriticalUpdates
          - SecurityUpdates
        state: installed
      register: update_result

    - name: reiniciar
      win_reboot:
      when: update_result.reboot_required
```

### 3. Multiple software (bucles)

```yaml
---
- hosts: xinxan.local
  user: pi

  vars:
    programa:
      - joe
      - htop

  tasks:
    - name: Comprovar que està viu
      ping:

    - name: Instal·lar {{programa}}
      apt: name={{programa}} state=present
      become: yes
```
