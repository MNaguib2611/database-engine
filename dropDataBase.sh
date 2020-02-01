#! /bin/bash
##! /usr/bin/bash


echo "Are you sure you want to drop $DATABASENAME database? [y/n]";
read confirm;
case $confirm in 
"y")
    rm -r $DATABASENAME;
	echo $?;
    handleDropResponse;
;;

*)
   echo "$DATABASENAME database will NOT be dropped";
;;
esac




function handleDropResponse
{
case $? in
 0)
   clear ;
 echo "Welcome To EngineDB"; 
  echo "$DATABASENAME database was dropped successfully";
 ;;

 *)
    clear ;
  echo "Welcome To EngineDB"; 
  echo "$DATABASENAME databae was NOT dropped,please try again";
  ;;

esac



}


