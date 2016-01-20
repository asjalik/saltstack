copying_zabboxRepo:
  cmd.run:
    - name: wget http://repo.zabbix.com/zabbix/2.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_2.2-1+trusty_all.deb

moving_ZabbixREPO:
  cmd.run:
    - name: dpkg -i zabbix-release_2.2-1+trusty_all.deb

ZABBIXrepo_upgrade:
  cmd.run:
    - name: apt-get update

zabbix-agent:
  pkg.installed: []
  service.running:
    - watch:
      - file: /etc/zabbix/zabbix_agentd.conf
    - require:
      - pkg: zabbix-agent

/etc/zabbix/zabbix_agentd.conf:
  file.managed:
    - source: salt://zabbix-agent/files/zabbix_agentd.conf
    - mode: 644
    - user: root
    - group: root
