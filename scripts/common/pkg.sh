#!/bin/sh

set -e
set -x

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y git python-pip
sudo pip install gitpython testinfra