 pkrepo_upgrade:
   cmd.run:
     - name: apt-get update

 pkg.list_upgrades:
   module.run:
     - dist_upgrade: True
     - refresh: True

 pkg.upgrade:
   module.run:
     - dist_upgrade: True
     - refresh: True
