##! /bin/bash
#! /usr/bin/bash

 . $startLocation/databaseFunctions.sh



startLocation=$1;
queryType=$2;



case $queryType in
"show")
   if [[ $3 == "databases" ]]
   then
    listDatabases 
   else
    echo "-------------------------------------"
    echo -e "${Red}Please Check your synax and try again ${NC}"
    echo "-------------------------------------"
   fi
   ;;


"use") 
   if [[ -z "$4" ]]  
   then
      clear
     . $startLocation/design.sh
      connectToDatabase $3 
   else
      echo "-------------------------------------"
      echo -e "${Red}Please enter the name of one database${NC}"
      echo -e "${Red}Please DO NOT use * as an argument${NC}"
      echo "-------------------------------------"
   fi   
   ;;

"create") 
if [[ -z "$5" ]]  
   then
   if [[ $3 == "database" ]]
   then
       if [[ -z $4 ]]
       then        
         echo "-------------------------------------"
          echo -e "${Red}Please Check your synax and try again ${NC}"
         echo "-------------------------------------"        
       else
          #echo "name $4"
          createDatabase $4
       fi
          
   else
    echo "-------------------------------------"
    echo -e "${Red}Please Check your synax and try again ${NC}"
    echo "-------------------------------------"
   fi
    else
      echo "-------------------------------------"
      echo -e "${Red}Please enter the name of one database${NC}"
      echo -e "${Red}Please DO NOT use * as an argument${NC}"
      echo "-------------------------------------"
   fi   
   ;;

"drop")
 if [[ -z "$5" ]]  
   then
   if [[ $3 == "database" ]]
      then
         dropDatabase $4 
      else
      echo "-------------------------------------"
      echo -e "${Red}Please Check your synax and try again ${NC}"
      echo "-------------------------------------"
   fi
 else
    echo "-------------------------------------"
    echo -e "${Red}Please enter the name of one database${NC}"
      echo -e "${Red}Please DO NOT use * as an argument${NC}"
      echo "-------------------------------------"
 fi     
   ;;

*) 
   . $startLocation/design.sh
   echo "-------------------------------------"
   echo -e "${Red}Please Check your synax and try again ${NC}"
   echo "-------------------------------------"
   ;;
esac

