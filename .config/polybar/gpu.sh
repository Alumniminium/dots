#!/bin/bash

samples=10

for (( ; ; )) 
do
    total=0
    for i in $(seq 1 $samples) 
    do
        sample=$(cat /sys/class/drm/card0/device/gpu_busy_percent)
        total=$((total + sample))
        sleep 0.1
    done
    echo "GPU: $(printf %02d "$((total / samples))")%"
done