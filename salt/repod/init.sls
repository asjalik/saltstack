 adding_repo_key:
   cmd.run:
     - name: wget -O- http://<Address_link_here>/apt.pub.key | apt-key add -
 
 copying_repo_list:
   cmd.run:
     - name: wget http://<Address_link_here/ubuntu/sources/$(lsb_release -sc)/apt.list

 moving_repo_list:
   cmd.run:
     - name: mv apt.list /etc/apt/sources.list

 pkrepo_salt:
   pkgrepo.managed:
     - name: deb http://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest trusty main
     - file: /etc/apt/sources.list
     - key_url: https://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest/SALTSTACK-GPG-KEY.pub

 repo_update:
   cmd.run:
     - name: apt-get update
