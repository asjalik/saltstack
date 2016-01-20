base:
  '*': # These modules are going to be applied to all minions 
    - ntp #aeg
    - vsftpd #for all
    - wget #for all!
  'salt-db*':
    - openvpn
  'salt-www*':
    - apache #for web
  'os:CentOS':
    - match: grain
    - vm-tools
  'os:Ubuntu':
    - match: grain
    - zabbix-agent
    - vm-tools
    - repod
    - update
