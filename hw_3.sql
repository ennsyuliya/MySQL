/*Написать крипт, добавляющий в БД vk, которую создали на занятии, 3 новые таблицы (с перечнем полей, указанием индексов и внешних ключей)*/

DROP TABLE IF EXISTS songs;
CREATE TABLE songs(
	id SERIAL,
    name_songs VARCHAR(255) NOT NULL, 
    artist_id BIGINT( 20 ) NOT NULL ,
    album_id BIGINT( 20 ) NOT NULL ,
    genre_id INT( 11 ) NOT NULL ,
    comments TEXT NOT NULL ,
    url VARCHAR( 512 ) NOT NULL ,
    rating INT( 11 ) NOT NULL ,
    upload_date DATE NOT NULL
);

DROP TABLE IF EXISTS artist;
CREATE TABLE artist(
	id SERIAL,
    name_artist VARCHAR(255) NOT NULL, 
    artist_id BIGINT UNSIGNED NOT NULL UNIQUE
    genre_id INT( 11 ) NOT NULL ,
    
);

DROP TABLE IF EXISTS albums;
CREATE TABLE alboms(
	id SERIAL,
    name_alboms VARCHAR(255) NOT NULL, 
    artist_id BIGINT UNSIGNED NOT NULL UNIQUE
    artist_id BIGINT( 20 ) NOT NULL ,
    votes INT( 11 ) NOT NULL DEFAULT '0' ,
    
);

