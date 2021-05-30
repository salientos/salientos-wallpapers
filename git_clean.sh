#!/bin/bash

##############################################################################
#
#  Program :	clean_up v1
#  Arch    :	x86_64 
#  Author  : 	Silent Robot
#  Website : 	https://sourceforge.net/projects/salient-os/
#
##############################################################################

_msg() {
    printf "\n"
    term_cols=$(tput cols)
    str="$1"
    tput setaf 5; printf '%*s\n' "${term_cols}" '' | tr ' ' - ; tput sgr0
    tput setaf 4; printf "%*s\n" $(((${#str}+$term_cols)/2)) "$str"; tput sgr0
    tput setaf 5; printf '%*s\n' "${term_cols}" '' | tr ' ' - ; tput sgr0
}

# Backup config & remove .git dir
_msg "Backing up config & deleting .git dir..."
mv .git/config config
rm -rf .git

# Reinitialise git
_msg "Setting up git repository..."
git init
git config --global user.name "salientos"
git config --global user.email "d3signr@gmail.com"
sudo git config --system core.editor nano
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=25000'
git config --global push.default simple
_msg "Git Repository Setup Complete!"

# Move config back to .git & push changes to repo
_msg "Moving config to .git dir & pushing changes..."
mv config .git/config
git add --all .
git commit -m "Initialise Repo"
git push origin master --force
_msg "Git clean up completed..."
