#!/usr/bin/env ruby

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

sudo brew install wget
sudo brew install nmap

# --devel instead of --HEAD for the last dev version
sudo brew install emacs --with-cocoa --with-gnutls --with-librsvg --with-imagemagick --HEAD --use-git-head
sudo brew linkapps emacs
# sudo brew services start emacs
