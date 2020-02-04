#! /bin/bash
##! /usr/bin/bash

function listTables
{   
   echo "Tables list"
    echo -e "###############${LBlue}"
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



function selectFromTable
{   
   #$1->tableName
   #$2 ->condition
   echo "select"
}
function deleteFromTable
{   
   #$1->tableName
   #$2 ->condition
   echo "Delete"
}

 

function createTable
{
   # create table tableName ( c1 text notnull , c2 int null )
   tableName=$1;
   queryReformat=$2;
   queryReformatLength=$3

   #echo $queryReformatLength
   IFS=':' read -ra ADDR <<< "$queryReformat"
   
   for i in "${ADDR[@]}"; do
     echo "$i" 
   done

   #echo "createTable"

   #echo "$tableName"
   #echo "$queryReformat"

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
queryReformatLength=0

charDelimiter=":"
createFormatError=0

 for i in "${arr[@]}"
   #echo $i
   do
   queryReformatLength=$(( queryReformatLength+1))
   if [ $i == ":" ]
   then 
      createFormatError+=1
   else
      queryReformat+="$i"
      queryReformat+="$charDelimiter"
   fi
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
         if (( $createFormatError != 0 ))
         then
            echo "-------------------------------------"
            echo -e "${Red}Please Check your synax and try again ${NC}"
            echo "-------------------------------------"
         else
         createTable $tableName $queryReformat $queryReformatLength
         fi

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
"select")
     tableName=${arr[2]};	
   if [[ ${arr[1]} == "from" ]] && [[  ${arr[3]} == "where" ]]&& [[  ${arr[4]} == "id" ]]
   then
   if [[ $tableName ]]
      then
	echo "hhhhkk"
      fi
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
"database")
 . $startLocation/design.sh
   currentDatabase
    ;;   
"exit")
   echo -e "${Red}System shudown ^_^ ${NC}" 
   #exit
   cd $startLocation;
   endLoop=$(( endLoop+1 ))	
    ;;
*) 
   . $startLocation/design.sh
   currentDatabase
   echo "-------------------------------------"
    echo -e "${Red}Please Check your synax and try again ${NC}"
   echo "-------------------------------------"
   ;;

esac
done





