# salt-master
# kuidas giti kasutada salt failide üleslaadimiseks:

# Paigalda GIT:
   1. $ sudo apt-get install git #install
   2. $ git config --global user.name "asjalik" #kasutajanimi
   3. $ git config --global user.email "laidma27[at]gmail.com" #email
   4. $ git config --list #näitab mis conf on määra 
   5. $ nano ~/.gitconfig #saab käsitsi seda kõike määrata
   6. $ git init #initializeb directoryt kus asud
   7. $ git add . #lisab kõik mis directorys on
   8. $ git add README.md #lisab kindla faili
   9. $ git commit -m "Salt"
   10. $ git remote add origin https://github.com/asjalik/salt-master.git #add remote
   11. $ git push origin master #pushib failid kõiik mis on diris


#KUIDAS UPDATE FAILE:
   1. $ git commit #näitab ära mida saab commitida
   2. $ git commit -am "Adding tutorial" #commit kirjeldus

# Genereeri ssh-key, kui sul seda pole:
   1. ssh-keygen -t rsa
   2. Võtit saad näha ~/.ssh/id_rsa.pub

# To configure your GitHub account to use your SSH key:
Et giti pushimine oleks lihtsam, soovitan SSH key lisada github kasutaja alla!

   1. In your favorite text editor, open the ~/.ssh/id_rsa.pub file.
   2. Select the entire contents of the file and copy it to your clipboard.

# Add the copied key to GitHub:
   1. In the top right corner of any page, click your profile photo, then click$
   2. In the user settings sidebar, click SSH keys.
   3. Click Add SSH key.
   4. In the Title field, add a descriptive label for the new key. For example,$
   5. Paste your key into the "Key" field.
   6. Click Add key.
   7. Confirm the action by entering your GitHub password.

# Testi ühendust:
   1. $ ssh -T git@github.com
   2. Kui sul ei löö midagi ette, pead .ssh kausta config faili lisama ja sinna lisama mõned read

# Vaata, et .ssh asukohas oleks config fail ja sisaldaks jargnevat:
   1. go to $ ~/.ssh/config
   2. muuda ja lisa sellised read:
   3. Host github.com
   4. Hostname ssh.github.com
   5. Port 443
   6. Testi uuesti ühendust:
   7. $ ssh -T git@github.com
   8. Enter passphrase for key '/root/.ssh/id_rsa':
   9. Hi asjalik! You've successfully authenticated, but GitHub does not provid$
   10. Nüüd saad SSH key abil giti uploadida!
