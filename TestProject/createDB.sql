create database testdb;
use testdb;
CREATE TABLE answers (
    ID int  AUTO_INCREMENT,
    answer text ,
    correct bool,
    ID_question int,
    pathtopicture text ,
    CONSTRAINT answers_pk PRIMARY KEY (ID)
);

-- Table: answers_user
CREATE TABLE answers_user (
    ID int  AUTO_INCREMENT,
    ID_form int ,
    ID_answer int NULL,
    ID_question int ,
    textanswer text ,
    CONSTRAINT answers_user_pk PRIMARY KEY (ID)
);

-- Table: categories
CREATE TABLE categories (
    category text ,
    ID int  AUTO_INCREMENT,
    parent int ,
    CONSTRAINT categories_pk PRIMARY KEY (ID)
);

-- Table: forms
CREATE TABLE forms (
    ID int  AUTO_INCREMENT,
    ID_test int ,
    ID_user int ,
    date date ,
    datestart timestamp ,
    datefinish timestamp ,
    quantity_question int ,
    correct_question int ,
    CONSTRAINT forms_pk PRIMARY KEY (ID)
);

-- Table: questions
CREATE TABLE questions (
    ID int  AUTO_INCREMENT,
    question text ,
    category int ,
    type_question int ,
    CONSTRAINT questions_pk PRIMARY KEY (ID)
);

-- Table: rules
CREATE TABLE rules (
    ID int  AUTO_INCREMENT,
    namerule varchar(1500) ,
    CONSTRAINT rules_pk PRIMARY KEY (ID)
);

-- Table: test_questions
CREATE TABLE test_questions (
    ID int  AUTO_INCREMENT,
    ID_test int ,
    ID_question int ,
    CONSTRAINT test_questions_pk PRIMARY KEY (ID)
);

-- Table: testcategories
CREATE TABLE testcategories (
    category text ,
    ID int  AUTO_INCREMENT,
    pathtopicture longtext ,
    picture blob ,
    description text ,
    CONSTRAINT testcategories_pk PRIMARY KEY (ID)
);

-- Table: tests
CREATE TABLE tests (
    ID int  AUTO_INCREMENT,
    testname text ,
    date_start date ,
    date_finish date ,
    firstpage bool ,
    ID_users int ,
    ID_category int ,
    pathtotest text ,
    CONSTRAINT tests_pk PRIMARY KEY (ID)
);

-- Table: users
CREATE TABLE users (
    ID int  AUTO_INCREMENT,
    name varchar(100) ,
    password varchar(1500) ,
    status bool ,
    email varchar(100) ,
    ID_rule int ,
    surname varchar(100) ,
    phone varchar(25) ,
    avatar blob ,
    CONSTRAINT users_pk PRIMARY KEY (ID)
);

-- foreign keys
-- Reference: answers_questions (table: answers)
ALTER TABLE answers ADD CONSTRAINT answers_questions FOREIGN KEY answers_questions (ID_question)
    REFERENCES questions (ID);

-- Reference: answers_user_forms (table: answers_user)
ALTER TABLE answers_user ADD CONSTRAINT answers_user_forms FOREIGN KEY answers_user_forms (ID_form)
    REFERENCES forms (ID);

-- Reference: answers_user_questions (table: answers_user)
ALTER TABLE answers_user ADD CONSTRAINT answers_user_questions FOREIGN KEY answers_user_questions (ID_question)
    REFERENCES questions (ID);

-- Reference: forms_tests (table: forms)
ALTER TABLE forms ADD CONSTRAINT forms_tests FOREIGN KEY forms_tests (ID_test)
    REFERENCES tests (ID);

-- Reference: forms_users (table: forms)
ALTER TABLE forms ADD CONSTRAINT forms_users FOREIGN KEY forms_users (ID_user)
    REFERENCES users (ID);

-- Reference: questions_categories (table: questions)
ALTER TABLE questions ADD CONSTRAINT questions_categories FOREIGN KEY questions_categories (category)
    REFERENCES categories (ID);

-- Reference: test_questions_questions (table: test_questions)
ALTER TABLE test_questions ADD CONSTRAINT test_questions_questions FOREIGN KEY test_questions_questions (ID_question)
    REFERENCES questions (ID);

-- Reference: test_questions_tests (table: test_questions)
ALTER TABLE test_questions ADD CONSTRAINT test_questions_tests FOREIGN KEY test_questions_tests (ID_test)
    REFERENCES tests (ID);

-- Reference: tests_testcategories (table: tests)
ALTER TABLE tests ADD CONSTRAINT tests_testcategories FOREIGN KEY tests_testcategories (ID_category)
    REFERENCES testcategories (ID);

-- Reference: tests_users (table: tests)
ALTER TABLE tests ADD CONSTRAINT tests_users FOREIGN KEY tests_users (ID_users)
    REFERENCES users (ID);

-- Reference: users_rules (table: users)
ALTER TABLE users ADD CONSTRAINT users_rules FOREIGN KEY users_rules (ID_rule)
    REFERENCES rules (ID);

INSERT INTO `testdb`.`rules` (`namerule`) VALUES ('user');
INSERT INTO `testdb`.`rules` (`namerule`) VALUES ('admin');


