#! /bin/bash 
##! /usr/bin/bash



if [ -d "$DATABASENAME" ];
 then
  echo "connected to $DATABASENAME database successfully .";
  databaseQueries
else
  echo "Database $DATABASENAME was not found,please check your spelling and try again.";
fi




function databaseQueries
{
while true
do
echo "choose your query";
read DMLQuery;
done
}
