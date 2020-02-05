#! /bin/bash
##! /usr/bin/bash

function listTables
{   
   echo "Tables list"
    echo -e "${Yellow}###############${LBlue}"
    echo -e "${Green} Tables :- ${NC}"
   for d in */
    do
      if [[ $d == "*/" ]]
      then
        echo -e "${Red}Empty"
        continue
      else
      IFS='/' read -ra my_array <<< "$d"
         echo -e "${Green} ${bold} ${my_array[0]} ${normal}"
    fi
    done
    echo -e "${Yellow}###############${NC}"
}

function checkIfTableExists
{   
   if [ -d "$1/" ]
      then
      echo -e "${Green} $1 Table Exists${NC}";
      #do nothing 
      else
        echo -e "${Red}No such Table ${NC}";
        continue;
   fi   
}

function selectFromTable
{    
  conditionWh=$2;
   if [[ -z "$2" ]] 
   then
    checkIfTableExists $1;
   clear;
   . $startLocation/design.sh
   currentDatabase
   cut -f1 -d: "$1/meta.txt" | paste -sd '\t'
   awk  '{print NR  ,$0}' "$1/data.txt";
    echo -e "${NC}"
   else
    echo -e "${Yellow}"
      if [ "$2" = "where" ]&&[ "$3" = "linenumber" ]&&[ -n "$4" ]&&[ -n "$5" ]; then
      case $5 in 
         +([0-9]))
            case $4 in 
               "<")
                cut -f1 -d: "$1/meta.txt" | paste -sd '\t'
               awk -v var="$5" '{if(NR<var)print NR,$0}'   "$1/data.txt";
               ;;
               ">")
                cut -f1 -d: "$1/meta.txt" | paste -sd '\t'
               awk -v var="$5" '{if(NR>var)print NR,$0}'   "$1/data.txt";
               ;;
               "=")
                cut -f1 -d: "$1/meta.txt" | paste -sd '\t'
               awk -v var="$5" '{if(NR==var)print NR,$0}'   "$1/data.txt";
               ;;
               *)
               echo -e "${Red}Please enter a valid comparison operator${NC}"
               ;;
            esac
         ;;
         *)
           echo -e "${Red}Please enter a valid number${NC}"
         ;;
      esac
      
      else
      echo -e "${Red}Please Check your synax and try again ${LBlue} (h)help${NC}"
      fi 
   fi 
}
function deleteFromTable
{    
  conditionWh=$2;
   if [[ -z "$2" ]] 
   then
    checkIfTableExists $1;
   clear;
   . $startLocation/design.sh
   currentDatabase
   awk  '{delete}' "$1/data.txt";
   sed -i '1,$d' "$1/data.txt";
    echo -e "${Green} $1 table has been emptied ${NC}"
   else
    echo -e "${Yellow}"
      if [ "$2" = "where" ]&&[ "$3" = "linenumber" ]&&[ -n "$4" ]&&[ -n "$5" ]; then
      case $5 in 
         +([0-9]))
            case $4 in 
               "<")
               sed -i "1,$5d" "$1/data.txt";
               echo -e "${Green} $1 table has been updated ${NC}"
               ;;
               ">")
                sed -i "$5,$ d" "$1/data.txt";
                echo -e "${Green} $1 table has been updated ${NC}"
               ;;
               "=")
                  sed -i "$5d" "$1/data.txt";
                  echo -e "${Green} $1 table has been updated ${NC}"
               ;;
               *)
               echo -e "${Red}Please enter a valid comparison operator${NC}"
               ;;
            esac
         ;;
         *)
           echo -e "${Red}Please enter a valid number${NC}"
         ;;
      esac
      
      else
      echo -e "${Red}Please Check your synax and try again ${LBlue} (h)help${NC}"
      fi 
   fi 
}

 

function createTable
{
   # create table tableName ( c1 text notNull c2 int Null c3 text notNull c4 int Null )
   # create table tableName55 ( c1 text notNull c2 int Null c3 text notNull c4 int Null )
   # create table tableName3 ( c1 text notNull c2 int Null c3 text notNull c4 int Null )
   # create table * ( c1 text notNull c2 int Null c3 text notNull c4 int Null )
   # create table # ( c1 text notNull c2 int Null c3 text notNull c4 int Null )

   ableName=$1;
   case $tableName in 
   +([[:alnum:]]))
      echo ""
   ;;
   *) 
   echo -e "${Red} ! @ # $ % ^ () + . -  are not allowed!${NC}"
		continue
   ;;  
   esac
   queryReformat=$2;
   queryReformatLength=$3

   IFS=':' read -ra ADDR <<< "$queryReformat"
   checkFormat=4
   if [[ ${ADDR[3]} == "(" ]]
    then 
    loopend=$(( queryReformatLength-1 ))
    for ((i = 4; i < $loopend ;));
     do 
     i=$(( i+1 ))
     checkFormat=$(( checkFormat+1 ))
     if [ "${ADDR[i]}" = "int" ] || [ "${ADDR[i]}" = "text" ]
     then
         i=$(( i+1 ))
         checkFormat=$(( checkFormat+1 ))
         if [ "${ADDR[i]}" = "notNull" ] || [ "${ADDR[i]}" = "Null" ]
         then
         i=$(( i+1 ))
         checkFormat=$(( checkFormat+1 ))
         
         else
            echo "-------------------------------------"
            echo -e "${Red}Please Check your synax and try again ${NC}"
            echo "-------------------------------------" 
         fi

     else
       echo "-------------------------------------"
       echo -e "${Red}Please Check your synax and try again ${NC}"
       echo -e "${Red}Hint : maybe forget '(' ${NC}"
       echo "-------------------------------------" 
     fi
    
     done

   if (( $checkFormat == $loopend ))    
      then
         if [[ ${ADDR[loopend]} == ")" ]]
         then 
            if [ -d "$tableName" ];
               then
                  echo "---------------------------"
                  echo -e "${Yellow}the table already exists ${NC}"
                  echo "---------------------------"

               else
                  #echo "done"
                  mkdir $tableName
                  cd $tableName
                  touch data.txt 
                  touch meta.txt 
                  chmod +wrx *.txt
                  

   # create table tableName ( c1 text notNull c2 int Null c3 text notNull c4 int Null )
   # create table tableName2 ( c1 text notNull c2 int Null c3 text notNull c4 int Null )
   # create table tableName3 ( c1 text notNull c2 int Null c3 text notNull c4 int Null )
   
                  for ((i = 4; i < $loopend ;));
                  do 
                 
                 
                  echo  "${ADDR[$i]}:${ADDR[$((i+1))]}:${ADDR[$((i+2))]} " >> meta.txt
                  i=$(( i+3 ))
                  done

                  cd ..
                  echo "---------------------------"
                  echo -e "${Green} $tableName table has been created ${NC}"
                  echo "---------------------------"                
               fi
                     

         else
            echo "-------------------------------------"
            echo -e "${Red}Please Check your synax and try again ${NC}"
            echo -e "${Red}Hint : maybe forget ')' ${NC}"
            echo "-------------------------------------"
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

}

function dropTable
{
 if [[ -d  "$queryPartTableName" ]]
      then 
          rm -rf "$1";
          echo "------------------------"
            echo -e "${Green} $1 table has been deleted ${NC}"
            echo "------------------------"
      else
      echo "-------------------------------------"
      echo -e "${Red}No such Table ${NC}"
      echo "-------------------------------------"
      fi
}

function insertIntoTable
{   
queryReformat=$1 
queryReformatLength=$2
echo $queryReformat
echo $queryReformatLength

while IFS= read -r line
do
  echo "$line"
done < meta.txt

}



startLocation=$1;
databaseName=$2;

function currentDatabase
 {
   echo "";
   echo "################################"
   echo -e "${Green} you are now in $databaseName db ";

   echo -e "${Yellow}################################"
   echo "";
 }

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
   selectFromTable ${arr[2]} ${arr[3]} ${arr[4]} ${arr[5]}  ${arr[6]}
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
   checkIfTableExists ${arr[1]}
;;

"drop")
   if [[ ${arr[1]} == "table" ]]
   then
      dropTable ${arr[2]}
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
   currentDatabasee
   echo "-------------------------------------"
    echo -e "${Red}Please Check your synax and try again ${NC}"
   echo "-------------------------------------"
   ;;

esac
done
