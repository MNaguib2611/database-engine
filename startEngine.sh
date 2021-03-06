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
   cd $dataBaseLocation
fi


endLoop=0
while (( $endLoop == 0 ))
do

echo -e "${Green}";
echo "List Databases ";
echo "Connect to Database";
echo "Create Database ";
echo "Drop Database";
echo "Exit";
echo "help -> 'h' ";
echo -e "${LBlue}Please write your Query : \c ${NC}";

# echo $PWD;
read -e query;
#echo "${y^^}"
query=${query,,}
#echo $query
#sleep 5



echo ""
case $query in
"h")
   . $startLocation/help.sh $startLocation ;;

"clear") 
   clear;
   . $startLocation/design.sh
    echo -e "${NC}"
   ;;
"exit")
   echo -e "${Red}System shudown ^_^ ${NC}" 
   #exit
   cd $startLocation;
   clear;
   endLoop=$(( endLoop+1 ))	
    ;;

*)
   #echo $query;
   . $startLocation/dataBaseManagament.sh $startLocation $query ;;

esac
done
