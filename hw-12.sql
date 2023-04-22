/*  1. общее текстовое описание БД и решаемых ею задач:
База данных HH.ru - крупнейшая российская компания интернет-рекрутмента,
 развивающая бизнес в России, Белоруссии, Казахстане. 
2. минимальное количество таблиц - 10;
3. скрипты создания структуры БД (с первичными ключами, индексами, внешними ключами);
4. представления (минимум 2);
5. хранимые процедуры / триггеры;
скрипты наполнения БД данными - отдельный файл SQL;
скрипты характерных выборок (включающие группировки, JOIN'ы, вложенные таблицы) - отдельный  файл SQL;
создать ERDiagram для БД - отдельный файл;*/

DROP DATABASE IF EXISTS hh;
CREATE DATABASE hh;

USE hh;

/*  Таблица пользователей */
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  firstname VARCHAR(50) NOT NULL,
  lastname VARCHAR(50) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW(),
  password_hash VARCHAR(100),
  phone BIGINT UNSIGNED UNIQUE,
  
  INDEX users_id_idx (id),
  INDEX users_firstname_lastname_idx (firstname, lastname),
  INDEX users_email_idx (email)
);


/*  Таблица профилей */
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
  user_id INT UNSIGNED NOT NULL PRIMARY KEY,
  sex CHAR(1) NOT NULL,
  birthday DATE,
  country VARCHAR(100),
  city VARCHAR(100),
  description_user text,
  interests text,
  vk_link VARCHAR(250),
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW(),
  CONSTRAINT profiles_user_id_fk FOREIGN KEY (user_id) REFERENCES users(id),
  
  FOREIGN KEY (user_id) REFERENCES users(id)
);

ALTER TABLE `profiles` ADD CONSTRAINT fk_user_id
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON UPDATE CASCADE -- (значение по умолчанию)
    ON DELETE RESTRICT; -- (значение по умолчанию)
    
/*  Таблица опыта работы */
DROP TABLE IF EXISTS  experience;
CREATE TABLE experience (
  experience_id INT UNSIGNED NOT NULL,
  company VARCHAR(100) NOT NULL,
  position VARCHAR(100) NOT NULL,
  recomendations VARCHAR(250),
  start_date DATE NOT NULL,
  end_date DATE,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW(),
  CONSTRAINT experience_user_id_fk FOREIGN KEY (experience_id) REFERENCES users(id),
  
   INDEX  position_id_idx (position),
   INDEX  experience_id_idx (experience_id),
  
   FOREIGN KEY (experience_id) REFERENCES users(id),
   FOREIGN KEY (experience_id) REFERENCES profiles (user_id)
);

/*  Таблица компетенций */
DROP TABLE IF EXISTS skills;
CREATE TABLE skills (
  skills_id INT UNSIGNED NOT NULL PRIMARY KEY,
  skills_name VARCHAR(255) COMMENT 'Название компетенции',
  
   INDEX  skills_id_idx (skills_id),
   INDEX  skills_name_idx (skills_name),
   
   FOREIGN KEY (skills_id) REFERENCES experience (experience_id)
);


/* Таблица компаний*/
DROP TABLE IF EXISTS company;
CREATE TABLE company (
  company_id INT UNSIGNED NOT NULL,
  company_name VARCHAR(50) NOT NULL,
  type_of_activity VARCHAR(50) NOT NULL, #- вид деятельности
  vacancy_company INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(120) NOT NULL UNIQUE,
  phone BIGINT UNSIGNED UNIQUE,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW(),
  
  INDEX company_id_idx (company_id),
  INDEX type_of_activity_idx (type_of_activity),
  INDEX company_name_idx (company_name)
);

/* Таблица вакансии*/
DROP TABLE IF EXISTS vacancy;
CREATE TABLE vacancy (
  vacancy_id INT UNSIGNED NOT NULL,
  vacancy_to_company_name VARCHAR(50) NOT NULL,
  position VARCHAR(100) NOT NULL,
  description_vacancy VARCHAR(255) COMMENT 'Описание вакансии',
  recomendations VARCHAR(250),
  type_of_activity VARCHAR(50) NOT NULL, #- вид деятельности
  email VARCHAR(120) NOT NULL,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW(),
  
  INDEX vacancy_id_idx (vacancy_id),
  INDEX position_idx (position),
  INDEX type_of_activity_idx (type_of_activity),
  
  FOREIGN KEY (vacancy_id) REFERENCES company (vacancy_company)
    
);

/*Таблица проф.область*/
DROP TABLE IF EXISTS professional;
CREATE TABLE professional (
    professional_id INT UNSIGNED NOT NULL,
	FOREIGN KEY (professional_id) REFERENCES company (company_id),
	automotive_business BIT DEFAULT 0 NULL COMMENT 'automotive business',
	administrative_staff BIT DEFAULT 0 NULL COMMENT 'administrative staff',
	commerce BIT DEFAULT 0 NULL COMMENT 'commerce',
	safety BIT DEFAULT 0 NULL COMMENT 'safety',
	finance BIT DEFAULT 0 NULL COMMENT 'finance',
	management BIT DEFAULT 0 NULL COMMENT 'management',
	public_servant BIT DEFAULT 0 NULL COMMENT 'public servant',
	medicine BIT DEFAULT 0 NULL COMMENT 'medicine',
	hr BIT DEFAULT 0 NULL COMMENT 'hr',
	lawyers BIT DEFAULT 0 NULL COMMENT 'lawyers',
	information_technology BIT DEFAULT 0 NULL COMMENT 'information technology',
	sales BIT DEFAULT 0 NULL COMMENT 'sales',
	education BIT DEFAULT 0 NULL COMMENT 'education'
	);
    


/* таблица избранных вакансий*/
DROP TABLE IF EXISTS favorite;
CREATE TABLE favorite (
	favorite_id INT UNSIGNED NOT NULL,
	FOREIGN KEY (favorite_id) REFERENCES users(id),
	vacancy_favorite_id INT UNSIGNED NOT NULL,
	FOREIGN KEY (vacancy_favorite_id) REFERENCES vacancy(vacancy_id),
	rating TINYINT NULL
);




    
/* Таблица сообщений */
DROP TABLE IF EXISTS messages;
CREATE TABLE  messages (
	id SERIAL PRIMARY KEY,
	from_user_id INT UNSIGNED NOT NULL, -- Кто написал
	to_company_id INT UNSIGNED NOT NULL, -- Кому написал
	body TEXT, -- Текст сообщения
	created_at DATETIME DEFAULT NOW(), -- Дата и время сообщения
    
	FOREIGN KEY (from_user_id) REFERENCES users(id),
	FOREIGN KEY (to_company_id) REFERENCES company(company_id),
	
	INDEX (from_user_id),
	INDEX (to_company_id)
);


/* Таблица откликов на вакансию
DROP TABLE IF EXISTS response;    
CREATE TABLE response ( 
    id SERIAL PRIMARY KEY,
	from_user_id INT UNSIGNED NOT NULL, 
	to_company_id INT UNSIGNED NOT NULL,
    position VARCHAR(30),
	body TEXT,
    FOREIGN KEY (film_id) REFERENCES films(id)
   ); 
    */

/*Заполняем таблицы*/

INSERT INTO users (id, firstname, lastname, email, created_at, updated_at, password_hash, phone) VALUES
 (21, 'Aleksandra', 'Shell', 'aleksandra03@example.com', '1991-01-23 07:28:32', '2021-09-04 14:44:56', 'db88572ae98b2749e7a09ad73a2f28c5e0e3583', '89500000001'),
 (22, 'Alena', 'Osipova', 'alena59@example.com', '1983-03-04 22:22:00', '2021-08-08 17:54:28', '7f15b4f96380760a29d693890e69507d5c8f7ea', '89500000002'),
 (23, 'Artem', 'Zhukov', 'artem@example.net', '2007-08-04 02:36:35', '2021-04-26 05:28:29', '858004c7ff46b60be5c4e3157f31033e00e5e5c', '89500000003'),
 (26, 'Bogdan', 'Belov', 'bogdan29@example.com', '1989-06-25 16:17:31', '2021-12-03 10:03:29', 'f7fda2cb0beb0ffc051361130c3cc05d9e77daa', '89500000004'),
 (30, 'Boris', 'Polyakov', 'boris@example.com', '1995-05-04 07:23:50', '2021-09-23 13:10:54', 'c95c5822ea9b3a4bd693fccd848e5cc2ecca8de', '89500000006'),
 (32, 'Vera', 'Guseva', 'guseva72@example.net', '1970-11-22 21:23:36', '2021-06-03 08:32:00', 'be42eb6dd4fc763ddde4e97dbd97a00f35d9b19', '89500000007'),
 (35, 'Victor', 'Kuzmin', 'kuzmin71@example.com', '2011-12-12 07:56:43', '2021-06-03 00:05:32', '1e33b73d6a315ae018725bdc0be00f026728eb3', '89500000008'),
 (36, 'Vlad', 'Sergeev', 'vlad@example.com', '1974-07-15 09:09:57', '2021-06-22 10:58:15', '85de79c8ca9ad28fd0e697fef37e50bc35e7795', '89500000009'),
 (39, 'Gleb', 'Zaharov', 'gleb25@example.net', '2012-02-05 09:37:45', '2021-12-31 21:36:03', '301a7a3d0615f7544069a2ac7eb0432a1b0ebf7', '89500000010'),
 (41, 'Darya', 'Makarova', 'makarova03@example.com', '1989-01-23 07:28:32', '2022-09-04 14:44:56', 'dbc8852ae98b2749e7a09ad73a2f28c5e0e3583', '89500000011'),
 (42, 'Egor', 'Orlov', 'egor59@example.com', '1983-03-04 22:22:00', '2022-03-08 17:54:28', '7f15b4f96338070a29d693890e69507d5c8f7ea', '89500000012'),
 (43, 'Igor', 'Pavlov', 'igor123@example.net', '2007-08-04 02:36:35', '2022-04-26 05:28:29', '858004c7ff46560be5c4e3157f31033e00e5e5c', '89500000013'),
 (46, 'Katerina', 'Egorova', 'katerina29@example.com', '2021-06-25 16:17:31', '2022-06-03 10:03:29', 'f7fd2cb0beeb0ffc051361130c3cc05d9e77daa', '89500000044'),
 (50, 'Marya', 'Volkova', 'marya1563@example.com', '2021-05-04 07:23:50', '2022-06-23 13:10:54', 'c5c5822ea90b3a4bd693fccd848e5cc2ecca8de', '89500000016'),
 (52, 'Yaroslav', 'Morozov', 'yaroslav72@example.net', '2021-11-22 21:23:36', '2022-06-03 08:32:00', 'e42eb6dd4f9c763ddde4e97dbd97a00f35d9b19', '89500000017'),
 (55, 'Nikita', 'Novikov', 'nikita71@example.com', '2021-12-12 07:56:43', '2022-06-03 00:05:32', 'e33b73d6fa315ae018725bdc0be00f026728eb3', '89500000018'),
 (56, 'Maksim', 'Sokolov', 'maxim856@example.com', '2016-07-15 09:09:57', '2022-06-22 10:58:15', '5de79c8ca9ad298fd0e697fef37e50bc35e7795', '89500000019'),
 (59, 'Sergey', 'Popov', 'sergey25@example.net', '2017-02-05 09:37:45', '2022-02-11 21:36:03', '01a7a3d0615af7544069a2ac7eb0432a1b0ebf7', '89500000022'),
 (61, 'Olga', 'Smirnova', 'olga03@example.com', '2020-01-23 07:28:32', '2021-09-04 14:44:56', 'c88572ae98b2749e7a09ad73a2f28c5e0e3583', '89500000023'),
 (72, 'Eva', 'Ivanova', 'eva59@example.com', '2021-03-04 22:22:00', '2022-05-08 17:54:28', '15b4f963380760a29d693890e69507d5c8f7ea', '89500000024');



INSERT INTO profiles (user_id, sex, birthday, country, city, description_user, interests, vk_link, created_at, updated_at) VALUES
 (21, 1, '1973-01-16', 'Russia', 'Moscow', 'Ut ut quis quasi facere. Aut nemo nesciunt expedita earum iusto est amet. Dolorem non expedita fugiat et ipsa non sint. Amet nemo et praesentium.', NULL, 'http://parisian.com/', '1991-01-23 07:28:32', '2021-09-04 14:44:56'),
 (22, 1, '1983-02-15','Russia', 'Moscow', 'Sit necessitatibus velit eligendi et dolor. Suscipit rerum iste qui quia. Illo quis consequatur expedita voluptatum ut voluptatem voluptatem. Perferendis eum suscipit veniam aspernatur veniam expedita architecto.', NULL, 'http://www.waters.com/', '1983-03-04 22:22:00', '2021-08-08 17:54:28'),
 (23, 2, '1986-03-14','Russia', 'Saint Petersburg', 'Sequi laborum earum placeat praesentium iure consequatur tempora. Doloremque aut quam nesciunt quo architecto optio quam.', NULL, 'http://west.com/', '2007-08-04 02:36:35', '2021-04-26 05:28:29'),
 (26, 2, '1988-04-12','Russia', 'Moscow', 'Quia perspiciatis iure incidunt voluptas. Quod molestiae atque eveniet praesentium. Fuga voluptate perferendis quaerat quisquam consequuntur ut veniam omnis. Eum vel amet quam explicabo.', NULL, 'http://www.lowegislason.com/', '1989-06-25 16:17:31', '2021-12-03 10:03:29'),
 (30, 2, '1989-05-19','Belarus', 'Minsk','Sed quod ut aut a voluptas. Sapiente quidem vel facilis est vitae at. Est dolore fugit eos corporis sunt.', NULL, 'http://ricedouglas.org/', '1995-05-04 07:23:50', '2021-09-23 13:10:54'),
 (32, 1, '1992-06-18','Russia', 'Moscow', 'Consequatur est eveniet corporis rem reiciendis reprehenderit quo aspernatur. Assumenda magni id qui recusandae quia ut magni. Pariatur sit quia rem ducimus dicta similique animi.', NULL, 'http://www.funk.com/', '1970-11-22 21:23:36', '2021-06-03 08:32:00'),
 (35, 2, '1993-07-10','Russia', 'Irkutsk', 'Qui necessitatibus omnis voluptatem. Nostrum ipsam nemo aut eligendi pariatur consequatur cum. Cumque in libero enim ut voluptatem aut et.', NULL, 'http://effertz.net/', '2011-12-12 07:56:43', '2021-06-03 00:05:32'),
 (36, 1, '1994-08-22','Russia', 'Moscow', 'Eligendi natus voluptate pariatur sed. Qui neque consequatur non ut odit consequatur dolorem. Vero et nihil neque dolores dolores. Deserunt facilis id eaque error.', NULL, 'http://www.murazik.com/', '1974-07-15 09:09:57', '2021-06-22 10:58:15'),
 (39, 1, '1997-09-21','Russia', 'Moscow', 'Enim eum doloremque in aut accusamus. Sit asperiores consequatur eum voluptatem sint ratione magni. Fuga natus excepturi qui qui odit ex modi.', NULL, 'http://www.cristblanda.biz/', '2012-02-05 09:37:45', '2021-12-31 21:36:03'),
 (41, 2, '2000-10-20','Kazakhstan', 'Astana', 'Alias distinctio sed a in ut eius architecto. Ut consectetur recusandae qui adipisci temporibus.', NULL, 'http://www.kiehn.com/', '1989-01-23 07:28:32', '2022-09-04 14:44:56'),
 (42, 1, '1997-11-19','Kazakhstan', 'Almaty', 'Et aut provident laboriosam veniam deleniti enim. Maxime numquam repellat qui nesciunt quia. Impedit aliquam accusantium sed hic. Est culpa harum architecto debitis sed quia voluptas.', NULL, 'http://lebsack.com/', '1983-03-04 22:22:00', '2022-03-08 17:54:28'),
 (43, 1, '1996-12-18','Russia', 'Saint Petersburg', 'Error occaecati necessitatibus amet. Quo qui esse quia. Dolorem ullam consequatur blanditiis culpa dolor et. Laudantium sunt nemo id quia rerum assumenda.', NULL, 'http://www.bechtelar.com/', '2007-08-04 02:36:35', '2022-04-26 05:28:29'),
 (46, 2, '1994-01-17','Russia', 'Moscow',  'Iure maxime distinctio qui laborum nam molestiae qui. Quam ipsa est et et. Pariatur rem et officiis tempora voluptatem.', NULL, 'http://www.dietrichhettinger.org/', '2021-06-25 16:17:31', '2022-06-03 10:03:29'),
 (50, 1, '1991-02-16','Russia', 'Saint Petersburg', 'Deleniti et sequi soluta omnis ad eius. Consequatur molestiae consectetur sequi blanditiis pariatur. Necessitatibus eveniet sint voluptatem dolor qui consectetur sint.', NULL, 'http://www.cruickshank.com/', '2021-05-04 07:23:50', '2022-06-23 13:10:54'),
 (52, 2, '1989-03-15','Russia', 'Moscow', 'Dolor modi amet et eius. Aut quod veniam suscipit eaque voluptatem corrupti. Aspernatur dolor consequatur error est.', NULL, 'http://www.nader.com/', '2021-11-22 21:23:36', '2022-06-03 08:32:00'),
 (55, 2, '1988-04-14','Kazakhstan', 'Almaty', 'Animi unde omnis et quasi quia. Voluptatibus explicabo consequuntur ut rerum. Suscipit nisi rerum repellat quia libero laboriosam ab. Accusantium asperiores earum est. Sint qui ut deleniti doloremque corrupti qui.', NULL, 'http://lang.org/',  '2021-12-12 07:56:43', '2022-06-03 00:05:32'),
 (56, 2, '1986-05-13','Russia', 'Novosibirsk', 'Qui necessitatibus omnis voluptatem. Nostrum ipsam nemo aut eligendi pariatur consequatur cum. Cumque in libero enim ut voluptatem aut et.', NULL, 'http://effkertz.net/','2016-07-15 09:09:57', '2022-06-22 10:58:15'),
 (59, 2, '1984-06-12','Russia', 'Saint Petersburg',  'Iure maxime distinctio qui laborum nam molestiae qui. Quam ipsa est et et. Pariatur rem et officiis tempora voluptatem.', NULL, 'http://www.dietropjichhettinger.org/','2017-02-05 09:37:45', '2022-02-11 21:36:03'),
 (61, 1, '1979-07-11','Russia', 'Moscow', 'Sed quod ut aut a voluptas. Sapiente quidem vel facilis est vitae at. Est dolore fugit eos corporis sunt.', NULL, 'http://ricedoufgliloas.org/','2020-01-23 07:28:32', '2021-09-04 14:44:56'),
 (72, 1, '1992-08-01','Russia', 'Novosibirsk','Alias distinctio sed a in ut eius architecto. Ut consectetur recusandae qui adipisci temporibus.', NULL, 'http://www.kfdiehn.com/','2021-03-04 22:22:00', '2022-05-08 17:54:28');





INSERT INTO experience (experience_id, company, position, recomendations, start_date, end_date, created_at, updated_at) VALUES 
(21, 'Reichert, Padberg and Bins', '', NULL, '1989-07-12', '2003-07-13', '1986-05-29 19:06:23', '2008-02-03 08:56:12'),
(22, 'Christiansen Inc', '', NULL, '2021-12-27', '1983-07-15', '1971-09-18 02:19:11', '1988-12-26 16:58:05'),
(23, 'Ziemann, Adams and Lebsack', '', NULL, '1995-05-28', '2012-12-05', '1993-03-24 18:59:22', '2021-10-29 18:23:38'),
(26, 'Gutmann, Haag and Rau', '', NULL, '1999-03-24', '1972-05-03', '1977-01-15 04:35:26', '2018-02-28 23:01:04'),
(30, 'Davis PLC', '', NULL, '1984-02-01', '2014-10-20', '2009-08-20 21:29:44', '1999-11-06 11:13:19'),
(32, 'Rogahn, Brakus and Kub', '', NULL, '1986-08-10', '1976-06-22', '1972-06-02 21:46:15', '1995-01-20 04:03:52'),
(35, 'Monahan, Frami and Quitzon', '', NULL, '1983-02-13', '2009-12-12', '2009-02-11 11:06:14', '2001-04-03 09:00:03'),
(36, 'Doyle, Beatty and Larson', '', NULL, '1986-02-07', '1992-09-15', '2009-09-11 15:45:09', '1994-07-09 10:20:12'),
(39, 'Parker Inc', '', NULL, '1996-02-14', '2005-01-24', '1974-08-08 16:54:24', '2001-08-11 07:27:52'),
(41, 'Rippin Ltd', '', NULL, '1991-07-26', '1994-11-02', '1980-07-17 01:50:09', '2020-08-17 05:52:56'),
(42, 'Senger Ltd', '', NULL, '1970-02-22', '1992-10-01', '1983-09-30 06:45:33', '2004-06-23 06:07:04'),
(43, 'Brown-Wisoky', '', NULL, '1982-09-17', '2013-11-01', '1994-04-23 19:20:02', '2004-05-05 22:10:35'),
(46, 'Green-Williamson', '', NULL, '1995-05-09', '1972-06-01', '2014-12-28 11:29:18', '1984-02-21 20:56:32'),
(50, 'Thompson Ltd', '', NULL, '2000-10-11', '1996-04-21', '1996-12-31 08:47:12', '1986-12-19 01:16:08'),
(52, 'Swift Inc', '', NULL, '1971-05-09', '1992-06-28', '2007-10-16 21:06:09', '2001-03-15 05:50:26'),
(55, 'Heathcote Inc', '', NULL, '1970-03-04', '2013-10-10', '2001-01-14 12:57:53', '1994-12-16 09:01:52'),
(56, 'Stamm, Jacobson and Nikolaus', '', NULL, '1995-12-02', '2010-09-24', '1975-06-02 10:51:51', '1998-10-04 11:32:51'),
(59, 'Krajcik-Russel', '', NULL, '1970-06-17', '1979-12-07', '2000-05-01 04:13:56', '2010-08-04 12:14:56'),
(61, 'Kunze LLC', '', NULL, '2003-02-26', '2004-12-20', '1983-09-03 18:44:03', '2020-09-07 02:48:01'),
(72, 'McGlynn and Sons', '', NULL, '2004-07-01', '2003-01-14', '2021-10-26 07:04:27', '1997-12-17 01:25:36');






 INSERT INTO skills (skills_id, skills_name) VALUES
 (21, 'Outgoing, tolerance, analyzing, inquiry, developing rapport'),
 (22, 'Consulting, motivating, respect'),
 (23, 'Outgoing, negotiating, tolerance, inquiry'),
 (26, 'Tolerance, analyzing, respect'),
 (30, 'Consulting, motivating,inquiry, developing rapport'),
 (32, 'Outgoing, tolerance, respect, developing rapport'),
 (35, 'Negotiating, analyzing, inquiry, developing rapport'),
 (36, 'Consulting, motivating, respect'),
 (39, 'Outgoing, tolerance,analyzing, inquiry'),
 (41, 'Negotiating, analyzing, respect '),
 (42, 'Consulting, motivating, inquiry, developing rapport' ),
 (43, 'Outgoing, tolerance, respect'),
 (46, 'Negotiating, analyzing, inquiry'),
 (50, 'Consulting, motivating, respect, inquiry'),
 (52, 'Tolerance, analyzing '),
 (55, 'Negotiating, respect, inquiry, developing rapport'),
 (56, 'Outgoing, consulting, motivating, inquiry'),
 (59, 'Tolerance, analyzing, respect'),
 (61, 'Negotiating, respect, inquiry'),
 (72, 'Outgoing, consulting, motivating, respect');

 
 INSERT INTO company (company_id, company_name, type_of_activity,vacancy_company, email, phone, created_at, updated_at)  VALUES
 (1, 'Tochka', 'automotive business', 1, 'tochka@example.com', '89500001000', '2020-01-23 07:28:32', '2022-04-04 14:44:56'),
 (2, 'Elit', 'administrative staff', 2, 'elit951@example.com', '89500001100', '2021-01-23 07:28:32', '2022-05-04 14:44:56'),
 (3, 'Leto', 'commerce', 3, 'leto321@example.com', '89500001200', '2020-01-23 07:28:32', '2022-06-04 14:44:56'),
 (4, 'Baykal', 'safety', 4, 'baykal654@example.com', '89500001300', '2019-01-23 07:28:32', '2022-06-04 14:44:56'),
 (5, 'Kompas', 'finance', 5, 'kompas987@example.com',  '89500001400', '2018-01-23 07:28:32', '2022-05-04 14:44:56'),
 (6, 'Stroy', 'management', 6, 'stroy789@example.com', '89500001500', '2017-01-23 07:28:32', '2022-04-04 14:44:56'),
 (7, ' Men', 'public servant', 7, 'men456@example.com', '89500001600', '2016-01-23 07:28:32', '2022-05-04 14:44:56'), 
 (8, 'Farma', 'medicine', 8, 'farma123@example.com', '89500001700', '2000-01-23 07:28:32', '2022-06-04 14:44:56'),
 (9, 'Staf', 'hr', 9, 'staf963@example.com', '89500001800', '1999-01-23 07:28:32', '2022-06-04 14:44:56'),
 (10, 'Law', 'lawyers', 10, 'law852@example.com', '89500001900', '2015-01-23 07:28:32', '2022-05-04 14:44:56'),
 (11, 'Antal Russia', 'information technology', 11, 'antal741@example.com', '89500002000', '2022-06-23 07:28:32', '2021-09-04 14:44:56'),
 (12, 'Zebra', 'sales', 12, 'zebra9453@example.com', '89500002100', '2017-01-23 07:28:32', '2022-04-04 14:44:56'),
 (13, 'Rambler&C', 'education', 13, ' rambler842@example.com', '89500002200', '2018-01-23 07:28:32', '2022-06-04 14:44:56');
 
 
 
  INSERT INTO vacancy ( vacancy_id, vacancy_to_company_name, position, description_vacancy, recomendations, type_of_activity, email, created_at, updated_at) VALUES
 (1, 'Tochka', 'Accountant', 'Accounting at the sites: sales, fixed assets, accountable persons. Maintaining a sales book. Control of mutual settlements and reconciliation with suppliers and buyers.', 
 'Analyzing, inquiry, developing rapport', 'administrative staff', 'tochka@example.com', '2020-01-23 07:28:32', '2022-04-04 14:44:56'),
 (2, 'Elit', 'Administrator', '1. Carries out work on effective and cultural service of visitors, creation of comfortable conditions for them. 2. Provides control over the safety of material assets.', 
 'Tolerance, analyzing, inquiry, developing rapport', 'commerce', 'elit951@example.com', '2021-01-23 07:28:32', '2022-05-04 14:44:56'),
 (3, 'Leto', 'Assistant', 'Carries out its activities at a high professional level, ensures the implementation of the Individual work plan of the teacher in full.', 
 'Outgoing, tolerance', 'safety', 'leto3321@example.com', '2020-01-23 07:28:32', '2022-06-04 14:44:56'),
 (4, 'Baykal', 'Auditor ', 'verification of the organizations reporting preparation of a report on the work performed in accordance with the standards analysis of the legality and risks of planned operations training',
 'Outgoing, tolerance, analyzing, inquiry, developing rapport', 'commerce', 'baykal654@example.com', '2019-01-23 07:28:32', '2022-06-04 14:44:56'),
 (5, 'Kompas', 'Janitor ', 'Performs cleaning of office premises, corridors, stairs, bathrooms, adjacent territory', 
 'Outgoing,developing rapport', 'information technology', 'kompas987@example.com',  '2017-01-23 07:28:32', '2022-05-04 14:44:56'),
 (6, 'Stroy', 'Consultant', 'Evaluate the prospects for the development of the enterprise. .Analyze existing enterprise development projects; develops new projects of enterprise development plans', 
 'Outgoing, tolerance, analyzing, inquiry, developing rapport','administrative staff', 'stroy789@example.com', '2017-01-23 07:28:32', '2022-04-04 14:44:56'),
 (7, ' Men', 'Developer', 'The programmers job responsibilities include: analysis of mathematical models and algorithms for solving problems, development of programs for performing the algorithm and assigned tasks by means of computer technology, testing and debugging',
 'Inquiry, developing rapport', 'commerce', 'men456@example.com', '2016-01-23 07:28:32', '2022-05-04 14:44:56'), 
 (8, 'Farma', 'Doctor ', 'Provides the population with permanent, emergency and emergency medical care in their specialty, using modern methods of prevention, diagnosis, treatment and rehabilitation.', 
 'Analyzing, inquiry, developing rapport', 'medicine', 'farma123@example.com', '2000-01-23 07:28:32', '2022-06-04 14:44:56'),
 (9, 'Staf', 'Engineer', 'Develops long-term and current plans (schedules) for building repairs, as well as measures to improve their operation and maintenance, monitors the implementation of approved plans (schedules).', 
 'Tolerance, analyzing, inquiry, developing rapport', 'safety', 'staf963@example.com', '1999-01-23 07:28:32', '2022-06-04 14:44:56'),
 (10, 'Law', ' Lawyer', 'an employee of the legal department or legal service of an organization whose duty is to provide legal assistance, monitor compliance with the law, both in relation to the organization for which he works', 
 'Outgoing, tolerance, analyzing, inquiry','administrative staff', 'law852@example.com', '2015-01-23 07:28:32', '2022-05-04 14:44:56'),
 (11, 'Antal Russia', 'Manager', 'an employee who manages certain processes and other employees in the company. Its main tasks include: - work planning, - organization of work processes, - coordination of personnel, - control over the implementation of tasks.', 
 'Outgoing, tolerance, analyzing, developing rapport', 'commerce', 'antal741@example.com', '2022-06-23 07:28:32', '2021-09-04 14:44:56'),
 (12, 'Zebra', 'Manager', 'an employee who manages certain processes and other employees in the company. Its main tasks include: - work planning, - organization of work processes, - coordination of personnel, - control over the implementation of tasks.', 
 'Outgoing, tolerance, inquiry, developing rapport', 'hr', 'zebra9453@example.com', '2017-01-23 07:28:32', '2022-04-04 14:44:56'),
 (13, 'Rambler&C', 'Programmer', 'analysis of mathematical models and algorithms for solving problems, development of programs for performing the algorithm and assigned tasks by means of computer technology, testing and debugging', 
 'Outgoing, analyzing, inquiry, developing rapport', 'information technology', 'rambler842@example.com', '2018-01-23 07:28:32', '2022-06-04 14:44:56'),
 (3, 'Leto', 'Janitor', 'Performs cleaning of office premises, corridors, stairs, bathrooms, adjacent territory', 
 'Outgoing, tolerance, analyzing', 'hr', 'leto321@example.com', '2020-01-23 07:28:32', '2022-06-04 14:44:56'),
 (4, 'Baykal', 'Consultant', ' Evaluate the prospects for the development of the enterprise. .Analyze existing enterprise development projects; develops new projects of enterprise development plans, calculates their economic feasibility. Give advice on doing business.', 
 'Outgoing, tolerance, developing rapport', 'commerce', 'baykal1654@example.com', '2019-01-23 07:28:32', '2022-06-04 14:44:56'),
 (5, 'Kompas', 'Programmer', 'analysis of mathematical models and algorithms for solving problems, development of programs for performing the algorithm and assigned tasks by means of computer technology, testing and debugging', 
 'Outgoing, inquiry, developing rapport', 'information technology', 'kompas987@example.com', '2018-01-23 07:28:32', '2022-05-04 14:44:56'),
 (6, 'Stroy', 'Programmer', 'analysis of mathematical models and algorithms for solving problems, development of programs for performing the algorithm and assigned tasks by means of computer technology, testing and debugging', 
 'Outgoing, tolerance, analyzing', 'administrative staff', 'stroy789@example.com', '2017-01-23 07:28:32', '2022-04-04 14:44:56'),
 (7, ' Men', 'Manager', 'an employee who manages certain processes and other employees in the company. Its main tasks include: - work planning, - organization of work processes, - coordination of personnel, - control over the implementation of tasks.',
 'Outgoing, tolerance, analyzing, developing rapport', 'finance', 'men456@example.com', '2016-01-23 07:28:32', '2022-05-04 14:44:56'), 
 (8, 'Farma', 'Doctor ', 'Provides the population with permanent, emergency and emergency medical care in their specialty, using modern methods of prevention, diagnosis, treatment and rehabilitation.', 
 'Outgoing, tolerance, inquiry, developing rapport', 'administrative staff', 'farma123@example.com', '2000-01-23 07:28:32', '2022-06-04 14:44:56'),
 (9, 'Staf', 'Developer', 'The programmers job responsibilities include: analysis of mathematical models and algorithms for solving problems, development of programs for performing the algorithm and assigned tasks by means of computer technology, testing and debugging', 
 'Outgoing, analyzing, inquiry, developing rapport', 'commerce', 'staf963@example.com', '1999-01-23 07:28:32', '2022-06-04 14:44:56'),
 (10, 'Law', ' Lawyer', 'an employee of the legal department or legal service of an organization whose duty is to provide legal assistance, monitor compliance with the law, both in relation to the organization for which he works', 
 'Negotiating, inquiry, developing rapport', 'information technology', 'law852@example.com', '2015-01-23 07:28:32', '2022-05-04 14:44:56'),
 (11, 'Antal Russia', 'Secretary ', 'Carries out work on organizational and technical support of administrative and administrative activities of the head of the enterprise.', 
'Negotiating, respect, developing rapport', 'automotive business', 'antal741@example.com', '2022-06-23 07:28:32', '2021-09-04 14:44:56'),
 (12, 'Zebra', 'Engineer', 'Develops long-term and current plans (schedules) for building repairs, as well as measures to improve their operation and maintenance, monitors the implementation of approved plans (schedules).', 
 'Negotiating, respect, inquiry', 'administrative staff', 'zebra9453@example.com', '2017-01-23 07:28:32', '2022-04-04 14:44:56'),
 (13, 'Rambler&C', 'Secretary ', 'Carries out work on organizational and technical support of administrative and administrative activities of the head of the enterprise.', 
 'Negotiating, respect, inquiry,', 'finance', 'rambler842@example.com', '2018-01-23 07:28:32', '2022-06-04 14:44:56'),
 (8, 'Farma', 'Manager', 'an employee who manages certain processes and other employees in the company. Its main tasks include: - work planning, - organization of work processes, - coordination of personnel, - control over the implementation of tasks.', 
 'Negotiating, respect, developing rapport', 'commerce', 'farma123@example.com', '2000-01-23 07:28:32', '2022-06-04 14:44:56'),
 (9, 'Staf', 'Engineer', 'Develops long-term and current plans (schedules) for building repairs, as well as measures to improve their operation and maintenance, monitors the implementation of approved plans (schedules).',
 'Negotiating, inquiry, developing rapport', 'administrative staff', 'staf963@example.com', '1999-01-23 07:28:32', '2022-06-04 14:44:56'),
 (10, 'Law', 'Auditor ', 'verification of the organizations reporting preparation of a report on the work performed in accordance with the standards analysis of the legality and risks of planned operations training and consulting of employees', 
 'respect, inquiry, developing rapport', 'hr', 'law852@example.com', '2015-01-23 07:28:32', '2022-05-04 14:44:56'),
 (11, 'Antal Russia', 'Developer', ' The programmers job responsibilities include: analysis of mathematical models and algorithms for solving problems, development of programs for performing the algorithm and assigned tasks by means of computer technology, testing and debugging', 
 'Negotiating, inquiry, developing rapport', 'administrative staff', 'antal741@example.com', '2022-06-23 07:28:32', '2021-09-04 14:44:56'),
 (12, 'Zebra', 'Consultant', ' Evaluate the prospects for the development of the enterprise. .Analyze existing enterprise development projects; develops new projects of enterprise development plans, calculates their economic feasibility. Give advice on doing business.', 
 'Negotiating, respect, developing rapport', 'administrative staff', 'zebra9453@example.com', '2017-01-23 07:28:32', '2022-04-04 14:44:56'),
 (13, 'Rambler&C', 'Assistant', 'Carries out its activities at a high professional level, ensures the implementation of the Individual work plan of the teacher in full.', 
 'Negotiating, respect, inquiry', 'automotive business', 'rambler842@example.com', '2018-01-23 07:28:32', '2022-06-04 14:44:56');
 
  INSERT INTO favorite VALUES 
(21,1,8),(22,13,7),(30,5,9),(36,11,6),(39,4,7),(43,10,9),(52,3,8),(56,7,9),(61,5,8),(72,2,8);
  
  
  
  
  INSERT INTO messages (id, from_user_id, to_company_id, body, created_at)  VALUES
  (1, 23, 9, 'Ut enim ad minima veniam, unde omnis iste natus error sit voluptatem accusantium doloremque laudantium', '2022-06-27 08:06:03'),
  (2,26, 1, 'Ut enim ad minima veniam, unde omnis iste natus error sit voluptatem accusantium doloremque laudantium', '2022-06-26 09:16:03'),
  (3, 32, 12, 'Ut enim ad minima veniam, unde omnis iste natus error sit voluptatem accusantium doloremque laudantium',  '2022-06-25 10:26:13'),
  (4, 35, 2, 'Ut enim ad minima veniam, unde omnis iste natus error sit voluptatem accusantium doloremque laudantium', '2022-06-26 11:36:33'),
  (5, 41, 10, 'Ut enim ad minima veniam, unde omnis iste natus error sit voluptatem accusantium doloremque laudantium', '2022-06-23 12:46:53'),
  (6, 42, 8, 'Ut enim ad minima veniam, unde omnis iste natus error sit voluptatem accusantium doloremque laudantium', '2022-06-24 13:56:00'),
  (7, 46, 7, 'Ut enim ad minima veniam, unde omnis iste natus error sit voluptatem accusantium doloremque laudantium', '2022-06-25 14:06:01'),
  (8, 50, 11, 'Ut enim ad minima veniam, unde omnis iste natus error sit voluptatem accusantium doloremque laudantium', '2022-06-26 15:14:02'),
  (9, 55, 13, 'Ut enim ad minima veniam, unde omnis iste natus error sit voluptatem accusantium doloremque laudantium', '2022-06-27 16:23:03');
  
  
  
  
  
  /*Представления минимум 2*/
  
  -- Таблица профилей

DROP VIEW IF EXISTS users_extended;
CREATE VIEW users_extended AS 
SELECT users.id AS id, users.firstname, users.lastname, CONCAT(users.firstname, ' ', users.lastname) AS all_name, users.email, 
	   profiles.sex, profiles.birthday, profiles.country, profiles.vk_link 
  FROM users
	   LEFT JOIN profiles ON users.id = profiles.user_id;

SELECT * FROM users_extended;
  
/* возраст кандидата*/
DELIMITER //
DROP FUNCTION IF EXISTS AGE//
CREATE FUNCTION AGE(id INT)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE Y INT;
    SET Y = (SELECT timestampdiff(year,birthday, now()) FROM profiles WHERE user_id = id);
	RETURN Y;  
END//

SELECT AGE(1)//  
  
  
  
  
  /* Тригерры */

/* Cтажа и опыт работы*/

DELIMITER //
DROP TRIGGER IF EXISTS experience_control_insert//

CREATE TRIGGER experience_control_insert BEFORE INSERT ON experience
FOR EACH ROW
BEGIN
    IF NEW.start_date IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Start date cannot be NULL';
	END IF;
    
    IF NEW.end_date IS NOT NULL AND NEW.start_date > NEW.end_date THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Start date cannot be more than End date';
	END IF;
    
END//


