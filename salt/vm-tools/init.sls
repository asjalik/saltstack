{% if grains['os_family'] == 'Debian' %}
installing_vm-tools:
  pkg.installed:
    - name: open-vm-tools
{% endif %}

{% if grains['os_family'] == 'RedHat' %}
installing_vm-tools:
  pkg.installed:
    - name: open-vm-tools
{% endif %}
