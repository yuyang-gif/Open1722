#!/bin/bash 
set -ev 

./build_all.sh
cd ./build 
meson test
ninja coverage-html