#! /bin/bash
##! /usr/bin/bash

 

ls -d */ 

case $? in
 0)
   clear ;
  echo "Welcome To EngineDB.";
  echo "Listing all databases."; 
  ls -d */ 
 ;;

 *)
    clear ;
  echo "No databases exists."; 
  ;;

esac
