DROP DATABASE IF EXISTS test_project;
CREATE DATABASE test_project;
USE test_project;

CREATE TABLE composer (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
egn CHAR(10) NOT NULL UNIQUE,
address VARCHAR(255) NOT NULL,
phone VARCHAR(30) NULL DEFAULT NULL,
dateOfBirth DATE NOT NULL
);


CREATE TABLE userRole (
id INT AUTO_INCREMENT PRIMARY KEY,
name ENUM('Administrator', 'Customer', 'Author')
);


CREATE TABLE user (
id INT AUTO_INCREMENT PRIMARY KEY,
username VARCHAR(255) NOT NULL,
password VARCHAR(255) NOT NULL,
egn CHAR(10) NOT NULL UNIQUE,
address VARCHAR(255) NOT NULL,
phone VARCHAR(30) NULL DEFAULT NULL,
userRole_id INT NOT NULL,
CONSTRAINT FOREIGN KEY (userRole_id) REFERENCES userRole(id)
);


CREATE TABLE orders (
id INT AUTO_INCREMENT PRIMARY KEY,
order_date DATE NOT NULL,                /*дата на поръчката*/
price DECIMAL(6,2) NOT NULL,             /*общата цена на поръчката*/
payment_status VARCHAR(100) NOT NULL,    /*статус на плащането*/
delivery_status VARCHAR(100) NOT NULL,   /*статус на доставката*/
user_id INT NOT NULL,
CONSTRAINT FOREIGN KEY (user_id) REFERENCES user(id)
);


CREATE TABLE category (                        /*в тази таблица ще съхраняваме категориите на песните в сайта*/
id INT AUTO_INCREMENT PRIMARY KEY,
name ENUM('Pop', 'Hip-hop', 'Folk', 'Rock', 'Classical') NOT NULL
);


CREATE TABLE song (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
link VARCHAR(255) NOT NULL,               /*линк на песента в youtube примерно*/
genre VARCHAR(100) NOT NULL,              /*жанр на песента*/
style VARCHAR(100) NOT NULL,              /*стил на песента*/
arrangement VARCHAR(100) NOT NULL,        /*аранжимент*/ 
duration INT NOT NULL,                    /*продължителност*/
numberOfViews INT NOT NULL,               /*брой гледания*/
order_id INT NOT NULL,
category_id INT NOT NULL,
CONSTRAINT FOREIGN KEY (order_id) REFERENCES orders(id),
CONSTRAINT FOREIGN KEY (category_id) REFERENCES category(id)
);


CREATE TABLE reviews (
id INT AUTO_INCREMENT PRIMARY KEY,
rating DECIMAL(10,2) NOT NULL,     /*рейтинг на песента между 0 и 10*/
comment TEXT NOT NULL,             /*добавен коментар към рецензията*/
review_date DATE NOT NULL,         /*дата на добавяне на рецензията*/
user_id INT NOT NULL,
song_id INT NOT NULL,
CONSTRAINT FOREIGN KEY (user_id) REFERENCES user(id),
CONSTRAINT FOREIGN KEY (song_id) REFERENCES song(id)
);


CREATE TABLE performer (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
egn CHAR(10) NOT NULL UNIQUE,
addres VARCHAR(255) NOT NULL,
phone VARCHAR(30) NULL DEFAULT NULL,
dateOfBirth DATE NOT NULL,
genre VARCHAR(100) NOT NULL,  /*жанр на музиката, която изпълнява изпълнителя*/
song_id INT NOT NULL,
CONSTRAINT FOREIGN KEY (song_id) REFERENCES song(id)
);


CREATE TABLE albums (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
numberOfSongs INT NOT NULL,          /*брой на всички песни в албума*/
length DECIMAL(4,2),                 /*дължината на всички песни в минути и секунди*/
release_date DATE NOT NULL,          /*дата на издаване*/
record_label VARCHAR(255) NOT NULL,  /*музикален издател или звукозаписна компания*/
performer_id INT NOT NULL,
CONSTRAINT FOREIGN KEY (performer_id) REFERENCES performer(id)
);


CREATE TABLE sales (
id INT AUTO_INCREMENT PRIMARY KEY,
sale_date DATE NOT NULL,              /*дата на продажбата*/
sale_price DECIMAL (10,2) NOT NULL,   /*цена на продажбата*/
song_id INT NOT NULL,
orders_id INT NOT NULL,
CONSTRAINT FOREIGN KEY (song_id) REFERENCES song(id),
CONSTRAINT FOREIGN KEY (orders_id) REFERENCES orders(id)
);


CREATE TABLE composer_songs (
composer_id INT NOT NULL,
song_id INT NOT NULL,
CONSTRAINT FOREIGN KEY (composer_id) REFERENCES composer(id),
CONSTRAINT FOREIGN KEY (song_id) REFERENCES song(id),
PRIMARY KEY (composer_id, song_id)
);


CREATE TABLE composer_albums (
composer_id INT NOT NULL,
album_id INT NOT NULL,
CONSTRAINT FOREIGN KEY (composer_id) REFERENCES composer(id),
CONSTRAINT FOREIGN KEY (album_id) REFERENCES albums(id),
PRIMARY KEY (composer_id, album_id)
);
