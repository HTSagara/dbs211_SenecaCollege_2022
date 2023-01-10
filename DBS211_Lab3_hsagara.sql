-- ***********************
-- Name: Henrique Toshio Sagara
-- ID: 170954218
-- Date: 2022/09/30
-- Purpose: Lab 03 DBS211
-- ***********************
SET AUTOCOMMIT ON;

-- Q1 SOLUTION --
CREATE TABLE L5_MOVIES
(
m_id            INT             PRIMARY KEY,
title           VARCHAR(35)     NOT NULL,
release_year    INT             NOT NULL,
director        INT             NOT NULL,
score           DECIMAL(3,2)    CHECK (score < 5 and score > 0)
);
CREATE TABLE L5_ACTORS
(
a_id        INT         PRIMARY KEY,
first_name  VARCHAR(20) NOT NULL,
last_name   VARCHAR(30) NOT NULL
);
CREATE TABLE L5_CASTINGS
(
move_id      INT   PRIMARY KEY,
actor_id    INT,
CONSTRAINT  move_id_fk   FOREIGN KEY (move_id)   REFERENCES  L5_MOVIES(m_id),
CONSTRAINT  actor_id_fk  FOREIGN KEY (actor_id)  REFERENCES  L5_ACTORS(a_id)
);
CREATE TABLE L5_DIRECTORS
(
director_id INT          PRIMARY KEY,
first_name  VARCHAR(20)  NOT NULL,
last_name   VARCHAR(30)  NOT NULL
);

-- Q2 SOLUTION --
ALTER TABLE L5_MOVIES
ADD CONSTRAINT director_fk 
FOREIGN KEY (director) 
REFERENCES L5_DIRECTORS;

-- Q3 SOLUTION --
ALTER TABLE L5_MOVIES
ADD CONSTRAINT movies_uniq
UNIQUE (m_id, title, release_year, director, score);

-- Q4 SOLUTION --
-- L5_Director --
INSERT INTO L5_DIRECTORS VALUES(1010, 'Rob', 'Minkoff');
INSERT INTO L5_DIRECTORS VALUES(1020, 'Bill', 'Condon');
INSERT INTO L5_DIRECTORS VALUES(1050, 'Josh', 'Cooley');
INSERT INTO L5_DIRECTORS VALUES(2010, 'Brad', 'Bird');
INSERT INTO L5_DIRECTORS VALUES(3020, 'Lake', 'Bell');
INSERT INTO L5_DIRECTORS VALUES(1111, 'Henrique', 'Sagara');
SELECT * FROM L5_DIRECTORS;

-- L5_Movies --

INSERT INTO L5_MOVIES VALUES(100, 'The Lion King', 2019, 3020, 3.50);
INSERT INTO L5_MOVIES VALUES(200, 'Beauty and the Beast', 2017, 1050, 4.20);
INSERT INTO L5_MOVIES VALUES(300, 'Toy Story 4', 2019, 1020, 4.50);
INSERT INTO L5_MOVIES VALUES(400, 'Mission Impossible', 2018, 2010, 5.00);
INSERT INTO L5_MOVIES VALUES(500, 'The Secret Life of Pets', 2016, 1010, 3.90);
SELECT * FROM L5_MOVIES;

-- Q5 SOLUTION --
--The right order to drop the tables is starting by Casting which is the one using foreign key
-- and then drop Actors and Movies, which is the one using foreign key from Directors
-- and the last one should be the Directors
DROP TABLE L5_CASTINGS;
DROP TABLE L5_ACTORS;
DROP TABLE L5_MOVIES;
DROP TABLE L5_DIRECTORS;