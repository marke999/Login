#!/bin/bash

#For Logging-in

[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"

#Variables

total_lines=$(wc -l < "/home/lgucebu1/Tasks/Login/csv/temp.txt")
row_number=$((total_lines))

Name="M.ARNOCO"
Log_Number=$(printf "%09d" "$row_number")
Login_Date=$(date +"%Y-%m-%d")
Login_Time=$(date +"%H:%M:%S")
Login_Data="$Log_Number\t$Name\t$Login_Date\t$Login_Time"

#Create a temporary file to store the result
temp=$(mktemp)

#Import results to a txt file
#echo "$Log_Number\t$Name\t$Login_Date\t$Login_Time" >> "/home/lgucebu1/Tasks/Login/csv/login-o.txt"
#echo "$Login_Data" >> "/home/lgucebu1/Tasks/Login/csv/login-o.txt"

#Output the result to the temporary file in TSV format
printf '%b\n' "$Login_Data" >> "/home/lgucebu1/Tasks/Login/csv/temp.txt"
#echo "$Log_Number $Name $Login_Date $Login_Time" >> "/home/lgucebu1/Tasks/Login/csv/temp.txt"
#echo "$Login_Data" >> "/home/lgucebu1/Tasks/Login/csv/temp.txt"

#[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"

#For root mode copying Login_Data to /var/lib/mysql-files
printf '%b\n' "$Login_Data" >> "/var/lib/mysql-files/login.txt"
#echo "$Log_Number $Name $Login_Date $Login_Time" >> "/var/lib/mysql-files/login.txt"
#echo "$Login_Data" >> "/var/lib/mysql-files/login.txt"

#Use the mysql command-line tool to insert the data into MySQL including the password
mysql -u root -pP@ssw0rd# DB_Test2 <<EOF
LOAD DATA INFILE '/var/lib/mysql-files/login.txt'
INTO TABLE login
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
EOF

#Display the results
echo "Log_Number\tUsername\tLogin_Date\tLogin_Time" #>> /home/lgucebu1/Tasks/Login/csv/login-o.txt
echo "$Login_Data"

#Delete the content of temp.txt to avoid duplicating primary key in MySQL
echo "" > '/var/lib/mysql-files/login.txt'
