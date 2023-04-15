/*1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.*/
CREATE DATABASE shop;
USE shop;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id)
) COMMENT = 'Заказы';

INSERT INTO orders VALUES
  (DEFAULT, 1, DEFAULT, DEFAULT),
  (DEFAULT, 1, DEFAULT, DEFAULT),
  (DEFAULT, 2, DEFAULT, DEFAULT);

INSERT INTO users VALUES
  (DEFAULT, 'alex73', '1982-10-11', NOW(), NOW()),
  (DEFAULT, 'admin', '1990-01-01', NOW(), NOW()),
  (DEFAULT, 'third client', '1990-01-01', NOW(), NOW())
  
  
SELECT u.name
FROM users AS u
INNER JOIN orders AS o ON (o.user_id = u.id)
GROUP BY u.name
HAVING COUNT(o.id) > 0


/* 2. Выведите список товаров products и разделов catalogs, который соответствует товару.*/

DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  desription TEXT COMMENT 'Описание',
  price DECIMAL (11,2) COMMENT 'Цена',
  catalog_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_catalog_id (catalog_id)
) COMMENT = 'Товарные позиции';

INSERT INTO products VALUES
  (DEFAULT, 'Intel 8080', '', 8, 1, DEFAULT, DEFAULT),
  (DEFAULT, 'Intel 8086', '', 9, 1, DEFAULT, DEFAULT),
  (DEFAULT, 'MSI 123', '', 34, 2, DEFAULT, DEFAULT);

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
  (DEFAULT, 'Processors'),
  (DEFAULT, 'Mother boards'),
  (DEFAULT, 'Video cards');

SELECT p.name, c.name
FROM products AS p
INNER JOIN catalogs AS c ON (p.catalog_id = c.id)
GROUP BY p.id

