#!/bin/sh
sudo apt-get update
sudo apt-get build-essential ruby

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"

$HOME/.linuxbrew/bin/brew install vim

./install
