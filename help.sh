##! /bin/bash
#! /usr/bin/bash

startLocation=$1;
clear
. $startLocation/design.sh ;
echo "##########################################"
echo "wellcom to our database managment system ^_^"
echo "you can list all databases -> SHOW DATABASES "
echo "you can connect to database - USE dbName> "
echo "you can create database -> CREATE DATABASE dbName "
echo "you can drop database -> DROP DATABASE dbName "
echo "##########################################"
sleep 5
