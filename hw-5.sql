/*Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение”
1/Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
Заполните их текущими датой и временем.*/


CREATE DATABASE users;
USE DATABASES users;

mysql> CREATE TABLE users (
    -> id SERIAL PRIMARY KEY,
    -> name VARCHAR(255) COMMENT 'Имя пользователя',
    -> birthday_at DATE COMMENT 'День рождения',
    -> created_at DATETIME,
    -> updated_at DATETIME,
    -> ) COMMENT = 'Покупатели';
UPDATE users
	SET created_at = NOW() AND updated_at = NOW()
;
/*2/ Таблица users была неудачно спроектирована. Записи created_at и updated_at 
были заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". 
Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.*/

ALTER TABLE users MODIFY COLUMN created_at varchar(150); 
ALTER TABLE users MODIFY COLUMN updated_at varchar(150); 
- Преобразую значения из строки
UPDATE users
	SET created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'),
	updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i')
;

-- Обновляю тип данных колонок с VARCHAR на DATETIME
ALTER TABLE users
	MODIFY COLUMN created_at DATETIME,
	MODIFY COLUMN updated_at DATETIME
;

-- Обртно вернуть исходный вид даты не получается, бился весь вечер над тем что бы вернуть к формату 20.10.2017 8:10
UPDATE users
	SET created_at = DATE_FORMAT(created_at, '%d.%m.%Y %H:%i'),
	updated_at = DATE_FORMAT(updated_at, '%d.%m.%Y %H:%i')
;
/*3/ В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры:
 0, если товар закончился и выше нуля, если на складе имеются запасы.
 Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
Однако, нулевые запасы должны выводиться в конце, после всех записей.*/

CREATE TABLE storehouses_products (
    -> id SERIAL PRIMARY KEY
    -> storehouses_id INT UNSIGNED,
    -> product_id INT UNSIGNED,
    -> value INT UNSIGNED COMMENT 'Запас товрной позиции на складе',
    -> created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    -> updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    -> ) COMMENT = 'Запасы на складе';

 SELECT * FROM storehouses_products ORDER BY value;

 SELECT id, value, IF(value > 0, 0, 1) AS sort FROM storehouses_products ORDER BY value;

SELECT * FROM storehouses_products ORDER BY IF(value> 0, 0, 1), value;

4/ Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august')

SELECT * FROM users WHERE birthday_at RLIKE '^[0-9]{4}-(05|08)-[0-9]{2}';

5/ Из таблицы catalogs извлекаются записи при помощи запроса. 
SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
Отсортируйте записи в порядке, заданном в списке IN.

SELECT round(exp(sum(log(id))), 10) from users;


 /*  Практическое задание теме “Агрегация данных”
1/ Подсчитайте средний возраст пользователей в таблице users*/

SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())), 0) AS AVG_Age FROM users;

/*2/ Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
Следует учесть, что необходимы дни недели текущего года, а не года рождения.*/

SELECT name, birthday_at FROM users;
SELECT DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))) AS day FROM users;
SELECT DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day FROM users;
SELECT DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day FROM users GROUP BY day;
SELECT
	DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day,
	COUNT(*) AS total
FROM
	users
GROUP BY
	day
ORDER BY
	total DESC;




