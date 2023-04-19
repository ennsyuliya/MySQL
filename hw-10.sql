/* Интернет-магазин садовых растений
DROP DATABASE IF EXISTS garden;
CREATE DATABASE garden;
USE garden;*/

DROP TABLE IF EXISTS title_info;
CREATE TABLE title_info (
	id SERIAL PRIMARY KEY,
	title_id BIGINT UNSIGNED,
	title_type_id BIGINT UNSIGNED DEFAULT 1,
	poster BIGINT UNSIGNED DEFAULT 2,
	tagline VARCHAR(200) DEFAULT ' ',
	synopsis VARCHAR(500) DEFAULT ' ',
	FOREIGN KEY (title_id) REFERENCES titles (id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	FOREIGN KEY (title_type_id) REFERENCES title_types (id)
		ON DELETE SET NULL
		ON UPDATE CASCADE,
	FOREIGN KEY (poster) REFERENCES images (id)
		ON DELETE SET NULL
		ON UPDATE CASCADE
); COMMENT 'товары';



DROP TABLE IF EXISTS buyers;
CREATE TABLE buyers (
	buyers_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    firstname VARCHAR(50),
    lastname VARCHAR(50) COMMENT 'Фамиль', -- COMMENT на случай, если имя неочевидное
    email VARCHAR(120) UNIQUE,
 	password_hash VARCHAR(100), 
	phone BIGINT UNSIGNED UNIQUE, 
	
    INDEX buyers_firstname_lastname_idx(firstname, lastname)
) COMMENT 'покупатели';

DROP TABLE IF EXISTS buyers_communities;
CREATE TABLE buyers_communities(
	buyers_id BIGINT UNSIGNED NOT NULL,
	community_id BIGINT UNSIGNED NOT NULL,
  
); COMMENT 'сообщество';

DROP TABLE IF EXISTS articles;
CREATE TABLE articles(
	id SERIAL,
    articles_type_id BIGINT UNSIGNED NOT NULL,
    buyers_id BIGINT UNSIGNED NOT NULL,
  	body text,
    filename VARCHAR(255),
    -- file blob,    	
    size INT,
	metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (buyers_id) REFERENCES buyers (id),
    FOREIGN KEY (articles_type_id) REFERENCES articles_types(id)
); COMMENT 'полезные статьи';

DROP TABLE IF EXISTS orders;
CREATE TABLE orders ( 
	id SERIAL,
    order_name CHAR( 50 ) CHARACTER SET 
    ); COMMENT 'заказы';
    

