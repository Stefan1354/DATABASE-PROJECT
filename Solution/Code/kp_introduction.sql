DROP DATABASE IF EXISTS test_project;
CREATE DATABASE test_project;
USE test_project;

CREATE TABLE composer (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
egn CHAR(10) NOT NULL UNIQUE,
nationality VARCHAR(255) NOT NULL,
phone VARCHAR(30) NULL DEFAULT NULL,
dateOfBirth DATE NOT NULL
);


CREATE TABLE userRole (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL
);


CREATE TABLE user (
id INT AUTO_INCREMENT PRIMARY KEY,
username VARCHAR(255) NOT NULL,
password VARCHAR(255) NOT NULL,
egn CHAR(10) NOT NULL UNIQUE,
address VARCHAR(255) NOT NULL,
phone VARCHAR(30) NULL DEFAULT NULL,
isAdmin BOOLEAN DEFAULT false,
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
name VARCHAR(255) NOT NULL
);


CREATE TABLE performer (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
egn CHAR(10) NOT NULL UNIQUE,
address VARCHAR(255) NOT NULL,
phone VARCHAR(30) NULL DEFAULT NULL,
dateOfBirth DATE NOT NULL,
genre VARCHAR(100) NOT NULL  /*жанр на музиката, която изпълнява изпълнителя*/
);


CREATE TABLE albums (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
numberOfSongs INT NOT NULL,
length DECIMAL(6,2),                /*дължината на всички песни в минути и секунди*/
release_date DATE NOT NULL,
record_label VARCHAR(255) NOT NULL,  /*музикален издател или звукозаписна компания*/
performer_id INT NOT NULL,
CONSTRAINT FOREIGN KEY (performer_id) REFERENCES performer(id)
);


CREATE TABLE song (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
link VARCHAR(255) NOT NULL,
genre VARCHAR(100) NOT NULL,
style VARCHAR(100) NOT NULL,
arrangement VARCHAR(100) NOT NULL,
duration INT NOT NULL,
numberOfViews INT NOT NULL,
order_id INT NOT NULL,
category_id INT NOT NULL,
album_id INT NOT NULL,
CONSTRAINT FOREIGN KEY (order_id) REFERENCES orders(id),
CONSTRAINT FOREIGN KEY (category_id) REFERENCES category(id),
CONSTRAINT FOREIGN KEY (album_id) REFERENCES albums(id)
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


CREATE TABLE sales (
id INT AUTO_INCREMENT PRIMARY KEY,
sale_date DATE NOT NULL,
sale_price DECIMAL (10,2) NOT NULL,
song_id INT NOT NULL,
orders_id INT NOT NULL,
CONSTRAINT FOREIGN KEY (song_id) REFERENCES song(id),
CONSTRAINT FOREIGN KEY (orders_id) REFERENCES orders(id)
);

CREATE TABLE performer_song (
performer_id INT NOT NULL,
song_id INT NOT NULL,
CONSTRAINT FOREIGN KEY (performer_id) REFERENCES performer(id),
CONSTRAINT FOREIGN KEY (song_id) REFERENCES song(id)
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

INSERT INTO composer (id, name, egn, nationality, phone, dateOfBirth)
VALUES (NULL, 'Ludovico Einaudi', '1020104305', 'Italy', '+39023234567', '1955-11-23'),
	   (NULL, 'Max Richter', '2109060273', 'Germany', '+49224567890', '1966-03-22'),
	   (NULL, 'Jóhann Jóhannsson', '1203040705', 'Iceland', '+3541234567', '1969-09-19'),
	   (NULL, 'Hildur Guðnadóttir', '2104040404', 'Iceland', '+3542345678', '1982-09-04'),
	   (NULL, 'Nico Muhly', '2105050505', 'USA', '+12125551234', '1981-08-26'),
	   (NULL, 'Ólafur Arnalds', '1102065686', 'Iceland', '+3543456789', '1986-11-03'),
	   (NULL, 'Anna Meredith', '2107070707', 'UK', '+442079876543', '1978-12-17'),
       (NULL, 'Sarah Kirkland Snider', '2103050818', 'USA', '+12125678901', '1973-03-08'),
       (NULL, 'Meredith Monk', '2109490901', 'USA', '+12125671234', '1942-11-20'),
	   (NULL, 'Elena Kats-Chernin', '2110121315', 'Uzbekistan', '+61412345678', '1957-11-04'),
       (NULL, 'Nathalie Joachim', '2107112134', 'USA', '+12125672345', '1983-06-20'),
       (NULL, 'Caroline Shaw', '9212101814', 'USA', '+12125673456', '1982-08-01'),
       (NULL, 'Tigran Hamasyan', '2509431303', 'Armenia', '+37411234567', '1987-07-17'),
       (NULL, 'Judd Greenstein', '1511146414', 'USA', '+12125674567', '1979-08-21'),
       (NULL, 'Christopher Cerrone', '2010151914', 'USA', '+12125675678', '1984-01-06'),
       (NULL, 'Kaija Saariaho', '0616968676', 'Finland', '+358401234567', '1952-10-14'),
       (NULL, 'Krzysztof Penderecki', '2611101727', 'Poland', '+48123456789', '1933-11-23'),
       (NULL, 'Thomas Adès', '2106191014', 'UK', '+442079876543', '1971-03-01'),
       (NULL, 'Jennifer Higdon', '2002769191', 'USA', '+12125678901', '1962-12-31'),
       (NULL, 'Daníel Bjarnason', '1220202020', 'Iceland', '+3544567890', '1979-02-26');
       
       
INSERT INTO userRole
VALUES (NULL, 'Administrator'),
       (NULL, 'Customer');
       
       
INSERT INTO user (id, username, password, egn, address, userRole_id)
VALUES (NULL, 'John Wall', 'H@rdT0Gu3ss!', '9105010501', '123 Main Street', 2),
	   (NULL, 'Peter Bord', '5tr0ngP@55w0rd', '2301050501', 'Maple Drive 45', 2),
       (NULL, 'Sam Anton', 'S3cur3L0g1n!', '8907010701', '312 Oak Avenue', 2),
       (NULL, 'Gordon Brown', 'C0mpl3xP@55', '6701020101', '39 Pine Street', 2),
       (NULL, 'Jack Monli', 'bo&sq!#sc1', '3401010301', 'Cedar Lane 78', 2),
       (NULL, 'Harper Turner', '#1S3cur1ty', '2104010101', 'Grove Road 65', 2),
       (NULL, 'Logan Wright', 'cat1@3!5t', '0501060101', 'Sunset Boulevard 21', 2),
       (NULL, 'Penelope Allen', 'H8tuk@p0#', '0701010101', 'Vine Street 15', 2),
       (NULL, 'Ethan King', 'B#6kTf9d', '1201040101', 'Beach Drive 30', 2),
       (NULL, 'Grace Robinson', '8#vQfLj!', '0801010101', '82 Broad Street', 2),
       (NULL, 'Noah Young', '5@pCm9#x', '1101010101', '76 Cherry Lane', 2),
       (NULL, 'Avery Scott', 'Q!4rJf7d', '8201020102', 'Forest Drive 55', 2),
       (NULL, 'Lucas Thompson', 'G8bXtH#2', '3104010209', 'Garden Street 68', 2),
       (NULL, 'Emma Wright', 'P@6cMk!3', '9001090108', 'Laurel Avenue 25', 2),
       (NULL, 'Liam Davis', 'K!5rMjz',  '6601010101', '45 Meadow Lane', 2),
       (NULL, 'Zoey Barnes', 'Y8tLcG!z', '5601010101', '89 Ocean View Avenue', 2),
       (NULL, 'Austin Morris', 'B6hPfX#9', '3401010101', 'Rosewood Drive 68', 2),
       (NULL, 'Abigail Wood', 'HPjKbR7#3', '3301090901', 'Spring Street 18', 2),
       (NULL, 'Caleb Collins', 'P@#7kyl?2', '9401670701', '22 Summer Avenue', 2),
       (NULL, 'Samantha Carter', 'ZPP3-g5', '9201010101', '29 Washington Boulevard', 2),
       (NULL, 'Kevin Kim', '2@jRfH#8', '2001010101', 'Willow Way 78', 2),
       (NULL, 'Scarlett Reed', 'M9pBcT!z', '2901010101', 'Ash Street 99', 2),
       (NULL, 'Joshua Flores', '1#jGhTc$', '7101010101', 'Birch Lane 720', 2),
       (NULL, 'Avery Murray', '5gf!zv35', '3601010101', '720 Chestnut Street', 2),
       (NULL, 'Brandon Ortiz', 'H7tYk@p#', '4101010101', '454 Dogwood Drive', 2),
       (NULL, 'Ella Coleman', 'mQ8zWj!5', '2101010101', 'East Avenue 060', 2),
       (NULL, 'Christopher Nelson', '3$gDcL@7', '8101010101', '77 Fern Road', 2),
       (NULL, 'Addison Reyes', 'B@!6yTz9a', '9148010101', '44 Grand Avenue', 2),
       (NULL, 'Ryan Mitchell', 'Fp9yLc$6', '9143011101', '92 Ivy Lane', 2),
       (NULL, 'Lily Campbell', 'zX5bRq!8', '9101010900', '88 Juniper Street', 2),
       (NULL, 'Gabriel Ramirez', 'J$4wNf#m', '9001001019', '65 Kings Road', 2),
       (NULL, 'Harper Foster', '7!sTbRy#', '6901013104', 'Lakeside Drive 99', 2),
       (NULL, 'Jonathan Cooper', 'E9fMhZ#8', '6701010101', 'Magnolia Lane 32', 2),
       (NULL, 'Natalie Parker', 'tY5nCj!2', '4501010101', 'North Street 45', 2),
       (NULL, 'Samuel Hill', 'P@8rKm#7', '2701010101', '323 Main Street', 2),
       (NULL, 'Madison Turner', 'gX6pVt!z', '3205060708', '505 Orchard Road', 2),
       (NULL, 'Joseph Wright', '4$dNkP#j', '0101030303', '707 Pineview Drive', 2),
       (NULL, 'Chloe Adams', 'Q8zHfL!7', '5409901017', '987 Quarry Lane', 2),
       (NULL, 'Alexander Green', '6#jBpCt$', '6301010121', 'Redwood Avenue 055', 2),
       (NULL, 'Grace Mitchell', 'U5dKmF!7', '8201010131', 'South Avenue 989', 2),
       (NULL, 'Nicholas Baker', 'R!2kNf#m', '0101010111', 'Terrace Place 878', 2),
       (NULL, 'Amelia Clark', '1#jGhTc$', '7101010212', 'Union Street 653', 2),
       (NULL, 'Benjamin Lewis', 'S6tRyK!z', '3101010303', 'Valley Road 677', 2),
       (NULL, 'Harper Gonzalez', 'A#1qPf9k', '4501010333', 'West Street 011', 2),
       (NULL, 'Andrew Perez', 'wY9bLj!3', '3701010999', '133 York Street ', 2),
       (NULL, 'Charlotte Davis', 'D3kFmZ$6', '7901010176', 'Xanadu Lane 434', 2),
       (NULL, 'Matthew Thomas', '2@jRfH#8', '0801010530', 'High Street 588', 2),
       (NULL, 'Mia Johnson', 'M9pBcT!z', '9101010340', 'Park Avenue 219', 2),
       (NULL, 'Daniel Taylor', '8#vQfLj!', '2201020712', '657 Elm Street', 2),
       (NULL, 'Isabella Hernandez', 'F7nGkP!z', '3403740310', '988 Academy Street', 2);
	
INSERT INTO user (id, username, password, egn, address, phone, isAdmin, userRole_id)
VALUES (NULL, 'Jo Lee', '#235-vgd2', '2992093467', 'Cedar Street, St. Louis 454', '0821934569', true, 1);


INSERT INTO orders (order_date, price, payment_status, delivery_status, user_id) 
VALUES ('2022-03-14', 50.00, 'paid', 'delivered', 1),
       ('2022-03-15', 20.00, 'paid', 'not delivered', 2),
       ('2022-03-15', 75.00, 'not paid', 'not delivered', 3),
       ('2022-03-16', 35.50, 'paid', 'delivered', 4),
       ('2022-03-17', 15.00, 'not paid', 'not delivered', 5),
       ('2022-03-18', 160.00, 'not paid', 'not delivered', 6),
       ('2022-03-18', 100.00, 'paid', 'delivered', 7),
       ('2022-03-18', 80.00, 'paid', 'delivered', 7),
       ('2022-03-18', 90.00, 'paid', 'delivered', 8),
       ('2022-03-18', 95.00, 'not paid', 'not delivered', 9),
       ('2022-03-18', 76.00, 'paid', 'delivered', 10),
       ('2022-03-18', 42.00, 'not paid', 'not delivered', 11),
       ('2022-03-18', 21.00, 'not paid', 'not delivered', 12),
       ('2022-03-18', 32.00, 'not paid', 'not delivered', 13),
       ('2022-03-18', 86.00, 'paid', 'delivered', 14),
       ('2022-03-18', 64.00, 'paid', 'delivered', 15),
       ('2022-03-18', 62.00, 'paid', 'delivered', 16),
       ('2022-03-18', 61.00, 'not paid', 'not delivered', 17),
       ('2022-03-18', 59.00, 'not paid', 'not delivered', 18),
       ('2022-04-19', 31.00, 'paid', 'delivered', 19),
       ('2022-04-19', 99.00, 'paid', 'delivered', 20),
       ('2022-04-19', 76.00, 'not paid', 'not delivered', 21),
       ('2022-04-19', 60.00, 'not paid', 'not delivered', 22),
       ('2022-04-20', 60.00, 'not paid', 'not delivered', 23),
       ('2022-04-20', 60.00, 'not paid', 'not delivered', 24),
       ('2022-04-20', 260.00, 'paid', 'delivered', 25),
       ('2022-04-20', 160.00, 'paid', 'delivered', 26),
       ('2022-04-21', 30.00, 'paid', 'delivered', 27),
       ('2022-04-21', 50.00, 'paid', 'delivered', 28),
       ('2022-04-21', 40.00, 'paid', 'delivered', 29),
       ('2022-04-22', 70.00, 'paid', 'delivered', 30),
       ('2022-04-22', 80.00, 'paid', 'delivered', 31),
       ('2022-04-22', 60.00, 'paid', 'delivered', 32),
       ('2022-04-22', 60.00, 'not paid', 'not delivered', 33),
       ('2022-04-25', 60.00, 'paid', 'delivered', 34),
       ('2022-04-25', 98.00, 'paid', 'delivered', 35),
       ('2022-04-25', 31.00, 'paid', 'delivered', 36),
       ('2022-04-25', 32.00, 'paid', 'delivered', 37),
       ('2022-04-25', 45.00, 'paid', 'delivered', 38),
       ('2022-04-25', 54.00, 'paid', 'delivered', 39),
       ('2022-04-25', 66.00, 'paid', 'delivered', 40),
       ('2022-04-25', 89.00, 'not paid', 'not delivered', 41),
       ('2022-04-25', 24.00, 'not paid', 'not delivered', 42),
       ('2022-04-25', 38.00, 'not paid', 'not delivered', 42),
       ('2022-04-25', 32.00, 'paid', 'delivered', 43),
       ('2022-04-25', 42.00, 'paid', 'delivered', 44),
       ('2022-04-25', 96.00, 'paid', 'delivered', 45),
       ('2022-04-26', 78.00, 'paid', 'delivered', 46),
       ('2022-04-26', 91.00, 'not paid', 'not delivered', 47),
       ('2022-04-27', 83.00, 'paid', 'delivered', 48),
	   ('2022-04-27', 83.00, 'paid', 'delivered', 48),
       ('2022-04-27', 83.00, 'paid', 'delivered', 48),
	   ('2022-04-28', 83.00, 'paid', 'delivered', 49),
       ('2022-04-28', 83.00, 'paid', 'delivered', 50);
