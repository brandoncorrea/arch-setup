#!/bin/sh

curl -sLO https://raw.githubusercontent.com/babashka/babashka/master/install
chmod +x install
./install
rm install
