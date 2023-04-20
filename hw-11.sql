/* Практическое задание по теме “Оптимизация запросов”
1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users,
 catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы,
 идентификатор первичного ключа и содержимое поля name.*/

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_at DATETIME NOT NULL,
	table_name VARCHAR(45) NOT NULL,
	str_id BIGINT(20) NOT NULL,
	name_value VARCHAR(45) NOT NULL
) ENGINE = ARCHIVE;


DROP TRIGGER IF EXISTS watchlog_users;
delimiter //
CREATE TRIGGER watchlog_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'users', NEW.id, NEW.name);
END //
delimiter ;

DROP TRIGGER IF EXISTS watchlog_catalogs;
delimiter //
CREATE TRIGGER watchlog_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'catalogs', NEW.id, NEW.name);
END //
delimiter ;

delimiter //
CREATE TRIGGER watchlog_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'products', NEW.id, NEW.name);
END //
delimiter ;


SELECT * FROM users;
SELECT * FROM logs;

INSERT INTO users (name, birthday_at)
VALUES ('Кнехт', '1900-01-01');

SELECT * FROM users;
SELECT * FROM logs;

INSERT INTO users (name, birthday_at)
VALUES ('Liu Kangh', '1900-01-01'),
		('Sub-Zero', '1103-01-01'),
		('Scorpion', '1103-01-01'),
		('Raiden', '0000-00-01');

SELECT * FROM users;
SELECT * FROM logs;

SELECT * FROM catalogs;
SELECT * FROM logs;

INSERT INTO catalogs (name)
VALUES ('Оперативная память'),
		('Куллера'),
		('Аксессуары');

SELECT * FROM catalogs;
SELECT * FROM logs;


SELECT * FROM products;
SELECT * FROM logs;

INSERT INTO products (name, description, price, catalog_id)
VALUES ('PATRIOT PSD34G13332', 'Оперативная память', 3000.00, 13),
		('DARK ROCK PRO 4 (BK022)', 'Куллера', 500.00, 14),
		('Коврик', 'Коврик для мыши', 150.00, 15);

SELECT * FROM products;
SELECT * FROM logs;


/*Практическое задание по теме “NoSQL”
1. В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.*/


# Запускаем сервер

redis-cli

# Смотрим справку

help @hash


# Забили данные для нескольких IP-адресов

HINCRBY IP '192.168.0.5' 1
HINCRBY IP '192.168.0.3' 1
HINCRBY IP '192.168.0.1' 1
HINCRBY IP '192.168.0.5' 1
HINCRBY IP '192.168.0.1' 1
HINCRBY IP '192.168.0.1' 1
HINCRBY IP '192.168.0.4' 1

# Посмотрели результат

HGETALL IP

/*2. При помощи базы данных Redis решите задачу поиска имени пользователя 
по электронному адресу и наоборот, поиск электронного адреса пользователя по его имени.*/

# Вносим данные по почте. Создаем два хэша для пользователя и почты.

HSET EMAILS 'babarykin@list.ru' 'Eugene'
HSET EMAILS 'support@dostoevsky-perm.ru' 'Tech'
HSET EMAILS 'sale@dostoevsky-perm.ru' 'Oleg'

HSET USERS 'Eugene' 'babarykin@list.ru'
HSET USERS 'Tech' 'support@dostoevsky-perm.ru'
HSET USERS 'Oleg' 'sale@dostoevsky-perm.ru'

# Получаем имя пользователя по электронной почте

HGET EMAILS 'babarykin@list.ru'

# Получаем электронную почту по имени пользователя

HGET USERS 'Eugene'

/*3. Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.*/

 
shop.products.insert({
    name: "Intel Core i3-8100",
    description: "Процессор для настольных персональных компьютеров, основанных на платформе Intel.",
    price: 7890.00,
    catalog: "Процессоры"
})


shop.catalogs.insertMany( [
      { _id: 1, name: "Процессоры"},
      { _id: 2, name: "Материнские платы"},
      { _id: 3 ,name: "Видеокарты"}
   ] );

shop.products.insert({
    name: "Intel Core i3-8100",
    description: "Процессор для настольных персональных компьютеров, основанных на платформе Intel.",
    price: 7890.00,
    catalog: 1
})