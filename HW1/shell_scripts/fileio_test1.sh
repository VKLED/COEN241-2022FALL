#!/bin/bash

for((i=0;i<5;i++))
do
    sysbench --threads=16 fileio --file-total-size=2G --file-test-mode=rndrw prepare
    sysbench --threads=16 fileio --file-total-size=2G --file-test-mode=rndrw run
    sysbench --threads=16 fileio --file-total-size=2G --file-test-mode=rndrw cleanup
done
