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
name ENUM('Pop', 'Hip-hop', 'Folk', 'Rock') NOT NULL
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
numberOfSongs INT NOT NULL,
length DECIMAL(4,2),                /*дължината на всички песни в минути и секунди*/
release_date DATE NOT NULL,
record_label VARCHAR(255) NOT NULL,  /*музикален издател или звукозаписна компания*/
performer_id INT NOT NULL,
CONSTRAINT FOREIGN KEY (performer_id) REFERENCES performer(id)
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


INSERT INTO composer (name, egn, nationality, phone, dateOfBirth)
VALUES ('Ludovico Einaudi', '1010104305', 'Italy', '+39023234567', '1955-11-23'),
	   ('Max Richter', '2109080272', 'Germany', '+49224567890', '1966-03-22'),
	   ('Jóhann Jóhannsson', '1203080903', 'Iceland', '+3541234567', '1969-09-19'),
	   ('Hildur Guðnadóttir', '2104040404', 'Iceland', '+3542345678', '1982-09-04'),
	   ('Nico Muhly', '2105050505', 'USA', '+12125551234', '1981-08-26'),
	   ('Ólafur Arnalds', '1102065686', 'Iceland', '+3543456789', '1986-11-03'),
	   ('Anna Meredith', '2107070707', 'UK', '+442079876543', '1978-12-17'),
       ('Sarah Kirkland Snider', '2103050818', 'USA', '+12125678901', '1973-03-08'),
       ('Meredith Monk', '2109490901', 'USA', '+12125671234', '1942-11-20'),
	   ('Elena Kats-Chernin', '2110121315', 'Uzbekistan', '+61412345678', '1957-11-04'),
       ('Nathalie Joachim', '2107112134', 'USA', '+12125672345', '1983-06-20'),
       ('Caroline Shaw', '9212101814', 'USA', '+12125673456', '1982-08-01'),
       ('Tigran Hamasyan', '2509431303', 'Armenia', '+37411234567', '1987-07-17'),
       ('Judd Greenstein', '1511146414', 'USA', '+12125674567', '1979-08-21'),
       ('Christopher Cerrone', '2010151914', 'USA', '+12125675678', '1984-01-06'),
       ('Kaija Saariaho', '0616968676', 'Finland', '+358401234567', '1952-10-14'),
       ('Krzysztof Penderecki', '2611101727', 'Poland', '+48123456789', '1933-11-23'),
       ('Thomas Adès', '2106191014', 'UK', '+442079876543', '1971-03-01'),
       ('Jennifer Higdon', '2002769191', 'USA', '+12125678901', '1962-12-31'),
       ('Daníel Bjarnason', '1220202020', 'Iceland', '+3544567890', '1979-02-26'),
       ('Gabriel Prokofiev', '2121212121', 'UK', '+442079876543', '1975-06-11'),
       ('Mason Bates', '2902228262', 'USA', '+14152345678', '1977-01-23'),
       ('Chaya Czernowin', '2123232323', 'Israel', '+972523', '1957-12-07'),
       ('Ludwig Göransson', '1212001121', 'Sweden', '+4681234567', '1984-09-01'),
       ('Hildur Guðnadóttir', '2512052242', 'Iceland', '+3541234567', '1982-09-04'),
       ('Nico Muhly', '2303934332', 'USA', '+12125551212', '1981-08-26'),
       ('Mason Bates', '2404098447', 'USA', '+14155552671', '1977-01-23'),
       ('Missy Mazzoli', '2508955315', 'USA', '+17184325967', '1980-10-27'),
       ('Gabriel Kahane', '2606684662', 'USA', '+12127894567', '1981-02-05'),
       ('Max Richter', '2707175777', 'UK', '+442089765432', '1966-03-22'),
       ('Anna Thorvaldsdottir', '2801888788', 'Iceland', '+3541234567', '1977-06-11'),
       ('Eric Whitacre', '1903949982', 'USA', '+17184325967', '1970-01-02'),
	   ('Judd Greenstein', '0306101010', 'USA', '+12127894567', '1979-08-09'),
       ('Daniel Kellogg', '3107121138', 'USA', '+18005551234', '1976-05-22'),
       ('Derek Bermel', '0808225232', 'USA', '+12127894567', '1967-04-06'),
       ('David T. Little', '1303938343', 'USA', '+17184325967', '1978-03-12'),
	   ('Caroline Shaw', '1004443442', 'USA', '+14155552671', '1982-08-01'),
       ('John Luther Adams', '2505375559', 'USA', '+19074894567', '1953-01-23');
       
INSERT INTO userRole
VALUES (NULL, 'Administrator'),
	   (NULL, 'Author'),
       (NULL, 'Customer');
       
INSERT INTO user (username, password, egn, address, userRole_id)
VALUES ('John Wall', 'H@rdT0Gu3ss!', '9105010501', '123 Main Street', 2),
	   ('Peter Bord', '5tr0ngP@55w0rd', '2301050501', 'Maple Drive 45', 3),
       ('Sam Anton', 'S3cur3L0g1n!', '8907010701', '312 Oak Avenue', 3),
       ('Gordon Brown', 'C0mpl3xP@55', '6701020101', '39 Pine Street', 2),
       ('Jack Monli' 'bo&sq!#sc1', '3401010301', 'Cedar Lane 78', 3),
       ('Harper Turner', '#1S3cur1ty', '2104010101', 'Grove Road 65', 3),
       ('Logan Wright', 'cat1@3!5t', '0501060101', 'Sunset Boulevard 21', 3),
       ('Penelope Allen', 'H8tuk@p0#', '0701010101', 'Vine Street 15', 3),
       ('Ethan King', 'B#6kTf9d', '1201040101', 'Beach Drive 30', 3),
       ('Grace Robinson', '8#vQfLj!', '0801010101', '82 Broad Street', 2),
       ('Noah Young', '5@pCm9#x', '1101010101', '76 Cherry Lane', 2),
       ('Avery Scott', 'Q!4rJf7d', '8101010101', 'Forest Drive 55', 2),
       ('Lucas Thompson', 'G8bXtH#2', '3104010209', 'Garden Street 68', 2),
       ('Emma Wright', 'P@6cMk!3', '9001090108', 'Laurel Avenue 25', 2),
       ('Liam Davis', 'K!5rMjz',  '6601010101', '45 Meadow Lane', 2),
       ('Zoey Barnes', 'Y8tLcG!z', '5601010101', '89 Ocean View Avenue', 2),
       ('Austin Morris', 'B6hPfX#9', '3401010101', 'Rosewood Drive 68', 3),
       ('Abigail Wood', 'HPjKbR7#3', '3301090901', 'Spring Street 18', 2),
       ('Caleb Collins', 'P@#7kyl?2', '9401670701', '22 Summer Avenue', 2),
       ('Samantha Carter', 'ZPP3-g5', '9201010101', '29 Washington Boulevard', 2),
       ('Kevin Kim', '2@jRfH#8', '2001010101', 'Willow Way 78', 2),
       ('Scarlett Reed', 'M9pBcT!z', '2901010101', 'Ash Street 99', 2),
       ('Joshua Flores', '1#jGhTc$', '7101010101', 'Birch Lane 720', 3),
       ('Avery Murray', '5gf!zv35', '3601010101', '720 Chestnut Street', 2),
       ('Brandon Ortiz', 'H7tYk@p#', '4101010101', '454 Dogwood Drive', 2),
       ('Ella Coleman', 'mQ8zWj!5', '2101010101', 'East Avenue 060', 2),
       ('Christopher Nelson', '3$gDcL@7', '8101010101', '77 Fern Road', 2),
       ('Addison Reyes', 'B@!6yTz9a', '9148010101', '44 Grand Avenue', 3),
       ('Ryan Mitchell', 'Fp9yLc$6', '9143011101', '92 Ivy Lane', 2),
       ('Lily Campbell', 'zX5bRq!8', '9101010900', '88 Juniper Street', 2),
       ('Gabriel Ramirez', 'J$4wNf#m', '9001001019', '65 Kings Road', 2),
       ('Harper Foster', '7!sTbRy#', '6901013104', 'Lakeside Drive 99', 2),
       ('Jonathan Cooper', 'E9fMhZ#8', '6701010101', 'Magnolia Lane 32', 2),
       ('Natalie Parker', 'tY5nCj!2', '4501010101', 'North Street 45', 2),
       ('Samuel Hill', 'P@8rKm#7', '2701010101', '323 Main Street', 2),
       ('Madison Turner', 'gX6pVt!z', '3205060708', '505 Orchard Road', 2),
       ('Joseph Wright', '4$dNkP#j', '0101030303', '707 Pineview Drive', 2),
       ('Chloe Adams', 'Q8zHfL!7', '54099010171', '987 Quarry Lane', 2),
       ('Alexander Green', '6#jBpCt$', '6301010121', 'Redwood Avenue 055', 2),
       ('Grace Mitchell', 'U5dKmF!7', '8201010131', 'South Avenue 989', 2),
       ('Nicholas Baker', 'R!2kNf#m', '0101010111', 'Terrace Place 878', 2),
       ('Amelia Clark', '1#jGhTc$', '7101010212', 'Union Street 653', 2),
       ('Benjamin Lewis', 'S6tRyK!z', '3101010303', 'Valley Road 677', 2),
       ('Harper Gonzalez', 'A#1qPf9k', '4501010333', 'West Street 011', 2),
       ('Andrew Perez', 'wY9bLj!3', '3701010999', '133 York Street ', 2),
       ('Charlotte Davis', 'D3kFmZ$6', '79010101765', 'Xanadu Lane 434', 3),
       ('Matthew Thomas', '2@jRfH#8', '0801010530', 'High Street 588', 2),
       ('Mia Johnson', 'M9pBcT!z', '9101010340', 'Park Avenue 219', 2),
       ('Daniel Taylor', '8#vQfLj!', '2201020712', '657 Elm Street', 2),
       ('Isabella Hernandez', 'F7nGkP!z', '3403740310', '988 Academy Street', 2),
       ('Charles Rodriguez', 'cL3jRy#6', '8303080320', '878 Baker Street', 2),
       ('Sophia Martinez', '5$WfNt#9', '9501050456', '350 Cypress Way', 2),
       ('Robert Garcia', 'J9gHkD!4', '9401040986', '535 Diamond Drive', 2);
       
INSERT INTO user (username, password, egn, address, phone, isAdmin, userRole_id)
VALUES ('Jo Lee', '#235-vgd2', '2992093467', 'Cedar Street, St. Louis 454', '0821934569', true, 1);
