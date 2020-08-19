#!/bin/bash
echo "CPU: $(printf %02d "$(top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}')")%"