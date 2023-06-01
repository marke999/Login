#!/bin/bash

#For Logging-out

#Variables

total_lines=$(wc -l < "/home/lgucebu1/Tasks/Login/csv/logout-o.txt")
row_number=$((total_lines))

Log_Number=$(printf "%09d" "$row_number")
Logout_Date=$(date +"%Y-%m-%d")
Logout_Time=$(date +"%H:%M:%S")
Logout_Data="$Log_Number\t$USER\t$Logout_Date\t$Logout_Time\t"

#Display the results
echo "Log_Number\tUsername\tLogout_Date\tLogout_Time\t" #>> /home/lgucebu1/Tasks/Login/csv/logout-o.txt
echo "$Logout_Data"

#Import results to a csv file
echo "$Logout_Data" >> "/home/lgucebu1/Tasks/Login/csv/logout-o.txt"
echo "Row Number: $Log_Number"
