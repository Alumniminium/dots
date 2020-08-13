#!/bin/bash

status=$(acpi -b | cut -d ' ' -f 3 | cut -d ',' -f 1)
charge=$(acpi -b | cut -d ' ' -f 4 | cut -d ',' -f 1 | cut -d '%' -f1)
time=$(acpi -b | cut -d ' ' -f 5)

if [ "$charge" -gt 75 ]; then
    icon=""
elif [ "$charge" -gt 50 ]; then
    icon=""
elif [ "$charge" -gt 25 ]; then
    icon=""
elif [ "$charge" -gt 15 ]; then
    icon=""
else
    icon=""
fi

if [ "$status" = "Discharging" ]; then
    echo "$icon $time ($charge%) "
elif [ "$status" = "Unknown" ]; then
    echo "$icon ($charge%) "
elif [ "$status" = "Charging"]; then
    echo "$icon $time ($charge%) "
fi
