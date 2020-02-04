##! /bin/bash
#! /usr/bin/bash

startLocation=$1;
clear
. $startLocation/design.sh ;
echo "##########################################"
echo "########### wait 5 seconds  ##############"
echo "##########################################"
echo "wellcome to EngineDB managment system ^_^"
echo -e "${Green}Queries in main menu ${Yellow}"
echo "you can list all databases -> SHOW DATABASES "
echo "you can connect to database -> USE dbName "
echo "you can create database -> CREATE DATABASE dbName "
echo "you can drop database -> DROP DATABASE dbName "
echo -e "you can Exit EngineDB -> ${Red}exit${Yellow}"
echo -e "${Green}Queries while being connected to a database ${Yellow}"
echo "you can create table -> 
CREATE TABLE tableName 
( colum1Name colum1DataType notNull/Null colum2Name colum2DataType notNull/Null ,...etc) "
echo "you can insert into table -> 
INSERTINTO TABLE tableName 
( colum1Name value colum2Name value ,...etc) "
echo -e "you can go back to  main menu -> ${LBlue}home${Yellow}"
echo -e "you can Exit EngineDB -> ${Red}exit${Yellow}"
echo "##########################################"
sleep 5
