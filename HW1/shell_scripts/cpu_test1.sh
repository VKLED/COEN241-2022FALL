#!/bin/bash

for((i=0;i<5;i++))
do
    sysbench cpu --cpu-max-prime=10000 run
done
