#!bin/bash

for((i=0;i<5;i++))
do
    sysbench --num-threads=16 --test=fileio --file-total-size=2G --file-test-mode=seqwr prepare
    sysbench --num-threads=16 --test=fileio --file-total-size=2G --file-test-mode=seqwr run
    sysbench --num-threads=16 --test=fileio --file-total-size=2G --file-test-mode=seqwr cleanup
done
