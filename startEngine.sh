##! /bin/bash
#! /usr/bin/bash


. ./colors.sh


startLocation=$PWD
export startLocation;
#to print the word Engine DB
. ./design.sh

#to create "main dir" for the project it will contain all DBs & tables 
cd $Home;
dataBaseLocation="DBScript"
if [[ -e $dataBaseLocation ]]
then 
   cd $dataBaseLocation;
   echo -e "################################# welcome Back ################################${NC}";
else
   mkdir $dataBaseLocation;
   echo -e "### welcome ###${NC}";
fi


endLoop=0
while (( $endLoop == 0 ))
do

echo "";
echo "List Databases ";
echo "Connect to Database";
echo "Create Database ";
echo "Drop Database";
echo "Exit";
echo "help -> 'h'";
echo -e "Please write your Query : \c ";


read query;
#echo "${y^^}"
query=${query,,}
#echo $query
#sleep 5



echo ""
case $query in
"h")
   . $startLocation/help.sh $startLocation ;;

"clear") 
   . $startLocation/design.sh
   ;;
"exit")
   echo -e "${Red}System shudown ^_^ ${NC}" 
   #exit
   cd $startLocation;
   endLoop=$(( endLoop+1 ))	
    ;;

*)
   #echo $query;
   . $startLocation/dataBaseManagament.sh $startLocation $query ;;

esac
done











#note 
#(list)  to list all databases
#create database (iti)  to create a new database
# connect to (iti)      to connect to iti database
# drop database         to drop iti database
# exit    to exit the database engine
#
#

