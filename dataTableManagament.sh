#! /bin/bash
##! /usr/bin/bash

 . $startLocation/tableFunctions.sh

startLocation=$1
databaseName=$2


currentDatabase


endLoop=0
while (( $endLoop == 0 ))
do

echo -e "${LBlue}";
echo "enter you query";
echo "help -> 'h'";
echo "Home";
echo "Exit";
echo -e "Please write your Query : \c ";
read -e query;
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
   if [ $i == $charDelimiter ]
   then 
      createFormatError+=1
   else
      queryReformat+="$i"
      queryReformat+="$charDelimiter"
   fi
   done

#echo "heree ${arr[0]}"
queryType=${arr[0]}
queryType=${queryType,,}
queryPartTable=${arr[1]}
queryPartTable=${queryPartTable,,}
queryPartTableName=${arr[2]}


case $queryType in
"insertinto")
     #echo $queryReformat
     #echo $queryReformatLength
     #sleep 6
   if [[ $queryPartTable == "table" ]]
   then
      if [[ -d  "$queryPartTableName" ]]
      then 
       cd $queryPartTableName
       insertIntoTable $queryReformat $queryReformatLength


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

"create")
  if [[ $queryPartTable == "table" ]]
   then
      if [[ $queryPartTableName ]]
      then
      tableNameExist=0;        
         for d in */
         do
            if [[ $d == $queryPartTableName ]]
            then
            tableNameExist=1;
            continue
            fi
         done            

         if (( $tableNameExist != 0  ))    
         then
            echo "---------------------------"
            echo -e "${Yellow}the table already exists ${NC}"
            echo "---------------------------"
         else
            #echo $queryReformat
            if (( $createFormatError != 0  ))
            then
               echo "-------------------------------------"
               echo -e "${Red}Please Check your synax and try again ${NC}"
               echo "-------------------------------------"
            else
            createTable $queryPartTableName $queryReformat $queryReformatLength
            fi
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
   queryPartTables=${arr[1]}
   echo $queryPartTables;
   queryPartTables=${queryPartTables,,}
   if [ "$queryPartTables" = "tables" ]; then
    listTables 
   else
    echo "-------------------------------------"
    echo -e "${Red}Please Check your synax and try d agains ${NC}"
    echo "-------------------------------------"
   fi
   ;;
"select")
   tableName=${arr[2]};	
   if [[ ${arr[1]} == "from" ]] && [[  tableName ]]
   then
    if [[ -z "${arr[3]}" ]] || [[ ${arr[3]} == "where" ]]
    then
      selectFromTable $tableName ${arr[3]} ${arr[4]} ${arr[5]}  ${arr[6]}
    else
      echo "-------------------------------------"
      echo -e "${Red}Please Check your synax and try agains ${NC}"
      echo "-------------------------------------"
    fi  
   else
    echo "-------------------------------------"
    echo -e "${Red}Please Check your synax and try agains ${NC}"
    echo "-------------------------------------"
   fi
   ;;
   "delete")
     tableName=${arr[2]};	
   if [[ ${arr[1]} == "from" ]] && [[  tableName ]]
   then
   deleteFromTable ${arr[2]} ${arr[3]} ${arr[4]} ${arr[5]}  ${arr[6]}
   else
    echo "-------------------------------------"
    echo -e "${Red}Please Check your synax and try agains ${NC}"
    echo "-------------------------------------"
   fi
   ;;
"check")
 if [[ -z "${arr[2]}" ]]  
   then
   checkIfTableExists ${arr[1]}
   else
   echo "-------------------------------------"
   echo -e "${Red}Please enter the name of one database${NC}"
   echo -e "${Red}Please DO NOT use * as an argument${NC}"
   echo "-------------------------------------"
fi 
;;

"drop")
   if [[ -z "${arr[3]}" ]]  
   then
      if [[ ${arr[1]} == "table" ]]
      then
         dropTable ${arr[2]}
      else
         echo "-------------------------------------"
         echo -e "${Red}Please Check your synax and try agains ${NC}"
         echo "-------------------------------------"
      fi
   else
      echo "-------------------------------------"
      echo -e "${Red}Please enter the name of one database${NC}"
      echo -e "${Red}Please DO NOT use * as an argument${NC}"
      echo "-------------------------------------"
   fi  
   
   ;;

"h")
   . $startLocation/help.sh $startLocation
      currentDatabase
    ;;
"help")
   . $startLocation/help.sh $startLocation
      currentDatabase
    ;;    
"database")
 . $startLocation/design.sh
   currentDatabase
    ;; 
 "clear") 
   clear;
   . $startLocation/design.sh
   currentDatabase
    echo -e "${NC}"
   ;;   
 "home")
   cd ..;
   clear;
    . $startLocation/design.sh
   break;
   
   continue;
    ;;     
"exit")
   echo -e "${Red}System shudown ^_^ ${NC}" 
   #exit
   cd $startLocation;
   clear;
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
