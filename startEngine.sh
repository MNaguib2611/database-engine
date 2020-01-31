#! /usr/bin/bash


echo "";
echo "***********************************************************************************";
echo "***********************************************************************************";
echo "***********************************************************************************";
echo "***********************************************************************************";
echo "***********************************************************************************";
echo "**********  Welcome To EngineDB  **********";
echo "";



while true 
do
echo "";
echo " list databases ";
echo " create database ";
echo " connect to database";
echo " drop database";
echo " exit"

echo "Please write your Query : ";


read fullQuery;
queryType=$(echo $fullQuery | awk '{print $1}');
DATABASENAME=$(echo $fullQuery | awk '{print $3}');
case $queryType in
"list")
 . /home/$LOGNAME/bashScriptProject/listDataBases.sh;
;;

"create") 
	if test -z "$DATABASENAME"
	then
	   echo "Syntax error -it should be => create database (Database name here)";    
	 
	else
            . /home/$LOGNAME/bashScriptProject/createDataBase.sh ;  
	fi
 
;;

"connect") 
clear ;   
 if test -z "$DATABASENAME"
	then
	 echo "Syntax error -it should be  => connect to (Database name here)";       
	  
	else
           . /home/$LOGNAME/bashScriptProject/connectToDataBase.sh ;
	fi
;;

"drop") 
 clear ;   
if test -z "$DATABASENAME"
	then
	   echo "Syntax error -it should be =>  drop database (Database name here)";   	  
	else
           . /home/$LOGNAME/bashScriptProject/dropDataBase.sh ;
	fi
;;

"exit")  
  echo " bye...";	
  echo "Exiting ................";
	break
;;

*) 
 clear ; 
echo "**********  Welcome To EngineDB  **********";
  echo "Please Check your synax and try again";
;;

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
