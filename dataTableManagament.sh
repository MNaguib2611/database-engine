#! /bin/bash
##! /usr/bin/bash

function listTableData()
{   
 echo "listTableData"
}


function createTable()
{
 echo "createTable"
    
}
function dropTable()
{
 echo "dropTable"
}


startLocation=$1;
databaseName=$2;



endLoop=0
while (( $endLoop == 0 ))
do

echo "";
echo "################################"
echo "you are now in $databaseName db";
echo "################################"
echo "";
echo "";

echo "enter you query";
echo "help -> 'h'";
echo "Exit";
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

"exit")
   echo "System shudown ^_^" 
   #exit
   endLoop=$(( endLoop+1 ))	
    ;;
*) 
   . $startLocation/design.sh
   echo "-------------------------------------"
   echo "Please Check your synax and try again"
   echo "-------------------------------------"
   ;;

esac
done





