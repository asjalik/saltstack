#http://fzysqr.com/2013/01/20/be-the-master-of-your-minions-an-introduction-to-salt/
ntp:
  pkg:
    - installed
  service:
    {% if grains['os'] == 'CentOS' or grains['os'] == 'RedHat' %}
    - name: ntpd
    {% endif %}
    - running
    - watch:
      - file: /etc/ntp.conf
  file.managed:
    {% if grains['os'] == 'Debian' or grains['os'] == 'Ubuntu' %}
    - name: /etc/ntp.conf
    - source: salt://ntp/files/ntp.conf.ubuntu
    {% elif grains['os'] == 'CentOS' or grains['os'] == 'RedHat' %}
    - name: /etc/ntp.conf
    - source: salt://ntp/files/ntp.conf.redhat
    {% endif %}
    - mode: 644
    - defaults:
          servers: ['<server1',
                  '<server2>']
    - require:
      - pkg: ntp
#aja vaatamiseks ntpdate -q <server>
#timedatectl
