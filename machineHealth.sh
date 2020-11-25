#!/bin/sh

# get the three output .csv files
CPU=/opt/usage/CPU.csv
MEM=/opt/usage/MEM.csv
DISK=/opt/usage/DISK.csv

# timestamp with european standard day-month-year_hours_minute_second
timestamp=$(date +%d-%m-%Y_%H-%M-%S)
top -bn1 | grep load | awk '{printf "'$timestamp', %.2f\n", $(NF-2)}'>>$CPU
free -m | awk 'NR==2{printf "'$timestamp',%s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'>>$MEM
df -h | awk '$NF=="/"{printf "'$timestamp', %d/%dGB (%s)\n", $3,$2,$5}'>>$DISK


