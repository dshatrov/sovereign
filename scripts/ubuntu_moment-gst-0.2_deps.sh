#!/bin/sh

# Dev convenience
apt-get install -y vim
apt-get install -y glibc-doc
apt-get install -y libfuse-dev

# For mydb
apt-get install -y autoconf automake libtool
apt-get install -y libglib2.0-dev

# Needed for glibc to build
apt-get install -y gawk

# For glib-networking
apt-get install -y intltool

# For libvpx
apt-get install -y yasm nasm

# For gstreamer
apt-get install -y bison flex

