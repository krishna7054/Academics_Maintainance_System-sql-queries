create database lab4;
use lab4;
show tables;
create table instructor (ID int , name varchar(30), dept_name varchar(30), salary int );
insert into instructor values (01, 'Niraj' , 'CS', 700000);
insert into instructor values(02, 'Susham', 'CS',80000);
insert into instructor values(03, 'MKR', 'Math', 60000);
insert into instructor values(04, 'Kundu', 'Math', 70000);
insert into instructor values(05, 'Mishra', 'Human', 60000);

select * from instructor;

create table course (course_id int, title varchar(30), dept_name varchar(30), credits int);
insert into course  values(101, 'DBMS', 'CS', 12);
insert into course values(201, 'Oops', 'CS', 13);
insert into course values(222, 'Numerical', 'Math', 8);
insert into course values(111, 'Sataics', 'Math',5);
insert into course values (234, 'Pc' , 'Human',4);
select * from course;

create table student(ID int , name varchar(30), dept_name varchar(30), tot_cred int);
insert into student values(1, 'Krishna', 'CS', 20);
insert into student values(2,'Adrash', 'Math', 19);
insert into student values(3,'Ankit', 'CS', 20);
insert into student values(4, 'Rohit','Math',19);
insert into student values (5,'Sahil','Human',12);
insert into  student values(6, 'Anupam', 'Chemical',40);
insert into  student values(7, 'paman', 'Chemical',40);

select * from student;

create table teaches(ID int , course_id int, sec_id int, semester varchar(30), year int);
insert into teaches values(01, 101, 11, 'Fall', 2020);
insert into teaches values(02, 201, 12, 'Fall', 2019);
insert into teaches values(03, 222, 14, 'Spring', 2020);
insert into teaches values(04, 111, 16, 'Spring', 2013);
insert into teaches values(05, 234, 17, 'Spring', 2013);

select * from teaches;

create table takes(ID int , course_id int, sec_id int, semester int, year int, grade varchar(30));
insert into takes values(01, 101, 11, 1, 2020, 'A');
insert into takes values(02, 201, 12, 1, 2019, 'A');
insert into takes values(03, 222, 14, 2, 2020,'B');
insert into takes values(04, 111, 16, 2, 2013,'B');
insert into takes values(05, 234, 17, 3, 2013,'B');
select * from takes;

create table prereq(course_id int , prereq_id int);
insert into prereq values(101, 22);
insert into prereq values(201, 35);
insert into prereq values(222, 73);
insert into prereq values(111, 45);
insert into prereq values(234, 10);
select * from prereq;


-- Showing Average salary of instructor
SELECT AVG(salary)
FROM instructor;

-- -- Showing Average salary of instructor in each department
SELECT dept_name, AVG(salary)
FROM instructor
GROUP BY dept_name;

-- Showing Number of students in specific department
SELECT COUNT(*)
FROM student
WHERE dept_name = 'Dept_name';

-- Showing Number of courses with any prerequisites
SELECT COUNT(distinct course_id)
as courseCount
from prereq ;

-- Showing number of courses having any prerequisites
SELECT COUNT(DISTINCT prereq.course_id)
FROM prereq
JOIN course ON prereq.course_id = course.course_id
WHERE course.dept_name = 'your_department_name';


-- Showing number of courses having any prerequisites but taught by a specific instructor
SELECT COUNT(DISTINCT prereq.course_id)
FROM prereq
JOIN course ON course.course_id = prereq.course_id
JOIN teaches ON teaches.course_id = course.course_id
JOIN instructor ON instructor.ID = teaches.ID
WHERE instructor.name = '<instructor_name>' AND course.dept_name = '<department_name>';

-- Showing average credits being offered by each department
SELECT dept_name, AVG(credits)
FROM course
GROUP BY dept_name;

-- Showing names and salary of all instructors of CSE having salary higher than average salary
SELECT name, salary
FROM instructor
WHERE dept_name = 'CS' AND salary > (SELECT AVG(salary) FROM instructor WHERE dept_name = 'Math');


-- Showing names of courses offered by dept. of CSE having more than 3 credits

SELECT title
FROM course
WHERE dept_name = 'CS' AND credits > 3;

-- Showing names of courses offered of CSE dept. in an year with more than 3 credits

SELECT title
FROM course c
JOIN teaches t
ON c.course_id = t.course_id
WHERE c.dept_name = 'CS' AND t.year = 2020 AND c.credits > 3;

-- Showing ID's & names of all students who are taought by in an instructor having the name from CSE only
SELECT student.ID, student.name
FROM student
JOIN takes ON student.ID = takes.ID
JOIN course ON takes.course_id = course.course_id
JOIN teaches ON takes.course_id = teaches.course_id
JOIN instructor ON teaches.ID = instructor.ID
WHERE instructor.name = 'Niraj' AND instructor.dept_name = 'CS' AND course.dept_name = 'CS';

-- Showing names & salary of instructors of CSE dept. in descending order of salary
SELECT name, salary
FROM instructor
WHERE dept_name = 'CS'
ORDER BY salary DESC;

-- Showing names & salary of the instructor of the  dept. of CSE in the descending order with salary having 20,000- 60,000
SELECT name, salary 
FROM instructor 
WHERE dept_name = 'CS' AND salary BETWEEN 20000 AND 60000 
ORDER BY salary DESC;

-- Showing dept. names & maximum salary of instructor in each dept.
SELECT dept_name, MAX(salary) as maximum_salary
FROM instructor
GROUP BY dept_name;

-- Showing dept. names & avg. salry of instructors in each dept. with avg. salary > 40,000
SELECT dept_name, AVG(salary) as avg_salary
FROM instructor
GROUP BY dept_name
HAVING AVG(salary) > 40000;

-- Showing course title, dept. name & total credit for the dept. that are offering courses more than 25 credits.
SELECT title, dept_name, SUM(credits) as Total_Credits
FROM course
GROUP BY dept_name
HAVING SUM(credits) > 25
