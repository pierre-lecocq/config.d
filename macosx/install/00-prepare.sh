#!/usr/bin/env ruby

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

sudo brew install wget
sudo brew install nmap

sudo brew install emacs --with-cocoa --HEAD --use-git-head
sudo brew linkapps emacs
