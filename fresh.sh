#!/bin/sh

echo "Setting up your Mac..."

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Removes .zsh{env, rc} from $HOME (if it exists) and symlinks the .zsh{env, rc} file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s .dotfiles/.zshrc $HOME/.zshrc
rm -rf $HOME/.zshenv
ln -s .dotfiles/.zshenv $HOME/.zshenv

# Removes .gitignore_global from $HOME (if it exists) and symlinks the .gitignore_global file from .dotfiles
rm -rf $HOME/.gitignore_global
ln -s .dotfiles/.gitignore_global $HOME/.gitignore_global

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file ./Brewfile

# Creates Code directory
mkdir $HOME/Code

# Symlinks the Mackup config file to the home directory
rm -rf $HOME/.mackup.cfg
ln -s .dotfiles/.mackup.cfg $HOME/.mackup.cfg

# Set macOS preferences - we will run this last because this will reload the shell
source ./.macos
