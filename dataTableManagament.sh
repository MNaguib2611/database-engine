#! /bin/bash
##! /usr/bin/bash

function listTableData()
{   
 echo "listTableData"
}


function createTable()
{
   tableName=$1;
   queryReformat=$2;
   echo "createTable"
   #echo "$tableName"
   #echo "$queryReformat"
   #echo "heree ${queryReformat[0]}"

echo "################################"    
}
function dropTable()
{
 echo "dropTable"
}


startLocation=$1;
databaseName=$2;

echo "";
echo "################################"
echo "you are now in $databaseName db";
echo "################################"
echo "";


endLoop=0
while (( $endLoop == 0 ))
do


echo "";

echo "enter you query";
echo "help -> 'h'";
echo "Exit";
echo -e "Please write your Query : \c ";
read query;
IFS=' ' read -r -a arr <<< "$query"

#echo "${y^^}"
query=${query,,}
#echo $query
#sleep 5

queryReformat=""
charDelimiter=","
 for i in "${arr[@]}"
   do
    #echo $i
    queryReformat+="$i"
    queryReformat+="$charDelimiter"
   done

#echo "heree ${arr[0]}"
queryType=${arr[0]};


case $queryType in
"create")
     syntaxTableWord=${arr[1]};
     
      if [[ $syntaxTableWord == "table" ]]
      then
         tableName=${arr[2]};
        
         if [[ $tableName ]]
         then
           #echo $queryReformat
            createTable $tableName $queryReformat
         else
          echo "-------------------------------------"
          echo "Please Check your synax and try again"
          echo "-------------------------------------"
         fi
      else
      echo "-------------------------------------"
      echo "Please Check your synax and try again"
      echo "-------------------------------------"
      fi
      


      
      ;;
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





