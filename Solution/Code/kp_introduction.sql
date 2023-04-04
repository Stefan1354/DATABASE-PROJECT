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
name ENUM('Pop', 'Hip-hop', 'Jazz', 'Rock') NOT NULL
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


INSERT INTO composer (id, name, egn, nationality, phone, dateOfBirth)
VALUES (NULL, 'Ludovico Einaudi', '1010104305', 'Italy', '+39023234567', '1955-11-23'),
	   (NULL, 'Max Richter', '2109080272', 'Germany', '+49224567890', '1966-03-22'),
	   (NULL, 'Jóhann Jóhannsson', '1203080903', 'Iceland', '+3541234567', '1969-09-19'),
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
       (NULL, 'Daníel Bjarnason', '1220202020', 'Iceland', '+3544567890', '1979-02-26'),
       (NULL, 'Gabriel Prokofiev', '2121212121', 'UK', '+442079876543', '1975-06-11'),
       (NULL, 'Mason Bates', '2902228262', 'USA', '+14152345678', '1977-01-23'),
       (NULL, 'Chaya Czernowin', '2123232323', 'Israel', '+972523', '1957-12-07'),
       (NULL, 'Ludwig Göransson', '1212001121', 'Sweden', '+4681234567', '1984-09-01'),
       (NULL, 'Hildur Guðnadóttir', '2512052242', 'Iceland', '+3541234567', '1982-09-04'),
       (NULL, 'Nico Muhly', '2303934332', 'USA', '+12125551212', '1981-08-26'),
       (NULL, 'Mason Bates', '2404098447', 'USA', '+14155552671', '1977-01-23'),
       (NULL, 'Missy Mazzoli', '2508955315', 'USA', '+17184325967', '1980-10-27'),
       (NULL, 'Gabriel Kahane', '2606684662', 'USA', '+12127894567', '1981-02-05'),
       (NULL, 'Max Richter', '2707175777', 'UK', '+442089765432', '1966-03-22'),
       (NULL, 'Anna Thorvaldsdottir', '2801888788', 'Iceland', '+3541234567', '1977-06-11'),
       (NULL, 'Eric Whitacre', '1903949982', 'USA', '+17184325967', '1970-01-02'),
	   (NULL, 'Judd Greenstein', '0306101010', 'USA', '+12127894567', '1979-08-09'),
       (NULL, 'Daniel Kellogg', '3107121138', 'USA', '+18005551234', '1976-05-22'),
       (NULL, 'Derek Bermel', '0808225232', 'USA', '+12127894567', '1967-04-06'),
       (NULL, 'David T. Little', '1303938343', 'USA', '+17184325967', '1978-03-12'),
	   (NULL, 'Caroline Shaw', '1004443442', 'USA', '+14155552671', '1982-08-01'),
       (NULL, 'John Luther Adams', '2505375559', 'USA', '+19074894567', '1953-01-23');
       
INSERT INTO userRole
VALUES (NULL, 'Administrator'),
	   (NULL, 'Author'),
       (NULL, 'Customer');
       
INSERT INTO user (id, username, password, egn, address, userRole_id)
VALUES (NULL, 'John Wall', 'H@rdT0Gu3ss!', '9105010501', '123 Main Street', 2),
	   (NULL, 'Peter Bord', '5tr0ngP@55w0rd', '2301050501', 'Maple Drive 45', 3),
       (NULL, 'Sam Anton', 'S3cur3L0g1n!', '8907010701', '312 Oak Avenue', 3),
       (NULL, 'Gordon Brown', 'C0mpl3xP@55', '6701020101', '39 Pine Street', 2),
       (NULL, 'Jack Monli', 'bo&sq!#sc1', '3401010301', 'Cedar Lane 78', 3),
       (NULL, 'Harper Turner', '#1S3cur1ty', '2104010101', 'Grove Road 65', 3),
       (NULL, 'Logan Wright', 'cat1@3!5t', '0501060101', 'Sunset Boulevard 21', 3),
       (NULL, 'Penelope Allen', 'H8tuk@p0#', '0701010101', 'Vine Street 15', 3),
       (NULL, 'Ethan King', 'B#6kTf9d', '1201040101', 'Beach Drive 30', 3),
       (NULL, 'Grace Robinson', '8#vQfLj!', '0801010101', '82 Broad Street', 2),
       (NULL, 'Noah Young', '5@pCm9#x', '1101010101', '76 Cherry Lane', 2),
       (NULL, 'Avery Scott', 'Q!4rJf7d', '8201020102', 'Forest Drive 55', 2),
       (NULL, 'Lucas Thompson', 'G8bXtH#2', '3104010209', 'Garden Street 68', 2),
       (NULL, 'Emma Wright', 'P@6cMk!3', '9001090108', 'Laurel Avenue 25', 2),
       (NULL, 'Liam Davis', 'K!5rMjz',  '6601010101', '45 Meadow Lane', 2),
       (NULL, 'Zoey Barnes', 'Y8tLcG!z', '5601010101', '89 Ocean View Avenue', 2),
       (NULL, 'Austin Morris', 'B6hPfX#9', '3401010101', 'Rosewood Drive 68', 3),
       (NULL, 'Abigail Wood', 'HPjKbR7#3', '3301090901', 'Spring Street 18', 2),
       (NULL, 'Caleb Collins', 'P@#7kyl?2', '9401670701', '22 Summer Avenue', 2),
       (NULL, 'Samantha Carter', 'ZPP3-g5', '9201010101', '29 Washington Boulevard', 2),
       (NULL, 'Kevin Kim', '2@jRfH#8', '2001010101', 'Willow Way 78', 2),
       (NULL, 'Scarlett Reed', 'M9pBcT!z', '2901010101', 'Ash Street 99', 2),
       (NULL, 'Joshua Flores', '1#jGhTc$', '7101010101', 'Birch Lane 720', 3),
       (NULL, 'Avery Murray', '5gf!zv35', '3601010101', '720 Chestnut Street', 2),
       (NULL, 'Brandon Ortiz', 'H7tYk@p#', '4101010101', '454 Dogwood Drive', 2),
       (NULL, 'Ella Coleman', 'mQ8zWj!5', '2101010101', 'East Avenue 060', 2),
       (NULL, 'Christopher Nelson', '3$gDcL@7', '8101010101', '77 Fern Road', 2),
       (NULL, 'Addison Reyes', 'B@!6yTz9a', '9148010101', '44 Grand Avenue', 3),
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
       (NULL, 'Charlotte Davis', 'D3kFmZ$6', '7901010176', 'Xanadu Lane 434', 3),
       (NULL, 'Matthew Thomas', '2@jRfH#8', '0801010530', 'High Street 588', 2),
       (NULL, 'Mia Johnson', 'M9pBcT!z', '9101010340', 'Park Avenue 219', 2),
       (NULL, 'Daniel Taylor', '8#vQfLj!', '2201020712', '657 Elm Street', 2),
       (NULL, 'Isabella Hernandez', 'F7nGkP!z', '3403740310', '988 Academy Street', 2),
       (NULL, 'Charles Rodriguez', 'cL3jRy#6', '8303080320', '878 Baker Street', 2),
       (NULL, 'Sophia Martinez', '5$WfNt#9', '9501050456', '350 Cypress Way', 2),
       (NULL, 'Robert Garcia', 'J9gHkD!4', '9401040986', '535 Diamond Drive', 2);
       
INSERT INTO user (id, username, password, egn, address, phone, isAdmin, userRole_id)
VALUES (NULL, 'Jo Lee', '#235-vgd2', '2992093467', 'Cedar Street, St. Louis 454', '0821934569', true, 1);

INSERT INTO orders (id, order_date, price, payment_status, delivery_status, user_id) 
VALUES (NULL, '2022-03-14', 50.00, 'paid', 'delivered', 1),
       (NULL, '2022-03-15', 20.00, 'paid', 'not delivered', 2),
       (NULL, '2022-03-15', 75.00, 'not paid', 'not delivered', 3),
       (NULL, '2022-03-16', 35.50, 'paid', 'delivered', 1),
       (NULL, '2022-03-17', 15.00, 'not paid', 'not delivered', 2),
       (NULL, '2022-03-18', 160.00, 'not paid', 'not delivered', 4),
       (NULL, '2022-03-18', 100.00, 'paid', 'delivered', 4),
       (NULL, '2022-03-18', 80.00, 'paid', 'delivered', 4),
       (NULL, '2022-03-18', 90.00, 'paid', 'delivered', 4),
       (NULL, '2022-03-18', 95.00, 'not paid', 'not delivered', 4),
       (NULL, '2022-03-18', 76.00, 'paid', 'delivered', 4),
       (NULL, '2022-03-18', 42.00, 'not paid', 'not delivered', 4),
       (NULL, '2022-03-18', 21.00, 'not paid', 'not delivered', 4),
       (NULL, '2022-03-18', 32.00, 'not paid', 'not delivered', 4),
       (NULL, '2022-03-18', 86.00, 'paid', 'delivered', 4),
       (NULL, '2022-03-18', 64.00, 'paid', 'delivered', 4),
       (NULL, '2022-03-18', 62.00, 'paid', 'delivered', 4),
       (NULL, '2022-03-18', 61.00, 'not paid', 'not delivered', 4),
       (NULL, '2022-03-18', 59.00, 'not paid', 'not delivered', 4),
       (NULL, '2022-04-19', 31.00, 'paid', 'delivered', 4),
       (NULL, '2022-04-19', 99.00, 'paid', 'delivered', 4),
       (NULL, '2022-04-19', 76.00, 'not paid', 'not delivered', 4),
       (NULL, '2022-04-19', 60.00, 'not paid', 'not delivered', 4),
       (NULL, '2022-04-20', 60.00, 'not paid', 'not delivered', 4),
       (NULL, '2022-04-20', 60.00, 'not paid', 'not delivered', 4),
       (NULL, '2022-04-20', 260.00, 'paid', 'delivered', 4),
       (NULL, '2022-04-20', 160.00, 'paid', 'delivered', 4),
       (NULL, '2022-04-21', 30.00, 'paid', 'delivered', 4),
       (NULL, '2022-04-21', 50.00, 'paid', 'delivered', 4),
       (NULL, '2022-04-21', 40.00, 'paid', 'delivered', 4),
       (NULL, '2022-04-22', 70.00, 'paid', 'delivered', 4),
       (NULL, '2022-04-22', 80.00, 'paid', 'delivered', 4),
       (NULL, '2022-04-22', 60.00, 'paid', 'delivered', 4),
       (NULL, '2022-04-22', 60.00, 'not paid', 'not delivered', 4),
       (NULL, '2022-04-25', 60.00, 'paid', 'delivered', 4),
       (NULL, '2022-04-25', 98.00, 'paid', 'delivered', 4),
       (NULL, '2022-04-25', 31.00, 'paid', 'delivered', 4),
       (NULL, '2022-04-25', 32.00, 'paid', 'delivered', 4),
       (NULL, '2022-04-25', 45.00, 'paid', 'delivered', 4),
       (NULL, '2022-04-25', 54.00, 'paid', 'delivered', 4),
       (NULL, '2022-04-25', 66.00, 'paid', 'delivered', 4),
       (NULL, '2022-04-25', 89.00, 'not paid', 'not delivered', 4),
       (NULL, '2022-04-25', 24.00, 'not paid', 'not delivered', 4),
       (NULL, '2022-04-25', 38.00, 'not paid', 'not delivered', 4),
       (NULL, '2022-04-25', 32.00, 'paid', 'delivered', 4),
       (NULL, '2022-04-25', 42.00, 'paid', 'delivered', 4),
       (NULL, '2022-04-25', 96.00, 'paid', 'delivered', 4),
       (NULL, '2022-04-26', 78.00, 'paid', 'delivered', 4),
       (NULL, '2022-04-26', 91.00, 'not paid', 'not delivered', 4),
       (NULL, '2022-04-27', 83.00, 'paid', 'delivered', 4),
       (NULL, '2022-04-27', 42.00, 'not paid', 'not delivered', 4);
       
       
INSERT INTO song 
VALUES (NULL, 'Hotline Bling', 'https://www.youtube.com/watch?v=uxpDa-c-4Mc&list=PLn4GvABOzCQuZrM1YBvzlYVCkQpZkhXLS&index=2', 'Pop', 'Trap', 'Duo', 181, 1234, 2, 2),
	   (NULL, 'Blinding Lights', 'https://www.youtube.com/watch?v=4NRXx6U8ABQ', 'Pop', 'Synth-pop', 'Solo', 210, 9876, 3, 1),
       (NULL, 'Stairway to Heaven', 'https://www.youtube.com/watch?v=QkF3oxziUI4', 'Rock', 'Classic rock', 'Band', 481, 5678, 5, 3),
       (NULL, 'Old Town Road', 'https://www.youtube.com/watch?v=w2Ov5jzm3j8', 'Hip-hop', 'Country rap', 'Solo', 157, 3456, 6, 2),
       (NULL, 'Billie Jean', 'https://www.youtube.com/watch?v=Zi_XLOBDo_Y', 'Pop', 'Funk', 'Solo', 294, 1234, 9, 1),
       (NULL, 'Round Midnight', 'https://www.youtube.com/watch?v=Ys9wiGNDCvA', 'Jazz', 'Bebop', 'Quartet', 375, 11000000, 4, 1),
       (NULL, 'In My Feelings', 'https://www.youtube.com/watch?v=DRS_PpOrUZ4', 'Hip-hop', 'Trap', 'Solo', 217, 8901, 10, 2),
       (NULL, 'Shallow', 'https://www.youtube.com/watch?v=bo_efYhYU2A', 'Pop', 'Pop rock', 'Duo', 215, 5678, 12, 1),
       (NULL, 'Thrift Shop', 'https://www.youtube.com/watch?v=QK8mJJJvaes', 'Hip-hop', 'Pop rap', 'Duo', 235, 3456, 13, 2),
       (NULL, 'Wonderwall', 'https://www.youtube.com/watch?v=6hzrDeceEKc', 'Rock', 'Britpop', 'Solo', 258, 7890, 14, 3),
	   (NULL, 'Sicko Mode', 'https://www.youtube.com/watch?v=6ONRf7h3Mdk', 'Hip-hop', 'Trap', 'Duo', 312, 4567, 15, 2),
       (NULL, 'Sweet Child O Mine', 'https://www.youtube.com/watch?v=1w7OgIMMRc4', 'Rock', 'Hard rock', 'Band', 355, 1234, 16, 3),
       (NULL, 'All of Me', 'https://www.youtube.com/watch?v=450p7goxZqg', 'Pop', 'Soul', 'Solo', 269, 8901, 17, 1),
       (NULL, 'Sorry', 'https://www.youtube.com/watch?v=fRh_vgS2dFE', 'Pop', 'Dance-pop', 'Group', 200, 7234, 2, 1),
       (NULL, 'So What', 'https://www.youtube.com/watch?v=ylXk1LBvIqU', 'Jazz', 'Modal Jazz', 'Quintet', 579, 32000000, 8, 1),
       (NULL, 'Uptown Funk', 'https://www.youtube.com/watch?v=OPf0YbXqDm0', 'Pop', 'Funk', 'Band', 270, 8265, 3, 1),
       (NULL, 'Lose Yourself', 'https://www.youtube.com/watch?v=_Yhyp-_hX2s', 'Hip-hop', 'Hardcore hip-hop', 'Solo', 341, 4156, 5, 2),
       (NULL, 'I Will Always Love You', 'https://www.youtube.com/watch?v=3JWTaaS7LdU', 'Pop', 'Pop ballad', 'Solo', 271, 8956, 6, 1),
       (NULL, 'Bohemian Rhapsody', 'https://www.youtube.com/watch?v=fJ9rUzIMcZQ', 'Rock', 'Progressive rock', 'Band', 356, 1789, 8, 4),
       (NULL, 'November Rain', 'https://www.youtube.com/watch?v=8SbUC-UaAxE', 'Rock', 'Power ballad', 'Band', 537, 2894, 10, 4),
       (NULL, 'Despacito', 'https://www.youtube.com/watch?v=kJQP7kiw5Fk', 'Pop', 'Latin pop', 'Duo', 228, 6452, 11, 1),
       (NULL, 'Girls Like You', 'https://www.youtube.com/watch?v=aJOTlE1K90k', 'Pop', 'Pop rock', 'Group', 259, 3526, 12, 1),
       (NULL, 'All of Me', 'https://www.youtube.com/watch?v=450p7goxZqg', 'Pop', 'R&B', 'Solo', 269, 9867, 13, 1),
       (NULL, 'Believer', 'https://www.youtube.com/watch?v=7wtfhZwyrcc', 'Rock', 'Alternative rock', 'Group', 204, 7345, 14, 4),
       (NULL, 'Sweet Child o Mine', 'https://www.youtube.com/watch?v=1w7OgIMMRc4', 'Rock', 'Hard rock', 'Band', 355, 8762, 15, 4),
       (NULL, 'Perfect', 'https://www.youtube.com/watch?v=2Vv-BfVoq4g', 'Pop', 'Pop ballad', 'Solo', 263, 5421, 16, 1),
       (NULL, 'Counting Stars', 'https://www.youtube.com/watch?v=hT_nvWreIhg', 'Pop', 'Pop rock', 'Group', 257, 9264, 17, 1),
       (NULL, 'Take Five', 'https://www.youtube.com/watch?v=vmDDOFXSgAs', 'Jazz', 'Cool Jazz', 'Saxophone Quartet', 173, 21200000, 1, 1),
       (NULL, 'All Blues', 'https://www.youtube.com/watch?v=-488UORrfJ0', 'Jazz', 'Modal Jazz', 'Sextet', 663, 13000000, 2, 1),
       (NULL, 'In a Sentimental Mood', 'https://www.youtube.com/watch?v=r594pxUjcz4', 'Jazz', 'Swing', 'Trio', 401, 5000000, 3, 1),
       (NULL, 'Smells Like Teen Spirit', 'https://www.youtube.com/watch?v=hTWKbfoikeg', 'Rock', 'Grunge', 'Electric', 301, 1, 2, 1),
       (NULL, 'Livin on a Prayer', 'https://www.youtube.com/watch?v=lDK9QqIzhwk', 'Rock', 'Pop Rock', 'Electric', 246, 1, 2, 1),
       (NULL, 'Sweet Child o Mine', 'https://www.youtube.com/watch?v=1w7OgIMMRc4', 'Rock', 'Hard Rock', 'Electric', 348, 1, 2, 1),
       (NULL, 'Thunderstruck', 'https://www.youtube.com/watch?v=v2AC41dglnM', 'Rock', 'Heavy metal', 'Blues rock', 292, 700000, 11, 2),
       (NULL, 'Wish You Were Here', 'https://www.youtube.com/watch?v=IXdNnw99-Ic', 'Rock', 'Progressive Rock', 'Acoustic', 334, 1500000, 12, 1),
       (NULL, 'Satisfaction', 'https://www.youtube.com/watch?v=nrIPxlFzDi0', 'Rock', 'Hard rock', 'Guitar, bass, drums, vocals', 218, 103500000, 1, 1);
       
INSERT INTO reviews
VALUES (NULL, 8.5, 'Awesome song, love the guitar solo!', '2022-03-28', 1, 1),
       (NULL, 6.2, 'Not my favorite song, but still decent', '2022-03-29', 2, 1),
       (NULL, 9.8, 'One of the best jazz songs I have ever heard', '2022-03-30', 3, 2),
       (NULL, 7.5, 'Nice melody, but the lyrics are a bit weak', '2022-03-31', 4, 2),
       (NULL, 5.6, 'Not my style of music, but still a decent song', '2022-04-01', 5, 3),
       (NULL, 6.9, 'Catchy tune, but the vocals could be better', '2022-04-02', 6, 3),
       (NULL, 8.2, 'Great rock ballad, love the emotional vocals', '2022-04-03', 7, 4),
       (NULL, 7.1, 'Not the best rock song I have ever heard, but still enjoyable', '2022-04-04', 8, 4),
       (NULL, 9.5, 'Amazing rap song, great flow and lyrics!', '2022-04-05', 9, 5),
       (NULL, 8.0, 'Decent rap song, but I have heard better', '2022-04-06', 10, 5),
       (NULL, 6.8, 'Not my type of music, but still a well-produced track', '2022-04-07', 11, 6),
       (NULL, 7.9, 'Nice beat and flow, but the lyrics could be more meaningful', '2022-04-08', 12, 6),
       (NULL, 8.7, 'Fantastic folk song, great vocal harmonies', '2022-04-09', 13, 7),
       (NULL, 7.2, 'Not a fan of folk music, but still a well-crafted song', '2022-04-10', 14, 7),
       (NULL, 9.5, 'Brilliant guitar work, loved every minute of it', '2022-04-01', 6, 5),
       (NULL, 6.7, 'Not my cup of tea, but it is well produced', '2022-04-02', 7, 6),
       (NULL, 7.8, 'Nice melody, but nothing too special', '2022-04-02', 8, 7),
       (NULL, 9.2, 'Amazing jazz vocals, love this song!', '2022-04-03', 9, 8),
       (NULL, 8.5, 'Solid track, great guitar solo!', '2022-04-03', 10, 9),
       (NULL, 9.0, 'One of my favorite jazz tracks of all time', '2022-04-04', 11, 10),
       (NULL, 7.3, 'Decent song, but not too memorable', '2022-04-04', 12, 11),
       (NULL, 7.0, 'Average song, nothing really stood out', '2022-04-07', 18, 17);
       
INSERT INTO performer(id, name, egn, address, dateOfBirth, genre, song_id)
VALUES (NULL, 'Drake', '9123456782', '111 Pine St, San Francisco, CA 94111', '1986-10-24', 
