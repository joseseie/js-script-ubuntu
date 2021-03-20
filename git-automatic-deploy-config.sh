#!/bin/bash

# SAVE THIS SCCRIPT AT:
# /home/ubuntu/myrepo.git/hooks/post-receive
# Don't forget to put correct paths

TARGET="/var/www/admin.explicador.co.mz/html/"
GIT_DIR="/home/ubuntu/admin.explicador.co.mz-bare.git"

# Colors
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
no_color='\033[0m'

while read oldrev newrev ref
do
        # Get brench name
        BRANCH=$(echo "$ref" | cut -d/ -f3)

        # only checking out the master (or anyother)
        if git --work-tree=$TARGET --git-dir=$GIT_DIR checkout -f "$BRANCH"; then
                # Go to work-tree
                echo -e "\n${green}Running npm install${no_color}\n"
                cd "${TRAGET}" && ls -l # && npm install

                # Restart
                echo -e "\n${green}Restarting laravel app${no_color}\n"
                sudo service nginx restart
                echo -e "\n${green}**********************************"
                echo -e "\nLatest files deployed"
                echo -e "\n*********************************${no_color}"
        else
                echo -e "\n${red}Ref $BRANCH successfully received.  Doing nothing: only the master branch may be deployed on this >
        fi
done
