#!/bin/bash 
set -ev 

./build_all.sh
cd build
make test
# ninja coverage-html
