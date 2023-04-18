USE shop
/* Транзакции, переменные, представления
 1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
Переместите запись id = 1 из таблицы shop.users в таблицу sample.users.
 Используйте транзакции.*/
 
START TRANSACTION;
INSERT INTO sample.users (SELECT * FROM shop.users WHERE shop.users.id = 1);
COMMIT;

/* 2. Создайте представление, которое выводит название name товарной позиции 
из таблицы products и соответствующее название каталога name из таблицы catalogs.*/

CREATE OR REPLACE VIEW v AS 
  SELECT products.name AS p_name, catalogs.name AS c_name 
    FROM products,catalogs 
      WHERE products.catalog_id = catalogs.id;
      
      
/* Администрирование MySQL
1. Создайте двух пользователей которые имеют доступ к базе данных shop. 
Первому пользователю shop_read должны быть доступны только запросы на чтение данных, 
второму пользователю shop — любые операции в пределах базы данных shop.*/

DROP USER IF EXISTS shop;
CREATE USER shop IDENTIFIED WITH sha256_password BY '123';
GRANT ALL ON shop.* TO shop;

DROP USER IF EXISTS shop_read;
CREATE USER shop_read IDENTIFIED WITH sha256_password BY '123';
GRANT SELECT ON shop.* TO shop_read;

/* 2. (по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password,
 содержащие первичный ключ, имя пользователя и его пароль. 
 Создайте представление username таблицы accounts, предоставляющий доступ к столбца id
 и name. Создайте пользователя user_read, который бы не имел доступа к таблице accounts, 
 однако, мог бы извлекать записи из представления username.*/
 
 DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
	id SERIAL PRIMARY KEY,
	name VARCHAR (50),
	password VARCHAR(50)
);

DROP VIEW IF EXISTS username;
CREATE VIEW username(id, name) AS
SELECT id, name FROM accounts;

DROP USER IF EXISTS shop_read;
CREATE USER shop_read;
GRANT SELECT ON shop.accounts TO shop_read;

/*Хранимые процедуры и функции, триггеры
1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, 
в зависимости от текущего времени суток. С 6:00 до 12:00 функция 
должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция 
должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", 
с 00:00 до 6:00 — "Доброй ночи".*/


DELIMITER //

DROP FUNCTION IF EXISTS hello//
CREATE FUNCTION hello() RETURNS TEXT DETERMINISTIC
BEGIN
  RETURN CASE
      WHEN "06:00" <= CURTIME() AND CURTIME() < "12:00" THEN "Доброе утро"
      WHEN "12:00" <= CURTIME() AND CURTIME() < "18:00" THEN "Добрый День"
      WHEN "18:00" <= CURTIME() AND CURTIME() < "00:00" THEN "Добрый вечер"
      ELSE "Доброй ночи"
    END;
END //

DELIMITER ;

/* 2.В таблице products есть два текстовых поля: name с названием товара и description
 с его описанием. Допустимо присутствие обоих полей или одно из них. 
 Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
 Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
 При попытке присвоить полям NULL-значение необходимо отменить операцию.*/
 
 DELIMITER //

CREATE TRIGGER desc_and_name_check_before_insert BEFORE INSERT ON products FOR EACH ROW
BEGIN
  IF NEW.name IS NULL AND NEW.description IS NULL
    THEN SIGNAL sqlstate '45001' set message_text = "products name or description can not be NULL"; 
  end if;
END; //

CREATE desc_and_name_check_before_update BEFORE UPDATE ON products FOR EACH ROW
BEGIN
  IF NEW.name IS NULL AND NEW.description IS NULL
    THEN SIGNAL sqlstate '45001' set message_text = "products name or description can not be NULL"; 
  end if;
END; //

 
 






      

