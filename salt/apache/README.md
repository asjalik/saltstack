#######################
# /salt/apache/init.sls
#######################

#Paigaldame apache Ubuntu ja RedHati peale
installing_apache:
  pkg.installed:
    {% if grains['os'] == 'Ubuntu' %}
    - name: apache2
    {% elif grains['os_family'] == 'RedHat' %}
    - name: httpd
    {% endif %}

running_apache:
  service.running:
    {% if grains['os'] == 'Ubuntu' %}
    - name: apache2
    {% elif grains['os_family'] == 'RedHat' %}
    - name: httpd
    {% endif %}
    - enable: True
    - require:
      - pkg: installing_apache
    - watch:
      - file: copying_conf_apache

copying_conf_apache:
  file.managed:
    {% if grains['os'] == 'Ubuntu' %}
    - name: /etc/apache2/apache2.conf
    - source: salt://apache/files-ubuntu-14/apache2.conf
    {% elif grains['os_family'] == 'RedHat' %}
    - name: /etc/httpd/conf/httpd.conf
    - source: salt://apache/files-centos-7/httpd.conf
    {% endif %}
    - mode: 644
    - user: root
    - group: root

copying_conf_apache_sites-available:
 file.recurse:
   - name: /etc/apache2/sites-available
   - source: salt://apache/files-ubuntu-14/sites-available
   - dir_mode: 755
   - file_mode: 644
   - user: root
   - group: root
