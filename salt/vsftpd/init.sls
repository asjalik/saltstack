installing_vsftpd:
  pkg.installed:
    - name: vsftpd

copying_conf_vsftpd:
  file.managed:
    - name: /etc/vsftpd.conf
    - source: salt://vsftpd/files/vsftpd.conf
    - mode: 644
    - user: root
    - group: root
{% if grains['os_family'] == 'MacOS' %}
    - name: /etc/vsftpd.conf
    - source: salt://vsftpd/files/vsftpd.conf
    - mode: 644
    - user: admin
    - group: admin
{% endif %}

{% if grains['os_family'] == 'Debian' %}
running_vsftpd:
  service.running:
    - name: vsftpd
    - enable: True
    - require:
      - pkg: installing_vsftpd
    - watch:
      - file: copying_conf_vsftpd
{% elif grains['os_family'] == 'RedHat' %}
running_vsftpd:
  service.running:
    - name: vsftpd
    - enable: True
    - require:
      - pkg: installing_vsftpd
    - watch:
      - file: copying_conf_vsftpd
{% endif %}
