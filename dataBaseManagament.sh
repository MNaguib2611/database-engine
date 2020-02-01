#! /bin/bash
##! /usr/bin/bash

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
         echo "connected to $databaseName db "
         echo "-------------------------------"
         #ls -l 
         #sleep 5
         #echo "here now $PWD" 

    else
      #echo "0";
      
         echo "-----------------------------"
         echo "$databaseName db is not exist"
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
         echo "the database already exists"
         echo "---------------------------"

    else
      #echo "0";
         mkdir $databaseName
         echo "---------------------------"
         echo "$databaseName db is created"
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
         echo "$databaseName is deleted"
         echo "------------------------"

    else
      #echo "0";
         echo "------------------------------"
         echo "$databaseName db doesn't exist"
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
    echo "Please Check your synax and try again"
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
         echo "Please Check your synax and try again"
         echo "-------------------------------------"        
       else
          #echo "name $4"
          createDatabase $4
       fi
          
   else
    echo "-------------------------------------"
    echo "Please Check your synax and try again"
    echo "-------------------------------------"
   fi
   ;;

"drop") 
  if [[ $3 == "databases" ]]
   then
      dropDatabase $4 
   else
    echo "-------------------------------------"
    echo "Please Check your synax and try again"
    echo "-------------------------------------"
   fi
   ;;

*) 
   . $startLocation/design.sh
   echo "-------------------------------------"
   echo "Please Check your synax and try again"
   echo "-------------------------------------"
   ;;
esac

