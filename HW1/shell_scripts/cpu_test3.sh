#!/bin/bash

for((i=0;i<5;i++))
do
    sysbench cpu --cpu-max-prime=30000 run
done
