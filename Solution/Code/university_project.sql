DROP DATABASE IF EXISTS songs_sales;
CREATE DATABASE songs_sales;
USE songs_sales;

CREATE TABLE composer (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
egn CHAR(10) NOT NULL UNIQUE,
nationality VARCHAR(255) NOT NULL,
phone VARCHAR(30) NULL DEFAULT NULL,
dateOfBirth DATE NOT NULL
);


CREATE TABLE userRole (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL
);


CREATE TABLE user (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
username VARCHAR(255) NOT NULL,
password VARCHAR(255) NOT NULL,
egn CHAR(10) NOT NULL UNIQUE,
address VARCHAR(255) NOT NULL,
phone VARCHAR(30) NULL DEFAULT NULL,
userRole_id INT UNSIGNED NOT NULL,
CONSTRAINT FOREIGN KEY (userRole_id) REFERENCES userRole(id)
);


CREATE TABLE orders (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
order_date DATE NOT NULL,                /*дата на поръчката*/
price DECIMAL(6,2) NOT NULL,             /*общата цена на поръчката*/
payment_status VARCHAR(100) NOT NULL,    /*статус на плащането*/
delivery_status VARCHAR(100) NOT NULL,   /*статус на доставката*/
user_id INT UNSIGNED NOT NULL,
CONSTRAINT FOREIGN KEY (user_id) REFERENCES user(id)
);


CREATE TABLE playlists (          /*плейлисти на потребителите*/
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,       /*името, което е дал потребителя на плейлистата*/
songCount INT UNSIGNED NOT NULL   /*брой на песните в плейлистата*/
);


CREATE TABLE genre (              /*в тази таблица ще съхраняваме жанровете на песните в сайта*/
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL
);


CREATE TABLE performer (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
egn CHAR(10) NOT NULL UNIQUE,
address VARCHAR(255) NOT NULL,
phone VARCHAR(30) NULL DEFAULT NULL,
dateOfBirth DATE NOT NULL
);


CREATE TABLE albums (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(255) NOT NULL,
numberOfSongs INT NOT NULL,
length DECIMAL(6,2),                 /*дължината на всички песни в минути и секунди*/
release_date DATE NOT NULL,          /*дата на излизане*/
record_label VARCHAR(255) NOT NULL,  /*музикален издател или звукозаписна компания*/
performer_id INT UNSIGNED NOT NULL,
CONSTRAINT FOREIGN KEY (performer_id) REFERENCES performer(id)
);


CREATE TABLE song (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
link VARCHAR(255) NOT NULL,
style VARCHAR(100) NOT NULL,
arrangement VARCHAR(100) NOT NULL,
duration INT UNSIGNED NOT NULL,
numberOfViews BIGINT UNSIGNED NOT NULL,   /*брой на гледания на песента в платформата Youtube*/
album_id INT UNSIGNED NOT NULL,
CONSTRAINT FOREIGN KEY (album_id) REFERENCES albums(id)
);


CREATE TABLE reviews (             /*таблица за рецензии от страна на потребителите*/
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
rating DECIMAL(10,2) NOT NULL,     /*рейтинг на албума между 0 и 10*/
comment TEXT NOT NULL,             /*добавен коментар към рецензията*/
review_date DATE NOT NULL,         /*дата на добавяне на рецензията*/
user_id INT UNSIGNED NOT NULL,
album_id INT UNSIGNED NOT NULL,
CONSTRAINT FOREIGN KEY (user_id) REFERENCES user(id),
CONSTRAINT FOREIGN KEY (album_id) REFERENCES albums(id)
);


CREATE TABLE sales (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
sale_date DATE NOT NULL,
sale_price DECIMAL (10,2) NOT NULL,
orders_id INT UNSIGNED NOT NULL,      /*една поръчка може да съдържа много продажби, но всяка продажба се отнася до една конкретна поръчка*/
CONSTRAINT FOREIGN KEY (orders_id) REFERENCES orders(id)
);


CREATE TABLE performer_song (
performer_id INT UNSIGNED NOT NULL,
song_id INT UNSIGNED NOT NULL,
CONSTRAINT FOREIGN KEY (performer_id) REFERENCES performer(id),
CONSTRAINT FOREIGN KEY (song_id) REFERENCES song(id)
);


CREATE TABLE performer_genre (   /*кои жанрове изпълнява даден изпълнител*/
performer_id INT UNSIGNED NOT NULL,
genre_id INT UNSIGNED NOT NULL,
CONSTRAINT FOREIGN KEY (performer_id) REFERENCES performer(id),
CONSTRAINT FOREIGN KEY (genre_id) REFERENCES genre(id)
);


CREATE TABLE song_genre (       /*една песен може да принадлежи на повече жанра и обратно*/
song_id INT UNSIGNED NOT NULL,
genre_id INT UNSIGNED NOT NULL,
CONSTRAINT FOREIGN KEY (song_id) REFERENCES song(id),
CONSTRAINT FOREIGN KEY (genre_id) REFERENCES genre(id)
);


CREATE TABLE composer_song (
composer_id INT UNSIGNED NOT NULL,
song_id INT UNSIGNED NOT NULL,
CONSTRAINT FOREIGN KEY (composer_id) REFERENCES composer(id),
CONSTRAINT FOREIGN KEY (song_id) REFERENCES song(id),
PRIMARY KEY (composer_id, song_id)
);


CREATE TABLE composer_albums (
composer_id INT UNSIGNED NOT NULL,
album_id INT UNSIGNED NOT NULL,
CONSTRAINT FOREIGN KEY (composer_id) REFERENCES composer(id),
CONSTRAINT FOREIGN KEY (album_id) REFERENCES albums(id),
PRIMARY KEY (composer_id, album_id)
);


CREATE TABLE album_genre (
album_id INT UNSIGNED NOT NULL,
genre_id INT UNSIGNED NOT NULL,
CONSTRAINT FOREIGN KEY (album_id) REFERENCES albums(id),
CONSTRAINT FOREIGN KEY (genre_id) REFERENCES genre(id)
);


CREATE TABLE playlist_album (
playlist_id INT UNSIGNED NOT NULL,
album_id INT UNSIGNED NOT NULL,
CONSTRAINT FOREIGN KEY (playlist_id) REFERENCES playlists(id),
CONSTRAINT FOREIGN KEY (album_id) REFERENCES albums(id)
);


CREATE TABLE playlist_user (  /*един user може да си направи много плейлисти и обратно */
playlist_id INT UNSIGNED NOT NULL,
user_id INT UNSIGNED NOT NULL,
CONSTRAINT FOREIGN KEY (playlist_id) REFERENCES playlists(id),
CONSTRAINT FOREIGN KEY (user_id) REFERENCES user(id)
);


CREATE TABLE playlist_order (  /*една плейлиста може да се поръча много пъти и обратно*/
playlist_id INT UNSIGNED NOT NULL,
order_id INT UNSIGNED NOT NULL,
CONSTRAINT FOREIGN KEY (playlist_id) REFERENCES playlists(id),
CONSTRAINT FOREIGN KEY (order_id) REFERENCES orders(id)
);


CREATE TABLE user_album (  /*потребителите могат да поръчат и албуми*/
user_id INT UNSIGNED NOT NULL,
album_id INT UNSIGNED NOT NULL,
CONSTRAINT FOREIGN KEY (user_id) REFERENCES user(id),
CONSTRAINT FOREIGN KEY (album_id) REFERENCES albums(id)
);


CREATE TABLE sale_album (
sale_id INT UNSIGNED NOT NULL,
album_id INT UNSIGNED NOT NULL,
CONSTRAINT FOREIGN KEY (sale_id) REFERENCES sales(id),
CONSTRAINT FOREIGN KEY (album_id) REFERENCES albums(id)
);
