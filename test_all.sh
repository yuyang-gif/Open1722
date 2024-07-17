#!/bin/bash 
set -ev 

./build_all.sh 
make test
# ninja coverage-html
