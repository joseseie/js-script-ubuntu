#!/bin/bash
# THIS SCRIPT WILL CONFIGURE AUTOMATIC GIT DEPLOY
# COMPLETE TUTORIAL YOU CAN FIND HERE:
#https://www.digitalocean.com/community/tutorials/how-to-use-git-hooks-to-automate-development-and-deployment-tasks
# VERSION 1.0 October 10 2018
# Org: Explicador Inc
# Author: Explicador Inc

# Script validation checks
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

#Using Git Hooks to Deploy to a Separate Production Server

#Set Up the Production Server Post-Receive Hook

#we should give ownership of the document root to the user we are operating as:
sudo chown -R `whoami`:`id -gn` /var/www/html;

#We create a directory within our user's home directory to hold the repository
echo Digite o nome do seu repositório ou projecto, apenas uma palavra:;
read project;
mkdir ~/$project;
cd ~/$project;
git init --bare;

#nano hooks/post-receive;
touch hooks/post-receive;
echo '#!/bin/bash                          >> hooks/post-receive';
echo while read oldrev newrev ref         >> hooks/post-receive;
echo do                                   >> hooks/post-receive;
echo 'if [[ $ref =~ .*/master$ ]];         >> hooks/post-receive';
echo then                                 >> hooks/post-receive;
echo echo "Master ref received.  Deploying master branch to production..." >> hooks/post-receive;
echo git --work-tree=/var/www/html --git-dir=/home/ubuntu/$project checkout -f   >> hooks/post-receive;
echo "else   >> hooks/post-receive";
echo echo "Ref $ref successfully received.  Doing nothing: only the master branch may be deployed on this server." >> hooks/post-receive;
echo fi                                   >> hooks/post-receive;
echo done                                 >> hooks/post-receive;


#make the script executable for the hook to work:
chmod +x hooks/post-receive


#Aditional Info (Comments Only).

#Configure the Remote Server on your Client Machine
#cd ~/proj
#git remote add production username@server_domain_or_IP:project
#push to server using:
#git push production master 




#YOU CAN CREATE FILE WITH THIS CODE IN YOUR SERVER HOME DIRECTORY
#nano hooks/post-receive;
#!/bin/bash
#while read oldrev newrev ref
#do
#    if [[ $ref =~ .*/master$ ]];
#    then
#        echo "Master ref received.  Deploying master branch to production..."
#        git --work-tree=/var/www/html --git-dir=/home/demo/proj checkout -f
#    else
#        echo "Ref $ref successfully received.  Doing nothing: only the master branch may be deployed on this server."
#    fi
#done



