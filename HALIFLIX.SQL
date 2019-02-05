/*THIS SCRIPT CREATES AND POPULATE THE DATABASE AND TABLES*/

CREATE SCHEMA IF NOT EXISTS HALIFLIX;
USE HALIFLIX ;

DROP TABLE IF EXISTS MOVIE_RENTAL;
DROP TABLE IF EXISTS MOVIE;
DROP TABLE IF EXISTS CUSTOMER;
DROP TABLE IF EXISTS DIRECTOR;

-- -----------------------------------------------------
-- Table `DIRECTOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS DIRECTOR (
  DIR_ID INT PRIMARY KEY,
  DIR_F_NAME VARCHAR(45) NOT NULL,
  DIR_L_NAME VARCHAR(45) NOT NULL
);

-- -----------------------------------------------------
-- Table `MOVIE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS MOVIE (
  MOV_ID INT  PRIMARY KEY,
  MOV_NAME VARCHAR(45) NOT NULL,
  MOV_PRICE DOUBLE NOT NULL,
  MOV_GENRE VARCHAR(45) NOT NULL,
  MOV_REST INT NOT NULL, /*AGE RESTRICTION: 0 FOR GENERAL PUBLIC*/
  MOV_TRAILER VARCHAR(200), /*REFERENCE TO VIDEO - LINK*/
  DIR_ID INT NOT NULL,
  FOREIGN KEY(DIR_ID) REFERENCES DIRECTOR(DIR_ID)
);


-- -----------------------------------------------------
-- Table `CUSTOMER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS CUSTOMER (
  CUST_ID INT PRIMARY KEY,
  CUST_F_NAME VARCHAR(45) NOT NULL,
  CUST_L_NAME VARCHAR(45) NOT NULL,
  CUST_PHONE VARCHAR(15) NOT NULL,
  CUST_EMAIL VARCHAR(45),
  CUST_DOB DATE NOT NULL, /*TO CHECK FOR RESTRICTION*/
  CUST_PASS VARCHAR(15)/*Password of maximum 15 chars*/
);



-- -----------------------------------------------------
-- Table `MOVIE_RENTAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS MOVIE_RENTAL (
  RENT_ID INT  PRIMARY KEY,
  RENT_DATE DATE NOT NULL,
  RENT_DAYS INT NOT NULL,
  MOV_ID INT NOT NULL,
  CUST_ID INT NOT NULL,
  RETURNED BOOL NOT NULL,
  FOREIGN KEY(CUST_ID) REFERENCES CUSTOMER(CUST_ID),
  FOREIGN KEY(MOV_ID) REFERENCES MOVIE(MOV_ID)
);









/*POPULATE DATABASE*/
-- -----------------------------------------------------
-- Table `DIRECTOR`
-- -----------------------------------------------------
INSERT INTO DIRECTOR VALUES (1,'James','Cameron');			
INSERT INTO DIRECTOR VALUES (2,'Jeffrey','Abrams');			
INSERT INTO DIRECTOR VALUES (3,'Colin','Trevorrow');			
INSERT INTO DIRECTOR VALUES (4,'Joss','Whedon');			
INSERT INTO DIRECTOR VALUES (5,'James','Wan');			
INSERT INTO DIRECTOR VALUES (6,'David','Yates');			
INSERT INTO DIRECTOR VALUES (7,'Rian','Johnson');			
INSERT INTO DIRECTOR VALUES (8,'Chris','Buck');			
INSERT INTO DIRECTOR VALUES (9,'Bill','Condon');			
INSERT INTO DIRECTOR VALUES (10,'Felix','Gray');			
INSERT INTO DIRECTOR VALUES (11,'Shane','Black');			
INSERT INTO DIRECTOR VALUES (12,'Ryan','Coogler');			
INSERT INTO DIRECTOR VALUES (13,'Kyle','Balda');			
INSERT INTO DIRECTOR VALUES (14,'Steven','Spielberg');			
INSERT INTO DIRECTOR VALUES (15,'Guillermo','Del Toro');			




-- -----------------------------------------------------
-- Table `CUSTOMER`
-- -----------------------------------------------------
INSERT INTO CUSTOMER VALUES (1,'Amy','Hill','3554440451','HA355@hotmail.com','2002-03-10','12345');
INSERT INTO CUSTOMER VALUES (2,'Erin','Samson','8206980822','SE820@gmail.com','1950-10-02','halifaxPass');
INSERT INTO CUSTOMER VALUES (3,'Jamie','Samson','1725028141','SJ172@gmail.com','1967-11-23','hello123');
INSERT INTO CUSTOMER VALUES (4,'Gabrielle','Dorey','6025152419','DG602@gmail.com','2011-01-06','mypassword');
INSERT INTO CUSTOMER VALUES (5,'Ava','Sturm','8285216905','SA828@dal.ca','2000-08-14','halifax12345');
INSERT INTO CUSTOMER VALUES (6,'Leah','Boudreau','2985037614','BL298@dal.ca','2008-08-28','246810');
INSERT INTO CUSTOMER VALUES (7,'Sophia','Mackinnon','8186455350','MS818@hotmail.com','1979-12-30','h0lamund0');
INSERT INTO CUSTOMER VALUES (8,'Bailee','Lavandier','8488729112','LB848@dal.ca','1990-11-15','bailee123');
INSERT INTO CUSTOMER VALUES (9,'Alex','King','4246948049','KA424@hotmail.com','1966-09-01','KING789');
INSERT INTO CUSTOMER VALUES (10,'Megan','Donovan','1510635072','DM151@gmail.com','1963-05-25','1510635072');




-- -----------------------------------------------------
-- Table `MOVIE`
-- -----------------------------------------------------
INSERT INTO MOVIE VALUES (1,'Avatar',0.30,'Fantasy',13,'https://www.youtube.com/watch?v=5PSNL1qE6VY',1);
INSERT INTO MOVIE VALUES (2,'Titanic',0.10,'Romance',13,'https://www.youtube.com/watch?v=zCy5WQ9S4c0',1);
INSERT INTO MOVIE VALUES (3,'Star Wars: The Force Awakens',0.99,'Science Fiction',13,'https://www.youtube.com/watch?v=sGbxmsDFVnE',2);
INSERT INTO MOVIE VALUES (4,'Jurassic World',0.60,'Action',13,'https://www.youtube.com/watch?v=RFinNxS5KN4',3);
INSERT INTO MOVIE VALUES (5,'The Avengers',0.99,'Action',13,'https://www.youtube.com/watch?v=eOrNdBpGMv8',4);
INSERT INTO MOVIE VALUES (6,'Furious 7',0.50,'Action',13,'https://www.youtube.com/watch?v=Skpu5HaVkOc',5);
INSERT INTO MOVIE VALUES (7,'Avengers: Age of Ultron',0.99,'Action',13,'https://www.youtube.com/watch?v=tmeOjFno6Do',4);
INSERT INTO MOVIE VALUES (8,'Harry Potter and the Deathly Hallows Part 2',0.50,'Fantasy',13,'https://www.youtube.com/watch?v=ll1H-9Qm1UM',6);
INSERT INTO MOVIE VALUES (9,'Star Wars: The Last Jedi',0.75,'Science Fiction',13,'https://www.youtube.com/watch?v=Q0CbN8sfihY',7);
INSERT INTO MOVIE VALUES (10,'Frozen',0.99,'Family',0,'https://www.youtube.com/watch?v=TbQm5doF_Uc',8);
INSERT INTO MOVIE VALUES (11,'Beauty and the Beast',0.40,'Family',0,'https://www.youtube.com/watch?v=e3Nl_TCQXuw',9);
INSERT INTO MOVIE VALUES (12,'The Fate of the Furious',0.99,'Action',13,'https://www.youtube.com/watch?v=JwMKRevYa_M',10);
INSERT INTO MOVIE VALUES (13,'Iron Man 3',0.99,'Action',13,'https://www.youtube.com/watch?v=oYSD2VQagc4',11);
INSERT INTO MOVIE VALUES (14,'Black Panther',1.99,'Action',13,'https://www.youtube.com/watch?v=xjDjIWPwcPU',12);
INSERT INTO MOVIE VALUES (15,'Minions',0.40,'Family',0,'https://www.youtube.com/watch?v=eisKxhjBnZ0',13);




-- -----------------------------------------------------
-- Table `MOVIE_RENTAL`
-- -----------------------------------------------------
INSERT INTO MOVIE_RENTAL VALUES (1,'2018-03-22',3,13,5,1);
INSERT INTO MOVIE_RENTAL VALUES (2,'2018-03-26',14,5,8,0);
INSERT INTO MOVIE_RENTAL VALUES (3,'2018-03-09',5,15,10,1);
INSERT INTO MOVIE_RENTAL VALUES (4,'2018-03-09',3,5,8,1);
INSERT INTO MOVIE_RENTAL VALUES (5,'2018-03-10',10,7,10,1);
INSERT INTO MOVIE_RENTAL VALUES (6,'2018-03-25',12,1,9,0);
INSERT INTO MOVIE_RENTAL VALUES (7,'2018-03-11',5,15,1,1);
INSERT INTO MOVIE_RENTAL VALUES (8,'2018-02-20',5,4,10,1);
INSERT INTO MOVIE_RENTAL VALUES (9,'2018-02-14',7,12,6,1);







-- -----------------------------------------------------
-- SCRIPTS TO IMPLEMENT IN THE FRONT END APPLICATION 
-- -----------------------------------------------------
/*Find movie with this name, find attribute. Eg. age restriction, trailer, etc.*/
SELECT MOV_NAME FROM MOVIE; /*Find all movies*/
SELECT MOV_REST FROM MOVIE WHERE MOV_NAME='Avatar';
/*Find all movies with this genre*/
SELECT MOV_NAME FROM MOVIE WHERE MOV_GENRE='ACTION';
/*Find all movies with age restriction lower than this*/
SELECT MOV_NAME FROM MOVIE WHERE MOV_REST<13;
/*Look at movies with theirs directors*/
SELECT * FROM MOVIE NATURAL JOIN DIRECTOR;
/*Find all movies of this director*/
SELECT MOV_NAME FROM MOVIE WHERE DIR_ID=(SELECT DIR_ID FROM DIRECTOR WHERE DIR_F_NAME='JAMES' AND DIR_L_NAME='CAMERON');
/*select all available movies*/
SELECT MOV_NAME FROM MOVIE WHERE MOV_ID NOT IN(SELECT MOV_ID FROM MOVIE_RENTAL WHERE RETURNED=0);
/*select movie if available*/
SELECT MOV_NAME FROM MOVIE WHERE MOV_NAME='BAH' AND MOV_ID NOT IN (SELECT MOV_ID FROM MOVIE_RENTAL WHERE RETURNED=0);

/*Select movies that have not been returned*/
SELECT MOV_ID FROM MOVIE_RENTAL WHERE RETURNED=0;


/*Find customer with this name, find attribute*/
SELECT * FROM CUSTOMER WHERE CUST_F_NAME='AMY' AND CUST_L_NAME='HILL';
/*Find customer's age*/
SELECT FLOOR((DATEDIFF(NOW(),(SELECT CUST_DOB FROM CUSTOMER WHERE CUST_F_NAME='ERIN')))/(365)) AS CUST_AGE FROM CUSTOMER WHERE CUST_F_NAME='ERIN';
/*Select a customer's complete name*/
SELECT CONCAT(CUST_F_NAME, ' ', CUST_L_NAME) AS CUSTOMER_NAME FROM CUSTOMER WHERE CUST_F_NAME='AMY' AND CUST_L_NAME='HILL';

SELECT MOV_NAME FROM MOVIE WHERE DIR_ID IN (SELECT DIR_ID FROM DIRECTOR WHERE CONCAT(DIR_F_NAME, ' ', DIR_L_NAME)='JAMES CAMERON' OR DIR_F_NAME='JAMES' OR DIR_L_NAME='CAMERON') ORDER BY MOV_NAME ASC;

/*DATEDIFF((SELECT RENT_DATE FROM MOVIE_RENTAL WHERE MOV_ID=1),NOW())*/

/*calculate cost of rent with tax*/
SELECT RENT_ID, (ROUND(MOVIE.MOV_PRICE*MOVIE_RENTAL.RENT_DAYS,2))*1.15 AS COST FROM MOVIE RIGHT OUTER JOIN MOVIE_RENTAL ON MOVIE.MOV_ID=MOVIE_RENTAL.MOV_ID;



SELECT MAX(RENT_ID) FROM MOVIE_RENTAL;
INSERT INTO MOVIE_RENTAL VALUES (10,'2018-01-08',4,9,10,1);


INSERT INTO MOVIE_RENTAL VALUES ( 11 ,NOW(),4 , 3, 1,0);
DELETE FROM MOVIE_RENTAL WHERE RENT_ID=13;

