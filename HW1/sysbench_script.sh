#!/bin/bash

chmod +777 ./shell_scripts/*.sh
mkdir results

for((i=1;i<4;i++))
do
    ./shell_scripts/cpu_test$i.sh > ./results/result_cpu$i.txt
done

for((i=1;i<4;i++))
do
    ./shell_scripts/fileio_test$i.sh > ./results/result_fileio$i.txt
done
