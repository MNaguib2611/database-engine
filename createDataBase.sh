#! /usr/bin/bash



mkdir $DATABASENAME

case $? in
 0)
   clear ;
 echo "Welcome To EngineDB"; 
  echo "$DATABASENAME database was created successfully";
 ;;

 *)
    clear ;
  echo "Welcome To EngineDB"; 
  echo "$DATABASENAME database was NOT created";
  ;;

esac
