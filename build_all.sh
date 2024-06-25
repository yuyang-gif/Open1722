#!/bin/bash 
set -ev 

mkdir -p build
meson . build -Db_coverage=true
meson compile -C build/ \
    examples/aaf/aaf-listener \
    examples/aaf/aaf-talker \
    examples/acf-can/acf-can-listener \
    examples/acf-can/acf-can-talker \
    examples/crf/crf-talker \
    examples/crf/crf-listener \
    examples/cvf/cvf-talker \
    examples/cvf/cvf-listener \
    examples/ieciidc/ieciidc-talker \
    examples/ieciidc/ieciidc-listener     