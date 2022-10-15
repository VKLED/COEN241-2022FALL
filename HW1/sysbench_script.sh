#!/bin/bash

chmod +777 ./shell_scripts/*.sh

for((i=1;i<4;i++))
do
    ./shell_script/cpu_test$i.sh > ./results/test_cpu$i.txt
    ./shell_script/fileio_test$i.sh > ./results/fileio_cpu$i.txt
done
