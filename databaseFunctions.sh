function listDatabases()
{   
    #echo "pwd $PWD"
    echo -e "${LBlue} Databases :- ${NC}"
   
    for d in */
    do
      if [[ $d == "*/" ]]
      then
         echo -e "${LBlue} Empty ${NC}"
        continue
      else
         IFS='/' read -ra my_array <<< "$d"
         echo -e "${LBlue}${bold}  ${my_array[0]} ${normal} ${NC}"
    fi
    done
    
}

function connectToDatabase()
{
   databaseName=$1
   databaseNameLen=`echo -n $databaseName | wc -m`
   if [[ $databaseNameLen != 0 ]]
   then
      if [ -d "$databaseName" ];
      then
            #echo "1";
            cd $databaseName
            echo "-------------------------------"
            echo -e "${Green}  connected to $databaseName db ${NC}"
            echo "-------------------------------"
            . $startLocation/dataTableManagament.sh $startLocation $databaseName

            #ls -l 
            #sleep 5
            #echo "here now $PWD" 

      else
         #echo "0";
            echo "-----------------------------"
	    echo -e "${Red} $databaseName db does not exist ${NC}"
            echo "-----------------------------"
      fi
                 
    else
      #echo "0";
         echo "-----------------------------"
          echo -e "${Red} $ please enter database name${NC}"
         echo "-----------------------------"
    fi
}

function createDatabase()
{
   databaseName=$1
   databaseNameLen=`echo -n $databaseName | wc -m`
   if [[ $databaseNameLen != 0 ]]
   then
	#disallowing special characters in db names
   if [[ $databaseName == *['!'@#\$%^\&*()-+\.\/]* ]]; then
		echo 
		echo -e "${Red} ! @ # $ % ^ () + . -  are not allowed!${NC}"
		continue
	fi
      if [ -d "$databaseName" ];
      then
         #echo "1";
            echo "---------------------------"
           echo -e "${Red}the database already exists ${NC}"
            echo "---------------------------"

      else
         #echo "0";
            mkdir $databaseName
            echo "---------------------------"
            echo -e "${Green} $databaseName db has been created ${NC}"
            echo "---------------------------"
      fi
                 
    else
    echo "-------------------------------------"
     echo -e "${Red}Please Check your synax and try again ${NC}"
    echo "-------------------------------------"
   fi
 
}
function dropDatabase()
{    
   databaseName=$1
   databaseNameLen=`echo -n $databaseName | wc -m`
   if [[ $databaseNameLen != 0 ]]
   then
         databaseName=$1
      if [ -d "$databaseName" ];
      then
         #echo "1";
         rm -r $databaseName;
            echo "------------------------"
            echo -e "${Green}$databaseName db has been deleted ${NC}"
            echo "------------------------"

      else
         #echo "0";
            echo "------------------------------"
              echo -e "${Red} $databaseName db does not exist ${NC}"
            echo "------------------------------"
      fi
                 
    else
    echo "-------------------------------------"
   echo -e "${Red}Please Check your synax and try again ${NC}"
    echo "-------------------------------------"
   fi
}
