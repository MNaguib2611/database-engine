##! /bin/bash
#! /usr/bin/bash


startLocation=$1;
clear
. $startLocation/design.sh ;
echo "##########################################"
echo "########### wait 5 seconds  ##############"
echo "##########################################"
echo "${LBlue}wellcome to EngineDB managment system ^_^"
echo -e "${Green}${bold}[ QUERIES IN MAIN MENU ]${normal}${Yellow}"
echo "you can list all databases -> SHOW DATABASES "
echo "you can connect to database -> USE dbName "
echo "you can create database -> CREATE DATABASE dbName "
echo "you can drop database -> DROP DATABASE dbName "
echo -e "you can Exit EngineDB -> ${Red}exit${Yellow}"
echo -e "${Green}${bold}[ QUERIES WHILE BEING CONNECTED TO A DATABASE ]${normal}${Yellow}"
echo "you can list all tables -> SHOW TABLES "
echo "you can check if a table exists -> check tableName "
echo "you can select from a table -> 
SELECT FROM  tableName 
SELECT FROM  tableName WHERE linenumber (<,>,=) int"
echo "you can delete from a table -> 
DELETE FROM  tableName 
DELETE FROM  tableName WHERE linenumber (<,>,=) int"
echo "you can create table -> 
CREATE TABLE tableName 
( colum1Name colum1DataType notNull/Nul colum2Name colum2DataType notNull/Nul ,...etc) "
echo "you can insert into table -> 
INSERTINTO TABLE tableName 
( colum1Name value colum2Name value ,...etc) "
echo "you can drop a table-> DROP TABLE tableName "
echo -e "you can go back to  main menu -> ${LBlue}home${Yellow}"
echo -e "you can Exit EngineDB -> ${Red}exit${Yellow}"
echo "##########################################"
sleep 5
