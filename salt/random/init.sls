{% if not salt['file.directory_exists' ]('/home/init_dir') %}
/tmp/random:
  file.directory:
    - user:  root
    - name:  /tmp/random
    - group:  root
    - mode:  755
{% else %}
  cmd.run:
     - name: echo "Directory exists"
  {% endif %}

/tmp/random/randomfile.txt:
  file.append:
    - content: 
        {{salt['pillar.get']('headers:salt:file')}}
