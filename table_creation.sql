DROP TABLE COMMENTS;
DROP TABLE PRODUCTS;
DROP TABLE USERS;
DROP TABLE PRIVILEGES;
DROP TABLE ROLES;
DROP TABLE CATEGORIES;

------------------------------------------------------------------------

-- Creation Script: A single SQL file providing the scripting to create all the tables, 
-- including all constraints and features as designed in the ERD and data dictionary.

------------------------------------------------------------------------

CREATE TABLE CATEGORIES
(
    CATEGORY_ID			    INT		        PRIMARY KEY,
    CATEGORY_NAME		    VARCHAR2(25)	NOT NULL,
    CATEGORY_DESCRIPTION	VARCHAR2(500)
);

------------------------------------------------------------------------

CREATE TABLE ROLES
(
    ROLE_ID		    INT		        PRIMARY KEY,
    ROLE_NAME		VARCHAR2(100)	NOT NULL
);

------------------------------------------------------------------------

CREATE TABLE PRIVILEGES
(
    PRIVILEGE_ID	    INT		        PRIMARY KEY,
    MODULES		        VARCHAR2(25)	NOT NULL,
    DESCRIPTION         VARCHAR2(50),
    ADD_PRIVILEGE		NUMBER(1, 0)	CHECK (ADD_PRIVILEGE >= 0 AND ADD_PRIVILEGE <= 1),
    EDIT_PRIVILEGE		NUMBER(1, 0)	CHECK (EDIT_PRIVILEGE >= 0 AND EDIT_PRIVILEGE <= 1),
    DELETE_PRIVILEGE	NUMBER(1, 0)	CHECK (DELETE_PRIVILEGE >= 0 AND DELETE_PRIVILEGE <= 1),
    READ_PRIVILEGE		NUMBER(1, 0)	CHECK (READ_PRIVILEGE >= 0 AND READ_PRIVILEGE <= 1),
    ROLE_ID		        INT		        NOT NULL,

    FOREIGN KEY (ROLE_ID) REFERENCES ROLES(ROLE_ID)			
);

------------------------------------------------------------------------

CREATE TABLE USERS
(
    USER_ID		    INT		        PRIMARY KEY,
    USER_FIRSTNAME	VARCHAR2(25)	NOT NULL,
    USER_LASTNAME	VARCHAR2(25)	NOT NULL,
    USER_EMAIL		VARCHAR2(25)	NOT NULL,
    USER_PASSWORD	VARCHAR2(25)	NOT NULL,
    ROLE_ID		    INT		        NOT NULL,

    FOREIGN KEY (ROLE_ID) REFERENCES ROLES(ROLE_ID)
);
------------------------------------------------------------------------

CREATE TABLE PRODUCTS
(
    PRODUCT_ID			INT		        PRIMARY KEY,
    PRODUCT_NAME		VARCHAR2(50)	NOT NULL,
    PRODUCT_BRAND		VARCHAR2(50)	NOT NULL,
    PRODUCT_DESCRIPTION	VARCHAR2(500)	NOT NULL,
    POSTED			    NUMBER(1,0)		        NOT NULL,
    CREATED_BY			INT		        NOT NULL,
    CATEGORY_ID			INT		        NOT NULL,

    FOREIGN KEY (CREATED_BY)    REFERENCES	USERS(USER_ID),
    FOREIGN KEY (CATEGORY_ID)	REFERENCES	CATEGORIES(CATEGORY_ID)
);

------------------------------------------------------------------------

CREATE TABLE COMMENTS
(
    COMMENT_ID		INT		        PRIMARY KEY,
    PRODUCT_ID		INT		        NOT NULL,
    USER_ID		    INT		        NOT NULL,
    APPROVED		NUMBER(1, 0)		        NOT NULL,
    RATING		    NUMBER(2, 1)    CHECK (RATING <= 5 AND RATING >= 0),
    COMMENT_TEXT	VARCHAR2(1000),
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCTS(PRODUCT_ID),
    FOREIGN KEY (USER_ID)   REFERENCES  USERS(USER_ID)
);
