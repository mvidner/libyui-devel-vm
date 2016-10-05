#!/bin/bash
set -eu

echo "PROVISIONING"

sudo zypper in -y screen
sudo zypper in --no-recommends osc build \
     make cmake boost-devel gcc-c++ pkg-config doxygen sudo \
     libqt5-qtbase-devel libqt5-qtsvg-devel libqt5-qtx11extras-devel \
     fontconfig-devel \
     ncurses-devel \
     graphviz-devel \
     libzypp-devel \
     swig ruby-devel python-devel mono-devel \
     yast2-devtools yast2-core-devel docbook-xsl-stylesheets

mkdir git
ln -snf git svn                 # old habits die hard
cd git

#git clone https://github.com/libyui/libyui-rake
gem install --user-install libyui-rake

PATH=.:$PATH
. functions.sh

build_it libyui

build_it libyui-ncurses
build_it libyui-ncurses-pkg

build_it libyui-qt
build_it libyui-qt-pkg

build_it libyui-gtk
build_it libyui-gtk-pkg

build_it libyui-bindings
build_it https://github.com/yast/yast-ycp-ui-bindings
