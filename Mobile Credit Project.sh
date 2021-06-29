#!/bin/bash

menufx()
{
	clear
	echo "Welcome to Mobile Credit Top-Up System"
	echo "==================================================================================="
	printf "Menu: \n\n1. Info \n2. Topup \n3. Mobile Data \n4. Addon \n5. Quit\n\n"
	read -p "Select : " menu
	echo "==================================================================================="
	case "$menu" in
	1) infofx;;
	2) topupfx;;
	3) datafx;;
	4) addonfx;;
	5) exit 1;;
	*) echo "Sorry, invalid input"
	sleep 1
	menufx
	esac
}

infofx()
{
	clear
	echo "==================================================================================="
	printf "Balance\t\t: RM$total_balance \nData balance\t: $data_balance Gb \nActive plan\t: $active_plan \n"
	if [ $high_speed -gt 0 ]
	then
	    printf "Addon package\t: $addon_set\n\n"
	fi
	printf "\n0. Return \n00. Quit\n"
	read -p "Select : " menu
	echo "==================================================================================="
	case "$menu" in
	0) menufx;;
	00) exit 1;;
	*) echo "Sorry, invalid input"
	sleep 2
	infofx
	esac
}

topupfx()
{
	clear
	a="RM 5"
	b="RM 10"
	c="RM 50"
	echo "Topup Balance"
	echo "==================================================================================="
	printf "Menu: \n\n1. $a \n2. $b \n3. $c \n\n0. Return \n00. Quit\n"
	read -p "Select : " menu

	case "$menu" in
	1) echo "Confirm purchase $a ? (Y/N)"
	read -p "Select : " confirm
	echo "==================================================================================="
	if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]
	then
		total_balance=$(($total_balance + 5))
		awk 'BEGIN { print '$total_balance' "\n" '$data_balance'}' > $database
		printf "Successful purchase."
        	sleep 2
        	infofx
	else
		 echo "Unsuccessful"
		 sleep 2
		 topupfx
	fi;;
	2) echo "Confirm purchase $b ? (Y/N)"
	read -p "Select : " confirm
	echo "==================================================================================="
	if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]
	then
		total_balance=$(($total_balance + 10))
        	awk 'BEGIN { print '$total_balance' "\n" '$data_balance'}' > $database
		printf "Successful purchase."
        	sleep 2
        	infofx
	else
		 echo "Unsuccessful"
		 sleep 2
		 topupfx
	fi;;
	3) echo "Confirm purchase $c ? (Y/N)"
	read -p "Select : " confirm
	echo "==================================================================================="
	if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]
	then
		total_balance=$(($total_balance + 50))
	    	printf "Successful purchase."
        	awk 'BEGIN { print '$total_balance' "\n" '$data_balance'}' > $database
		sleep 2
        	infofx
	else
		echo "Unsuccessful"
		sleep 2
		topupfx
	fi;;
	0) menufx;;
	00) exit 1;;
	*) echo "Sorry, invalid input"
	topupfx
	esac
}

datafx()
{
	clear
	data=0
	balance=0
	a="RM 50 : 13 Gb/30days"
	b="RM 10 : 4 Gb/7days"
	c="RM 5 : 2 Gb/24hours"
	echo "Mobile Data"
	echo "==================================================================================="
	printf "Menu: \n\n1. $a \n2. $b \n3. $c \n\n0. Return \n00. Quit\n"
	read -p "Select : " menu

	case "$menu" in
	1) echo "Confirm purchase $a ? (Y/N)"
	read -p "Select : " confirm
	echo "==================================================================================="
	if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]
	then
		data_balance=$(($data_balance + 13))
		total_balance=$(($total_balance - 50))
		active_plan=$a
		awk 'BEGIN { print '$total_balance' "\n" '$data_balance'}' > $database
		cat $database
		echo "Successful purchase."
		sleep 10
		infofx
	else
		echo "Unsuccessful."
		sleep 2
		datafx
	fi;;
	2) echo "Confirm purchase $b ? (Y/N)"
	read -p "Select : " confirm
	echo "==================================================================================="
	if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]
	then
		data_balance=$(($data_balance + 4))
		total_balance=$(($total_balance - 10))
		active_plan=$b
		awk 'BEGIN { print '$total_balance' "\n" '$data_balance'}' > $database
		echo "Successful purchase."
		sleep 2
		infofx
	else
		echo "Unsuccessful."
		sleep 2
		datafx
	fi;;
	3) echo "Confirm purchase $c ? (Y/N)"
	read -p "Select : " confirm
	echo "==================================================================================="
	if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]
	then
		data_balance=$(($data_balance + 2))
		total_balance=$(($total_balance - 5))
		active_plan=$c
		awk 'BEGIN { print '$total_balance' "\n" '$data_balance'}' > $database
    		printf "Successful purchase."
    		sleep 2
    		infofx
	else
		echo "Unsuccessful."
		sleep 2
		datafx
	fi;;
	0) menufx;;
	00) exit 1;;
	*) echo "Sorry, invalid input"
	datafx
	esac
}

addonfx()
{
        clear
        addon_A="RM1: 2GB (Addon)"
		A2="1hour \nHotspot not allowed \n"
        addon_B="RM3: 5GB (Addon)"
		B2="24hours \nHotspot allowed \n"
        addon_C="RM10: 15GB (Addon)"
		C2="5days \nHotspot allowed \nFree call + SMS"
        echo "Add-on Internet High Speed"
        echo "================================================================================"
        printf "Add-on: \n1. $addon_A \n$A2 \n2. $addon_B \n$B2 \n3. $addon_C \n$C2 \n\n0. Return \n00. Quit\n"
        read -p "Select:" addon

        case "$addon" in
        1) echo "Confirm purchase $addon_A ? (Y/N)"
        read -p "Select: " confirm
        echo "================================================="
        if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]
        then
                high_speed=$(($high_speed + 2))
                total_balance=$(($total_balance - 1))
                addon_set=$addon_A
       		awk 'BEGIN { print '$total_balance' "\n" '$data_balance'}' > $database
                printf "Successful purchase."
    		    sleep 2
                infofx
        else
                echo "Unsuccessful"
		        sleep 2
                addonfx
        fi;;
		2) echo "Confirm purchase $addon_B ? (Y/N)"
        read -p "Select: " confirm
        echo "=================================================="
        if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]
        then
                high_speed=$(($high_speed + 5))
                total_balance=$(($total_balance - 3))
                addon_set=$addon_B
		awk 'BEGIN { print '$total_balance' "\n" '$data_balance'}' > $database
                printf "Successful purchase."
    		    sleep 2
                infofx
        else
                echo "Unsuccessful"
		        sleep 2
                addonfx
        fi;;
        3) echo "Confirm purchase $addon_C ? (Y/N)"
        read -p "Select: " confirm
        echo "=================================================="
        if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]
        then
                high_speed=$(($high_speed + 15))
                total_balance=$(($total_balance - 10))
                addon_set=$addon_C
		awk 'BEGIN { print '$total_balance' "\n" '$data_balance'}' > $database
                printf "Successful purchase."
    		    sleep 2
                infofx
        else
                echo "Unsuccessful"
		        sleep 2
                addonfx
        fi;;
        0) menufx;;
        00) exit 1;;
        *) echo "Sorry, invalid input"
        addonfx
        esac
}

#main
database="database.txt"
total_balance=50
data_balance=10
active_plan="None"
high_speed=0
addon_set="None"
awk 'BEGIN { print '$total_balance' "\n" '$data_balance'}' > $database
menufx