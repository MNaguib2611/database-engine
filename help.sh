##! /bin/bash
#! /usr/bin/bash

startLocation=$1;
clear
. $startLocation/design.sh ;
echo "##########################################"
echo "########### wait 5 seconds  ##############"
echo "##########################################"
echo "wellcom to our database managment system ^_^"
echo "you can list all databases -> SHOW DATABASES "
echo "you can connect to database -> USE dbName "
echo "you can create database -> CREATE DATABASE dbName "
echo "you can drop database -> DROP DATABASE dbName "
echo "you can create table -> 
CREATE TABLE tableName 
( colum1Name colum1DataType notNull/Null colum2Name colum2DataType notNull/Null ,...etc) "
echo "you can insert into table -> 
INSERTINTO TABLE tableName 
( colum1Name value colum2Name value ,...etc) "
echo "##########################################"
sleep 5
