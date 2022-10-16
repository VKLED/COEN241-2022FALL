#!/bin/bash

for((i=0;i<5;i++))
do
    sysbench --threads=16 fileio --file-total-size=2G --file-test-mode=seqrd prepare
    sysbench --threads=16 fileio --file-total-size=2G --file-test-mode=seqrd run
    sysbench --threads=16 fileio --file-total-size=2G --file-test-mode=seqrd cleanup
done
