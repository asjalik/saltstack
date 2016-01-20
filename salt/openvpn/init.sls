{% if grains['os_family'] == 'Debian' %}
installing_openvpn:
  pkg.installed:
    - name: openvpn
{% endif %}

{% if grains['os_family'] == 'Debian' %}
copying_conf_openvpn:
  file.managed:
    - name: /etc/openvpn/update-resolv-conf
    - source: salt://openvpn/files/update-resolv-conf
    - mode: 644
    - user: root
    - group: root
{% endif %}

{% if grains['os_family'] == 'Debian' %}
running_openvpn:
  service.running:
    - name: openvpn
    - enable: True
    - require:
      - pkg: installing_openvpn
    - watch:
      - file: copying_conf_openvpn
{% endif %}
