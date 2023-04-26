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


INSERT INTO composer (name, egn, nationality, phone, dateOfBirth) 
VALUES ('Johann Sebastian Bach', '0912934563', 'German', NULL, '1685-03-21'),
	   ('Ed Sheeran', '0342673901', 'British', '550-0673', '1991-02-17'),
	   ('Toots Thielemans', '0067890123', 'German', NULL, '1922-04-29'),
       ('Manu Chao', '3450729113', 'French', '645-2480', '1961-06-21'),
	   ('Freddie Mercury', '0608901230', 'British', NULL, '1946-09-05'),
	   ('Igor Stravinsky', '6789012345', 'Russian', NULL, '1882-06-17'),
	   ('Drake', '7890123050', 'American', '535-8903', '1986-10-24'),
	   ('Maurice Ravel', '8901934560', 'French', NULL, '1875-03-07'),
	   ('Kanye West', '9012341638', 'American', '989-0909', '1906-09-25'),
	   ('John Williams', '9897866540', 'American', '555-2468', '1932-02-08'),
	   ('Philip Glass', '2146570901', 'American', '089-3221', '1937-01-31'),
	   ('Elvis Presley', '0459789032', 'American', NULL, '1935-01-08');


INSERT INTO userRole
VALUES (NULL, 'Admin'),
       (NULL, 'Customer');


INSERT INTO user (username, password, egn, address, phone, userRole_id)
VALUES ('John Brown', 'H@rdT0Gu3ss!', '0123426739', '123 Main St, Anytown', '353-1333', 2),
	   ('Jane Lee', '5tr0ngP@55w0rd', '2305673902', '21 Oak Ave, Otherville', NULL, 2),
	   ('Oleg Smirnov', 'cat1@3!?5t', '3251789913', '34 Elm St, Somewhere', '757-1629', 2),
	   ('Sara Ali', 'tY5nCj!1', '1567390224', '78 Pine Rd, Anytown', NULL, 2),
	   ('Mike Durant', 'P@8rKm#7', '5378101237', '21 Maple Dr, Otherville', '252-4424', 2),
	   ('Bob Wilson', 'Q8zHfL!7a', '9782032300', '21A Cedar Ave, Somewhere', NULL, 2),
	   ('Ana Petkova', '8#vQfLj!', '1890223959', '32B Oak St, Anytown', '607-8780', 2),
	   ('Robert James', 'M9pBcT!z', '8901257547', '87A Birch Ln, Otherville', NULL, 2),
	   ('Ekaterina Valova', '1#jGHTk$', '9012245778', '133 Elm St, Somewhere', '989-3460', 2),
	   ('Beatris Grivardis', 'F7nGkP!z', '0103459701', '454 Maple Ave, Anytown', NULL, 1);


INSERT INTO orders (order_date, price, payment_status, delivery_status, user_id)
VALUES ('2023-03-25', 10.50, 'paid', 'delivered', 1),
       ('2023-03-26', 25.80, 'paid', 'delivered', 2),
       ('2023-03-26', 42.00, 'paid', 'delivered', 2),
       ('2023-03-27', 15.00, 'paid', 'delivered', 3),
       ('2023-04-03', 56.30, 'paid', 'in transit', 4),
       ('2023-04-04', 12.75, 'paid', 'in transit', 5),
	   ('2023-04-07', 37.20, 'pending', 'in transit', 5),
       ('2023-04-07', 19.90, 'paid', 'in transit', 5),
       ('2023-04-07', 82.60, 'paid', 'in transit', 6),
       ('2023-04-10', 45.30, 'paid', 'delivered', 7),
       ('2023-04-10', 45.30, 'paid', 'delivered', 8),
       ('2023-04-12', 45.30, 'pending', 'delivered', 9),
       ('2023-04-15', 45.30, 'pending', 'not shipped', 10);
       
       
INSERT INTO playlists (name, songCount) 
VALUES ('Rock Anthems', 15),
       ('Hip Hop Bangers', 12),
       ('Jazz Classics', 10),
       ('Chill Vibes', 8),
       ('Party Mix', 20),
       ('Road Trip Tunes', 18),
       ('Pop Hits', 14),
       ('Workout playlist', 16),
       ('Oldies But Goodies', 10),
       ('Country Favorites', 12);
       
       
INSERT INTO genre
VALUES (NULL, 'Pop'),
       (NULL, 'Pop-punk'),
       (NULL ,'Hip-hop'),
       (NULL, 'Trip-hop'),
       (NULL, 'Jazz'),
       (NULL, 'Jazz fusion'),
       (NULL, 'Rock'),
       (NULL, 'Funk-rock');
       
       
INSERT INTO performer
VALUES (NULL, 'Drake', '9124656742', '111 Pine St San Francisco, CA 94111', '098-4265', '1986-10-24'),
       (NULL, 'Future', '9219309213', '456 Oak Ave Springfield, USA', '099-4372', '1990-02-16'),
       (NULL, 'Jimi Hendrix', '9029831092', '1111 Maple Ln Anytown, USA', '218-3890', '1942-11-27'),
       (NULL, 'Ed Sheeran', '2909719423', '9999 Cedar Dr Anytown, USA', '012-4567', '1991-02-17'),
	   (NULL, 'Eric Clapton', '3053210991', '7879 Oak Ln Springfield, USA', NULL, '1945-03-30'),
       (NULL, 'Louis Armstrong', '2907980123', '2525 Pine Ln Springfield, USA', '128-4355', '1901-08-04'),
       (NULL, 'Lil Nas X', '9908978213', '2020 Pine Dr Anytown, USA', NULL, '1999-04-09'),
       (NULL, 'Michael Jackson', '8909234560', '2222 Oak Ave Anytown, USA', '099-4369', '1958-08-29'),
       (NULL, 'Miles Davis', '3202428290', '5555 Pine Ln Anytown, USA', '198-5141', '1926-05-26'),
       (NULL, 'Macklemore', '4545009877', '6767 Cedar Rd Anytown, USA', NULL, '1983-06-19'),
       (NULL, 'Kanye West', '9012341638', '2727 Oak St Springfield, USA', '108-4362', '1906-09-25'),
       (NULL, 'John Legend', '3402921045', '2424 Birch Ct Anytown, USA', '028-1285', '1978-12-28'),
       (NULL, 'Billie Holiday', '3003210981', '7878 Oak Ln Springfield, USA', NULL,  '1915-07-17'),
	   (NULL, 'Joseph Satriani', '3059210292', '7880 Oak Ln Springfield, USA', '201-4369', '1956-07-15');       


INSERT INTO albums
VALUES (NULL, 'High Off Life', 21, 80.20, '2020-05-15', 'Republic Records', 1),
       (NULL, 'Are You Experienced', 8, 42.39, '1969-10-22', 'Atlantic Records', 3),
       (NULL, 'Divide', 11, 50.13, '2017-03-03', 'Asylum', 4),
       (NULL, 'GEMINI', 16, 60.13, '2017-09-22', 'Bendo LLC', 10),
	   (NULL, 'The Orange Room', 15, 55.29, '2005-03-01', 'Sheeran Lock', 4),
	   (NULL, '7', 15, 43.29, '2021-09-17', 'Columbia Records', 7),
       (NULL, 'Thriller', 9, 42.19, '1982-11-30', 'Epic Records', 8),
       (NULL, 'Kind of Blue', 5, 45.52, '1959-08-17', 'Columbia Records', 9),
       (NULL, 'Scorpion', 25, 89.04, '2018-06-29', 'Cash Money Records', 1),
       (NULL, 'Future', 19, 66.14, '2017-02-17', 'Interscope Records', 2),
	   (NULL, 'Graduation', 13, 51.23, '2008-08-19', 'KonLive', 11),
	   (NULL, 'Wake Up', 13, 51.23, '2008-08-19', 'Domino Recording Company', 12),
	   (NULL, 'All or Nothing at All', 15, 32.14, '1938-08-19', 'Sony Music', 13),
	   (NULL, 'The Elephants of Mars', 10, 59.14, '1938-08-19', 'Universal Music Group', 14),
	   (NULL, 'Hello Dolly', 11, 40.14, '1938-08-19', 'Warner Music', 6),
	   (NULL, 'Journeyman', 12, 42.32, '1938-08-19', 'XL Recordings', 5);
       
       
       
INSERT INTO song
VALUES (NULL ,'Shape Of You', 'https://www.youtube.com/watch?v=JGwWNGJdvx8', 'Pop', 'R&B', 263, 5900000000, 3),
       (NULL, 'Life Is Good', 'https://www.youtube.com/watch?v=l0U7SxXHkPY', 'Hip-hop', 'Trap', 237, 2100050978, 1),
	   (NULL, 'Hard Times', 'https://www.youtube.com/watch?v=uuB1d4Jn5H8&list=PLbGuJX1GQkodSan5SUi0k6i89hGTz9fjL', 'Rock', 'Blues Rock', 157, 345600000, 16),
       (NULL, 'Stronger', 'https://www.youtube.com/watch?v=PsO6ZnUZI0g', 'Hip-hop', 'Electronic', 246, 450908795, 11),
       (NULL, 'Thrift Shop', 'https://www.youtube.com/watch?v=QK8mJJJvaes', 'Hip-hop', 'Comedy Rap', 432, 345698098, 4),
       (NULL, 'Fire', 'https://www.youtube.com/watch?v=cbG7HEEPE1o&list=PL1RRNXldMeRFm7CqtN44oav-TgaWT3yt_', 'Hard rock', 'Electronic', 278, 4500989, 2),
       (NULL, 'Billie Jean', 'https://www.youtube.com/watch?v=Zi_XLOBDo_Y', 'Pop', 'Drum machines', 321, 123456432, 7),
	   (NULL, 'Old Town Road', 'https://www.youtube.com/watch?v=w2Ov5jzm3j8', 'Pop', 'Electronic', 157, 345600000, 6),
       (NULL, 'Addicted', 'https://www.youtube.com/watch?v=6YS03WG2t1Q&list=PLT3w2jU3eU6nF1HzjTtKYzvMhJIvfQ8me', 'Latin Pop', 'Piano', 320, 10500321, 5),
	   (NULL, 'Sweet Child O Mine', 'https://www.youtube.com/watch?v=1w7OgIMMRc4', 'Hard rock', 'Electronic', 454, 1234000989, 16),
       (NULL, 'So What', 'https://www.youtube.com/watch?v=ylXk1LBvIqU&list=PLrhkpF1bKMG_D2sxTpxG63WGmIxYGB-Jt', 'Pop rock', 'Electronic', 220, 415609909, 8),
       (NULL, 'Someday', 'https://www.youtube.com/watch?v=ayxLRvQOni0&list=PL0a-3E47mvaZsK839s_pQSICTPnfKGGT9&index=5', 'Pop', 'Electronic', 640, 350000, 15),
       (NULL, 'Ten Million', 'https://www.youtube.com/watch?v=24cCemVI1CY&list=PLCJjdqofvBsUJzotAzzXSxleSnjZpUCXp&index=10', 'Hip-hop', 'Electronic', 179, 1100000, 5),
       (NULL, 'In My Feelings', 'https://www.youtube.com/watch?v=DRS_PpOrUZ4', 'Hip-Hop', 'Electronic', 217, 160000000, 1),
       (NULL, 'Stairway To Heaven', 'https://www.youtube.com/watch?v=QkF3oxziUI4', 'Rock', 'Electronic', 481, 56000000, 2),
       (NULL, 'All of Me', 'https://www.youtube.com/watch?v=450p7goxZqg', 'Pop', 'Electronic', 468, 2000000, 12),
	   (NULL, 'Sahara', 'https://www.youtube.com/watch?v=q9HCGqByjak', 'Pop', 'Electronic', 679, 125000, 14),
	   (NULL, 'Nonstop', 'https://www.youtube.com/watch?v=XNpGNykVZ6U&list=PLnHe1KWzAptFfF5UTOSuZWsCI2EXz_PHF&index=3', 'Hip-hop', 'Electronic', 389, 203200430, 9),
	   (NULL, 'Zoom', 'https://www.youtube.com/watch?v=q9HCGqByjak', 'Hip-hop', 'Electronic', 325, 20200300, 10),
	   (NULL, 'But Not For Me', 'https://www.youtube.com/watch?v=TUVdBKsgq2o', 'Jazz', 'Electronic', 232, 125000, 13);

	
INSERT INTO reviews (id, rating, comment, review_date, user_id, album_id)
VALUES (NULL, 8.5, 'Great album, loved it!', '2023-02-20', 1, 1),
       (NULL, 7.2, 'Not their best work, but still enjoyable', '2023-02-21', 2, 3),
       (NULL, 9.1, 'Incredible album, definitely a masterpiece', '2023-03-10', 3, 4),
       (NULL, 5.5, 'Not my cup of tea, but some may enjoy it', '2023-03-15', 4, 5),
       (NULL, 6.9, 'Solid album, nothing too groundbreaking', '2023-03-20', 5, 6),
       (NULL, 8.8, 'One of my favorite albums of all time', '2023-03-22', 6, 7),
       (NULL, 4.3, 'Disappointing album, expected more from this artist', '2023-03-25', 7, 8),
       (NULL, 9.5, 'Absolutely amazing album, highly recommend', '2023-04-05', 8, 9),
       (NULL, 7.8, 'Good album, but not as good as their previous work', '2023-04-10', 9, 10),
	   (NULL, 6.1, 'Not a fan of this album, couldn''t get into it', '2023-04-12', 10, 11);  
       
       
INSERT INTO sales (sale_date, sale_price, orders_id) 
VALUES ('2023-03-01', 49.99, 1),
	   ('2023-03-01', 29.99, 2),
       ('2023-03-05', 99.99, 3),
	   ('2023-03-11', 19.99, 4),
	   ('2023-03-12', 39.99, 5),
	   ('2023-04-05', 79.99, 6),
	   ('2023-04-11', 89.99, 7),
	   ('2023-04-12', 69.99, 8),
	   ('2023-04-15', 59.99, 9),
	   ('2023-04-15', 109.99, 10);
       
       
INSERT INTO performer_song
VALUES (4, 1),
       (4, 9),
       (10, 6),
       (11, 6);
       
INSERT INTO performer_genre
VALUES (1, 3),
       (1, 4),
       (1, 4),
       (2, 4);
       
INSERT INTO song_genre
VALUES (5, 1),
       (5, 2),
       (5, 3),
       (6, 3);
       

INSERT INTO composer_song
VALUES (3, 9),
       (3, 11),
       (10, 2),
       (11, 2);


INSERT INTO composer_albums 
VALUES (2, 4),
       (3, 4),
	   (12, 3),
	   (12, 5);
       
INSERT INTO album_genre
VALUES (1, 3),
       (1, 4),
	   (5, 6),
	   (6, 6);

INSERT INTO playlist_album
VALUES (2, 1),
	   (2, 13),
       (1, 2),
       (1, 2);
       
INSERT INTO playlist_user
VALUES (2, 3),
	   (2, 4),
       (7, 5),
       (8, 5);
       
INSERT INTO playlist_order
VALUES (6, 1),
       (6, 3),
       (8, 2),
       (10, 2);

INSERT INTO user_album
VALUES (10, 1),
       (10, 5),
       (2, 7),
       (4, 7);
       
INSERT INTO sale_album
VALUES (4, 2),
	   (4, 3),
       (7, 5),
	   (9, 5);
