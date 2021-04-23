#!/bin/bash
# assignment.sh
#
# Author: Group 7
# Date: 17-Jul-2020 to 26-jul-2020
#

#FUNC CHOICE
function choice() {
	if [ "$VAR" == 1 ];then
		menu_1	
	elif [ "$VAR" == 2 ];then
		menu_2
	elif [ "$VAR" == 3 ];then
		menu_3
	elif [ "$VAR" == "q" ] || [ "$VAR" == "Q" ];then
		exit 0
	else
		echo "Plese enter valid value! "
		y_n 
	fi
}

#FUNC_YES_NO
function y_n() {
	printf "Press 'Y' to continue the program or 'N' to go out of the program $ "
	read input
	if [ "$input" == "y"  ] || [ "$input" == "Y" ];then
	./assignment.sh
	elif [ "$input" == "n" ] || [ "$input" == "N" ];then
	exit 1
	fi
}

#MENU1
function menu_1 () {

	#VAR
	nowCE="$(date +'%m/%d/%Y')" #สร้าง format options เพื่อแสดงเดือนวันปี แล้วใส่ค่าไปยังตัวแปรชื่อ nowCE
	yearCE="$(date +'%Y')" #สร้าง format options เพื่อแสดงปี แล้วใส่ค่าไปยังตัวแปรชื่อ yearCE
	yearBE="$(($yearCE + 543))" #ทำการแปลงปีใน ค.ศ. to พ.ศ.
	dm="$(date +'%d/%m/')" #สร้าง format options เพื่อแสดงวันเดือน แล้วใส่ค่าไปยังตัวแปรชื่อ dm
	nowBE="$dm$yearBE" #concatenate ตัวแปรระหว่าง dm กับ nowBE 

	#OUTPUT
    echo " -------------------- MENU1 --------------------"
	echo "|Current date in Common Era(C.E.): $nowCE   |"
	echo "|Current date in Buddhist Era(B.E.): $nowBE |"
	echo " -----------------------------------------------"

	#FUNC CHOICE
	y_n
}

#MENU2
function menu_2 () {

	#OUTPUT
    printf " ---------------------------- MENU2 -----------------------------\n"
	printf "This is your current path: $(pwd)\n"
	echo
	printf "This is all files and folders in this path: "
	ls	#list file and folder
	echo
	printf "What is path or folder you want to go for move files? $ "
	read inputPath	#รับ inputPath จากผู้ใข้
	cd $inputPath	#change directory ไปยังโฟลเดอร์หรือpathที่ต้องการ
	touch test.txt test1.txt  #คำสั่งในการสร้างไฟล์ ใช้ในการเทส
	echo
	printf "This is all files in this folder: "
	ls
	echo 
	printf "Press 'Y' to move all your files to parant directory or Press 'N' to go to the menu $ "
	read input	#รับ input จากผู้ใช้งาน
	if [ "$input" == "y"  ] || [ "$input" == "Y" ];then
	echo
	echo "Your all files is moved!"
	echo
	mv * ~/	#moving all files to parent directory
	cd ~/
	./assignment.sh
	elif [ "$input" == "n" ] || [ "$input" == "N" ];then
	cd ~/
	./assignment.sh		#รันไฟล์ตัวโปรแกรมอีกครั้ง
	fi
	printf " ---------------------------------------------------------------\n"
}

#MENU3
function menu_3 () {

	#OUTPUT
	printf " ---------------------------- MENU3 -----------------------------\n"
	n1=$[($RANDOM % 100) +1]	#สร้าง random numver ระหว่าง 1-100 เก็บไว้ในตัวแปร n1
	guesses=1	#ตัวแปรในการนับค่าว่า เดา ตัวเลขไปกี่ครั้ง
	echo -n "I'm thinking of a number between 1 and 100. Your guess:"

	while read n2; do	#loop รับค่า input จากผู้ใช้จนกว่าจะทายตัวเลขถูก

	if [[ $n2 -eq $n1 ]]; then	#ถ้าทายถูก ก็จะ break และหลุดออกจากลูป
	break;  
	else
	echo    
	if [[ $n2 -gt $n1 ]]; then 	#ถ้าทายผิด ก็จะต้องเดาใหม่
	echo -n "Sorry, your guess is too high. New guess:"
	elif [[ $n2 -lt $n1 ]]; then
	echo -n "Sorry, your guess is too low. New guess:"
	fi      
	fi
	guesses=$((guesses+1))	#ตัวแปรเพิ่มค่าในการ เดา ตัวเลขไปกี่ครั้ง

	done
	echo " "
	echo "Good job! It took you $guesses guesses to get the right number. "
	echo " "

	#FUNC CHOICE
	y_n
	printf " ---------------------------------------------------------------\n"
}

#FUNC RUN
function run() {
	#MENU
	echo "************ Welcome to Awesome Menu *******************"
	echo "Plese select the menu is what you want to use it!"
	echo -e "\e[37;1;41m 1 - Show Date \e[0m"	# -e คือ flag option ของ echo ในการแสดงตกแต่งสีบนข้อความ
	echo -e "\e[37;1;42m 2 - Move Files \e[0m"
	echo -e "\e[37;1;44m 3 - Guest Number \e[0m"
	echo " 4 - Press q to quite"
	echo "Enter your choice and press return: "

	#INPUT
	read VAR

	#FUNC CHOICE
	choice
}

#RUN FUNC
####
run 
####
