/*1. Установите СУБД MySQL. Создайте в домашней директории файл .my.cnf, задав в нем логин и пароль, 
# который указывался при установке.
[mysql]
user=root
password=123456*/

/* 2. Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, 
числового id и строкового name.*/
CREATE DATABASE example;
CREATE DATABASE sample;
USE example;
CREATE TABLE users (id SERIAL PRIMARY KEY, name VARCHAR(255) COMMENT 'Имя пользователя');
/*3.Создайте дамп базы данных example из предыдущего задания, 
разверните содержимое дампа в новую базу данных sample.*/

mysqldump -u root -p example > sample.sql
mysql -u root -p sample < sample.sql  
mysql -u root -p
SHOW DATABASES;
DESCRIBE sample.users;