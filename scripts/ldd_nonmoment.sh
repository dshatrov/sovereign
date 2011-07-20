#!/bin/sh

cd /opt/moment/lib
find -name "*.so" | xargs -l1 /usr/bin/ldd | grep -v "/opt/moment" | grep -v vdso | grep -v "ld-linux" | grep -v "not a " | sort | uniq > ~/out_lib

