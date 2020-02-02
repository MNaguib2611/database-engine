#! /bin/bash
##! /usr/bin/bash

function listTables
{   
   echo "Tables list"
    echo -e "###############${Brown}"
    for f in *.data
    do
      if [[ $f == "*.data" ]]
      then
        echo -e "${Red}Empty${NC}"
        continue
      else
         printf '%s\n' "${f%.data}"
    fi
    done
    echo -e "${NC}###############"
}

# function listTableData
# {   
#    echo "listTableData"
# }

 

function createTable
{
   tableName=$1;
   queryReformat=$2;
   echo "createTable"
   #echo "$tableName"
   #echo "$queryReformat"
   #echo "heree ${queryReformat[0]}"

echo "################################"    
}

function dropTable
{
 echo $1
}

 startLocation=$1;
databaseName=$2;

function currentDatabase
{
echo "";
echo "################################"
echo -e "${Green} you are now in $databaseName db ${NC}";

echo "################################"
echo "";
}

currentDatabase


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
# echo $query
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
         echo -e "${Red}Please Check your synax and try again ${NC}"
         echo "-------------------------------------"
      fi
   else
   echo "-------------------------------------"
      echo -e "${Red}Please Check your synax and try again ${NC}"
   echo "-------------------------------------"
   fi 
   ;;
"show")
   if [[ ${arr[1]} == "tables" ]]
   then
    listTables 
   else
    echo "-------------------------------------"
    echo -e "${Red}Please Check your synax and try agains ${NC}"
    echo "-------------------------------------"
   fi
   ;;

   "drop")
   if [[ ${arr[1]} == "table" ]]
   then
       tableName=${arr[2]};
       tableName+=".data";
      if [[ -f  "$tableName" ]];
      then 
          rm -f "$tableName";
          echo "------------------------"
            echo -e "${Green} ${arr[2]} table has been deleted ${NC}"
            echo "------------------------"
      else
      echo "-------------------------------------"
      echo -e "${Red}No such Table ${NC}"
      echo "-------------------------------------"
      fi
   else
    echo "-------------------------------------"
    echo -e "${Red}Please Check your synax and try agains ${NC}"
    echo "-------------------------------------"
   fi
   ;;

"h")
   . $startLocation/help.sh $startLocation
      currentDatabase
    ;;
   
"exit")
   echo "System shudown ^_^" 
   #exit
   cd $startLocation;
   endLoop=$(( endLoop+1 ))	
    ;;
*) 
   . $startLocation/design.sh
   currentDatabasee
   echo "-------------------------------------"
    echo -e "${Red}Please Check your synax and try again ${NC}"
   echo "-------------------------------------"
   ;;

esac
done





