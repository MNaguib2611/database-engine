##! /bin/bash
#! /usr/bin/bash

Red='\033[0;31m'
Green='\033[0;32m'
Yellow='\033[1;33m'
NC='\033[0m' # No Color

function listDatabases()
{   
    #echo "pwd $PWD"
    echo ""
    echo "###############"
    for d in */
    do
      if [[ $d == "*/" ]]
      then
        echo "Empty"
        continue
      else
        echo $d
      
    fi
    done
    echo "###############"
}

function connectToDatabase()
{
    databaseName=$1

    if [ -d "$databaseName" ];
    then
         #echo "1";
         cd $databaseName
         echo "-------------------------------"
         echo -e "${Green}  connected to $databaseName db ${NC}"
         echo "-------------------------------"
         #ls -l 
         #sleep 5
         #echo "here now $PWD" 

    else
      #echo "0";
      
         echo "-----------------------------"
         echo -e "${Yellow} $databaseName db does not exist ${NC}"
         echo "-----------------------------"
    fi
}

function createDatabase()
{
    databaseName=$1

    if [ -d "$databaseName" ];
    then
      #echo "1";
         echo "---------------------------"
         echo -e "${Yellow}the database already exists ${NC}"
         echo "---------------------------"

    else
      #echo "0";
         mkdir $databaseName
         echo "---------------------------"
         echo -e "${Green} $databaseName db has been created ${NC}"
         echo "---------------------------"
    fi
}
function dropDatabase()
{
    databaseName=$1
    if [ -d "$databaseName" ];
    then
      #echo "1";
        rm -r $databaseName;
         echo "------------------------"
         echo -e "${Green} $databaseName has been deleted ${NC}"
         echo "------------------------"

    else
      #echo "0";
         echo "------------------------------"
         echo -e "${Yellow} $databaseName db doesn't exist ${NC}"
         echo "------------------------------"
    fi

}


startLocation=$1;
queryType=$2;
#queryType=$(echo $fullQuery | awk '{print $1}');
#DATABASENAME=$(echo $fullQuery | awk '{print $3}');
#echo $2;
#echo $3;



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
   connectToDatabase $3 ;;

"create") 
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
   ;;

"drop") 
  if [[ $3 == "database" ]]
   then
      dropDatabase $4 
   else
    echo "-------------------------------------"
    echo -e "${Red}Please Check your synax and try again ${NC}"
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

