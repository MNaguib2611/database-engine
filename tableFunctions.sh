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
   re="+([0-9])"   
  conditionWh=$2;
   if [[ -z "$2" ]] 
   then
    checkIfTableExists $1;
   clear;
   . $startLocation/design.sh
   currentDatabase
   # cut -f1 -d: "$1/meta.txt" | paste -sd '\t'
    awk -F: 'BEGIN{print "#"} {print "\t"$1}' "$1/meta.txt" | paste -sd '\t'
   awk -F: '{print NR  "\t\t"$2"\t\t"$4"\t\t"$6"\t\t"$8"\t\t"$10"\t\t"$12"\t\t"$14"\t\t"$16"\t\t"}' "$1/data.txt";
    echo -e "${NC}"
   else
    echo -e "${Yellow}"
      if [ "$2" = "where" ]&&[ "$3" = "linenumber" ]&&[ -n "$4" ]&&[ -n "$5" ]; then
      case $5 in 
         $re )
            case $4 in 
               "<")
                awk -F: 'BEGIN{print "#"} {print "\t"$1}' "$1/meta.txt" | paste -sd '\t'
                awk -F: -v var="$5" '{if(NR<var)print NR  "\t\t"$2"\t\t"$4"\t\t"$6"\t\t"$8"\t\t"$10"\t\t"$12"\t\t"$14"\t\t"$16"\t\t"}'   "$1/data.txt";
               ;;
               ">")
                awk -F: 'BEGIN{print "#"} {print "\t"$1}' "$1/meta.txt" | paste -sd '\t'
                awk -F: -v var="$5" '{if(NR>var)print NR  "\t\t"$2"\t\t"$4"\t\t"$6"\t\t"$8"\t\t"$10"\t\t"$12"\t\t"$14"\t\t"$16"\t\t"}'   "$1/data.txt";
               ;;
               "=")
                awk -F: 'BEGIN{print "#"} {print "\t"$1}' "$1/meta.txt" | paste -sd '\t'
                awk  -F: -v var="$5" '{if(NR==var)print NR  "\t\t"$2"\t\t"$4"\t\t"$6"\t\t"$8"\t\t"$10"\t\t"$12"\t\t"$14"\t\t"$16"\t\t"}'   "$1/data.txt";
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
   sed -i "1,$ d" "$1/data.txt";
   sed -i '1,$d' "$1/data.txt";
    echo -e "${Green} $1 table has been emptied ${NC}"
   else
    echo -e "${Yellow}"
      if [ "$2" = "where" ]&&[ "$3" = "linenumber" ]&&[ -n "$4" ]&&[ -n "$5" ]; then
      case $5 in 
         $re)
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
   # create table tableName ( c1 text notNull c2 int Nul c3 text notNull c4 int Nul )
   # create table tableName55 ( c1 text notNull c2 int Nul c3 text notNull c4 int Nul )
   # create table tableName3 ( c1 text notNull c2 int Nul c3 text notNull c4 int Nul )
   # create table * ( c1 text notNull c2 int Nul c3 text notNull c4 int Nul )
   # create table t ( c1 text notNull c2 int Nul c3 text notNull c4 int Nul )

  tableName=$1;
   if [[ $tableName == *['!'@#\$%^\&*()-+\.\/]* ]]; then
		echo 
		echo -e "${Red} ! @ # $ % ^ () + . -  are not allowed!${NC}"
		continue
	fi
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
         if [ "${ADDR[i]}" = "notNull" ] || [ "${ADDR[i]}" = "Nul" ]
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
                  

   # create table tableName ( c1 text notNull c2 int Nul c3 text notNull c4 int Nul )
   # create table tableName2 ( c1 text notNull c2 int Nul c3 text notNull c4 int Nul )
   # create table tableName3 ( c1 text notNull c2 int Nul c3 text notNull c4 int Nul )
   # create table t ( c1 text notNull c2 int Nul c3 text notNull c4 int Nul )
   
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
            echo -e "${Red}Hint : maybe you forgot ')' ${NC}"
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
   # insertinto table tableName c4 5 c1 "hi" c2 1  error c3 not found 
   # insertinto table tableName c4 5 c1 5 c2 1 c3 6  insertion done
   # insertinto table tableName c1 "hi" c2 "1" c3 "5" c4 "5" error datatype
   # insertinto table tableName c1 "hi" c2 1 c3 "bye"  add null
   # insertinto table tableName c1 "hi" c3 "5"  add null
   # insertinto table tt c1 "hi" c2 5 c3 "bye" c4 5  done
   echo ""
   echo -e "${Yellow}##############"
   echo "inserting ..."
   queryReformat=$1 
   queryReformatLength=$2

   metadata=""
   charDelimiter=":"
   nullVar="Nul "
   numFormatLines=0
   
   checkDoInsertion=0
   foundCloumCheck=0
   insertedRow=""
   
   re='^[0-9]+([.][0-9]+)?$'

   while IFS= read -r line
   do
   metadata+="$line"
   metadata+=":"
   numFormatLines=$(( numFormatLines+1 ))
   done < meta.txt


   IFS=$charDelimiter read -ra queryReformatArray <<< "$queryReformat"
   IFS=$charDelimiter read -ra metadataArray <<< "$metadata"



   var=0
   for (( i = 0; i < $numFormatLines ;i++ ));
   do 
      insertedRow+=${metadataArray[$((var))]}
      insertedRow+=$charDelimiter
     
      for (( j = 3; j < $queryReformatLength ; ))
      do  
      
      if [[ ${metadataArray[$((var))]} == ${queryReformatArray[$((j))]} ]]
      then
         foundCloumCheck=$((foundCloumCheck+1))

         if [[ ${metadataArray[$(( var+1 ))]} == "int" ]]
         then
            if ! [[ ${queryReformatArray[$((j+1))]} =~ $re ]] 
            then
               echo -e "${Red}DataType Error so NotInserted" 
               checkDoInsertion=$((checkDoInsertion+1))
            else
               insertedRow+=${queryReformatArray[$((j+1))]}
               insertedRow+=$charDelimiter
            fi
         else
         insertedRow+=${queryReformatArray[$((j+1))]}
         insertedRow+=$charDelimiter
         fi  
      fi
      
      j=$((j+2))
      done

      if [[ ${foundCloumCheck} == 0 ]]
       then
       echo "${metadataArray[$((var+2))]} $nullVar"
         if [[ ${metadataArray[$((var+2))]} == $nullVar ]]
         then
           insertedRow+=$nullVar
           insertedRow+=$charDelimiter
          else
            echo -e "${Red}Missing data ${metadataArray[$((var))]} nnn ${metadataArray[$((var+2))]} "
            checkDoInsertion=$((checkDoInsertion+1))
         fi
    
      fi
      var=$(( var+3 )) 
      foundCloumCheck=0
   done

   if [[ $checkDoInsertion == 0 ]]
   then
     echo $insertedRow >> data.txt  
     echo -e "${Green}Data has been Inserted"  
     else
     echo -e "${Red}Insertion Error${NC}"  
   fi
   
   echo -e "${Yellow}##############${NC}"
   echo ""
   
   cd ..

}

function currentDatabase
 {
   echo ""
   echo -e "${Yellow}################################"
   echo -e "${Green} you are now in $databaseName db "

   echo -e "${Yellow}################################"
   echo ""
 }
