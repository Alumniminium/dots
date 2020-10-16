#!/bin/bash
usage=$(mpstat 1 1 | awk 'END{print 100-$NF"%"}')
echo "CPU: $usage"