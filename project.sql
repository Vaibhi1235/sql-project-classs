CREATE DATABASE project;
USE project;
CREATE TABLE author (
author_id INT ,
author_name VARCHAR(100));
RENAME TABLE author TO authors;
ALTER TABLE authors MODIFY author_id TINYINT PRIMARY KEY;
CREATE TABLE genres (
genre_id TINYINT , 
genre_name VARCHAR(100));
ALTER TABLE genres MODIFY genre_id INT PRIMARY KEY;
CREATE TABLE books (
book_id TINYINT PRIMARY KEY ,
title VARCHAR(255), 
author_id TINYINT,
FOREIGN KEY (author_id) REFERENCES authors(author_id),
genre_id INT ,
FOREIGN KEY (genre_id) REFERENCES genres(genre_id));
CREATE TABLE users (user_id TINYINT PRIMARY KEY, user_name VARCHAR(100));
CREATE TABLE loans (
loan_id TINYINT PRIMARY KEY, 
book_id TINYINT,
FOREIGN KEY (book_id) REFERENCES books(book_id),
user_id TINYINT,
FOREIGN KEY (user_id) REFERENCES users(user_id),
loan_date date,
return_date date);

/*write ddl and dml commands to create all above mentioned tables and tables should look like below*/

INSERT INTO authors VALUES
(1,"john doe"),
(2,"jane smith"),
(3,"michael johnson"),
(4,"sarah brown"),
(5,"david lee");

INSERT INTO genres VALUES
(1,"fiction"),
(2,"non -fiction"),
(3,"science fiction"),
(4,"mystrey"),
(5,"romance");

INSERT INTO books VALUES
(1,"the great gatsby",1,1),
(2,"to kill a mockingbird",2,1),
(3,"1984",3,3),
(4,"sherlock holmes",4,4),
(5,"pride and prejudice",5,5),
(6,"the hobbit",1,3);

INSERT INTO users VALUES
(1,"alice"),
(2,"bob"),
(3,"charlie"),
(4,"emily"),
(5,"james");

INSERT INTO loans VALUES
(1,1,1,"2023-01-15","2023-02-15"),
(2,2,2,"2023-02-01","2023-03-01"),
(3,3,3,"2023-03-10",NULL),
(4,4,4,"2023-04-05",NULL),
(5,5,5,"2023-05-12",NULL),
(6,6,1,"2023-06-20",NULL);

/*retrive the titles of all books along with the names of their authors and genres*/


SELECT title ,author_name , genre_name FROM books as b INNER JOIN authors as a ON b.book_id=a.author_id INNER JOIN genres as g ON b.book_id=g.genre_id;

/*list the names of authors who have written books borrowed by user alice*/

SELECT authors.author_name ,users.user_name FROM authors INNER JOIN users ON authors.author_id=users.user_id WHERE user_name="alice";

/* display the titles of books along with the names of their authors and the total number of times each book has been borrowed*/

SELECT title ,author_name , user_id FROM books as b INNER JOIN authors as a ON b.book_id=a.author_id INNER JOIN loans as l ON b.book_id=l.book_id;

/* find the titles of books borrowed by users who have borrowed books published in the mystrey genre*/

SELECT title FROM books WHERE book_id= ( SELECT genre_id FROM genres WHERE genre_name="mystrey");

/*retrive the names of users along with the titles of books they borrowed the loan dates and return dates if any*/

SELECT user_name, title , loan_date,return_date FROM users as u INNER JOIN books as b ON u.user_id=b.book_id INNER JOIN loans as l ON b.book_id=l.loan_id;


/* list the titles of books along with the names of authors , genres, and the loan dates for each loan made by user alice*/

SELECT title, author_name,genre_name ,loan_date FROM books AS b INNER  JOIN authors AS a ON b.book_id=a.author_id INNER JOIN genres as g ON b.book_id=g.genre_id 
RIGHT JOIN loans AS l ON b.book_id=l.loan_id WHERE user_id=1;

/* display the names of users along with the titles of books they borrowed the names of the authors and the loan dates but only for loans made after 2022-01-01*/


SELECT title,user_name ,author_name,loan_date FROM books AS b INNER JOIN users AS u ON b.book_id =u.user_id INNER JOIN authors AS a ON b.book_id=a.author_id 
LEFT JOIN Loans AS l ON b.book_id=l.loan_id WHERE loan_date>"2022-01-01";

/*identify the names of authors along with the titles of their books the names of users who borrowed those books and the loan dates for each loan*/

SELECT author_name,title,user_name,loan_date FROM authors AS a cross JOIN books AS B ON a.author_id=b.book_id cross JOIN users AS u ON b.book_id=u.user_id 
cross JOIN loans AS l ON l.loan_id=b.book_id;

/* find the name of users who borrowed books published in the non fiction genre along with the titles of the books the names of the authors and the loan dates*/

SELECT user_name,genre_name,title,author_name,loan_date FROM users AS u CROSS JOIN books AS b ON u.user_id =b.book_id CROSS JOIN authors AS a ON a.author_id=b.book_id 
CROSS JOIN loans AS l ON l.loan_id-b.book_id RIGHT JOIN genres AS g ON g.genre_id=b.book_id WHERE genre_name="non-fiction";

/* find the title of books with the highest no of loans*/

SELECT title FROM books WHERE book_id IN( SELECT loan_id FROM loans group by loan_id HAVING max(loan_id));

/* identify the titles of books borrowed by users who borrowed more than 3 book*/

SELECT title FROM books WHERE book_id IN (SELECT user_id FROM loans WHERE user_id=1); 

/* determine the names of users who have borrowed books written by authors with more than 5 published books*/

SELECT user_name FROM users WHERE user_id IN ( SELECT author_id FROM authors  WHERE author_id);

/* count the number of loans made by each user grouped by the genre of the borrowed books*/

/*list the names of authors along with the total number of loans for each of their books*/

SELECT genre_name , loan_id FROM genres AS g INNER JOIN loans AS l ON g.genre_id=l.loan_id;

SELECT author_name, loan_id FROM authors AS a INNER JOIN loans AS l ON a.author_id=l.loan_id;






