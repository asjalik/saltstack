# Authenticate with SSSD and create user's home direcories

 sssd-dependencies:
   pkg.installed:
     - name: sssd-tools
     - name: sssd
     - name: sssd-ldap

 realmd:
   pkg.installed:
     - name: realmd

 samba-common:
   pkg.installed:
     - name: samba-common

 krb5-user:
   pkg.installed:
     - name: krb5-user

 /etc/pam.d/common-session:
   file.append:
     - text:
       - session required        pam_mkhomedir.so skel=/etc/skel/ umask=0022
   require:
     - pkg: sssd-dependencies
     - pkg: realmd
     - pkg: samba-common
     - pkg: krb5-user

# We will use module.run state to call the cmd.run module #}
#    - name: cmd.run- This is the module we call, not state as state
#doesn't take 'stdin' argument


 join_Domain:
   cmd.run:
     - name: echo '{{salt['pillar.get']('sssd:lookup:password')}}' | realm --verbose join --user={{salt['pillar.get']('sssd:lookup:username')}} {{salt['pillar.get']('sssd:lookup:domain')}}

 copying_conf_sssd:
   file.managed:
     - name: /etc/sssd/sssd.conf
     - source: salt://sssd/files/sssd.conf
     - user: root
     - group: root
     - mode: 600
     - require:
       - pkg: sssd-dependencies

 restart__for_sssd:
   cmd.run:
     - name: service sssd restart
