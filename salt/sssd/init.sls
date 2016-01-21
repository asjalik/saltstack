# Authenticate with SSSD and create user's home direcories
#Installib paketid
 sssd-dependencies:
   pkg.installed:
     - name: sssd-tools
     - name: sssd
     - name: sssd-ldap
#installib realmd paketi
 realmd:
   pkg.installed:
     - name: realmd
#installib samba-common paketi
 samba-common:
   pkg.installed:
     - name: samba-common
#installib krb5-user paket
 krb5-user:
   pkg.installed:
     - name: krb5-user
#Kirjutab common-session faili(top of file) sisse järgmise rea 
 /etc/pam.d/common-session:
   file.prepend:
     - text:
         - "session required        pam_mkhomedir.so skel=/etc/skel/ umask=0022”
   require: #mida on vaja, et seda toimingut teha
     - pkg: sssd-dependencies
     - pkg: realmd
     - pkg: samba-common
     - pkg: krb5-user

#Liitub domeeniga
#Käsk näeb välja selline: ec 'parool' | realm --verbose join --user=kasutajanimi domeen
#Mina kasutasin pillaris olevaid andmeid, et neid kohti täita
 join_Domain:
   cmd.run:
     - name: echo '{{salt['pillar.get']('sssd:lookup:password')}}' | realm --verbose join --user={{salt['pillar.get']('sssd:lookup:username')}} {{salt['pillar.get']('sssd:lookup:domain')}}

#Kopeerib sssd.conf faili ja paneb selle sssd asukohta
 copying_conf_sssd:
   file.managed:
     - name: /etc/sssd/sssd.conf
     - source: salt://sssd/files/sssd.conf
     - user: root
     - group: root
     - mode: 600
     - require:
       - pkg: sssd-dependencies

#Paneb sssd conf faili headeriks minu pillaris olev sisu
#file.prepend = top file.append = bottom
 /etc/sssd/sssd.conf:
   file.prepend:
     - text:
       - "{{salt['pillar.get']('headers:salt:file')}}"

#Teeb sssd teenusele restarti
 restart__for_sssd:
   cmd.run:
     - name: service sssd restart
