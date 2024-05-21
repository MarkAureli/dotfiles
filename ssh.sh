#!/bin/sh

echo "Generating a new SSH key for GitHub..."

# Generating a new SSH key
# https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key
mkdir ~/.ssh/keys
ssh-keygen -t ed25519 -C $1 -f ~/.ssh/keys/key_github

# Adding your SSH key to the ssh-agent
# https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent
eval "$(ssh-agent -s)"

touch ~/.ssh/config
echo "Host github github.com\n\tAddKeysToAgent yes\n\tUseKeychain yes\n\tHostName github.com\n\tUser git\n\tIdentityFile ~/.ssh/keys/key_github\n\nHost *\n\tIdentitiesOnly yes" | tee ~/.ssh/config

ssh-add -K ~/.ssh/keys/key_github

# Adding your SSH key to your GitHub account
# https://docs.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account
echo "run 'pbcopy < ~/.ssh/keys/key_github.pub' and paste that into GitHub"
