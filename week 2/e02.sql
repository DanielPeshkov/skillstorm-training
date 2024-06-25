/*
E02 - Database Operations
*/

-- Exercise 1
CREATE TABLE courses (
	course_id INT PRIMARY KEY IDENTITY,
	course_name VARCHAR(60) NOT NULL, 
	course_author VARCHAR(40) NOT NULL, 
	course_status VARCHAR(10) NOT NULL, 
	course_published_dt DATETIME
);
GO

-- Exercise 2
INSERT INTO courses (course_name, course_author, course_status, course_published_dt)
VALUES 
	('Programming using Python', 'Bob Dillon',	'published',	2020-09-30),
	('Data Engineering using Python',	'Bob Dillon',	'published',	2020-07-15),
	('Programming using Scala',	'Elvis Presley',	'published',	2020-05-12),
	('Programming using Java',	'Mike Jack',	'inactive',	2020-08-10),
	('Web Applications - Python Flask',	'Bob Dillon',	'inactive',	2020-07-20),
	('Streaming Pipelines - Python',	'Bob Dillon',	'published',	2020-10-05),
	('Web Applications - Scala Play',	'Elvis Presley',	'inactive',	2020-09-30),
	('Web Applications - Python Django',	'Bob Dillon',	'published',	2020-06-23),
	('Server Automation - Ansible',	'Uncle Sam',	'published',	2020-07-05);

INSERT INTO courses (course_name, course_author, course_status)
VALUES 
	('Data Engineering using Scala',	'Elvis Presley',	'draft'),
	('Web Applications - Java Spring',	'Mike Jack',	'draft'),
	('Pipeline Orchestration - Python',	'Bob Dillon',	'draft');
GO

-- Exercise 3
UPDATE courses
SET course_status = 'published', course_published_dt = SYSDATETIME()
WHERE course_status = 'draft' AND 
	(course_name LIKE '%Python%' OR course_name LIKE '%Scala%');
GO

-- Exercise 4
DELETE FROM courses
WHERE course_status != 'published' AND course_status != 'draft';

SELECT course_author, count(1) AS course_count
FROM courses
WHERE course_status= 'published'
GROUP BY course_author
