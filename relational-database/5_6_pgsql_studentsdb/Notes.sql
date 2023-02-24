-- Pattern matching:

    -- Operators:
    -- _ = Any character
        SELECT * FROM courses WHERE course LIKE '_lgorithms';
    -- % = Any number of any character
        SELECT * FROM courses WHERE course LIKE '%lgorithms';

    -- LIKE matches an exact pattern;
        SELECT * FROM courses WHERE course LIKE '%A%';

    -- NOT LIKE excudes the matching pattern:
        SELECT * FROM courses WHERE course NOT LIKE '%A%';

    -- ILIKE ignores the case when searching (can also be uset with NOT):
        SELECT * FROM courses WHERE course ILIKE '%A%';
        SELECT * FROM courses WHERE course NOT ILIKE '%A%';

-- Empty fields:
    SELECT * FROM students WHERE gpa IS NULL;
    SELECT * FROM students WHERE gpa IS NOT NULL;

-- Arithmetics
    SELECT MIN(gpa) FROM students;
    SELECT max(gpa) FROM students;
    SELECT SUM(major_id) FROM students;
    SELECT AVG(gpa) FROM students;
    SELECT AVG(major_id) FROM students;
    SELECT CEIL(AVG(major_id)) FROM students;
    SELECT ROUND(AVG(major_id)) FROM students;
    SELECT ROUND(AVG(major_id), 5 ) FROM students;
    SELECT COUNT(*) FROM majors;
    SELECT COUNT(*) FROM students;
    SELECT COUNT(major_id) FROM students;
    SELECT DISTINCT(major_id) FROM students;

-- Grouping
    SELECT major_id FROM students GROUP BY major_id;
        
    +----------+
    | major_id |
    +----------+
    |          |
    |       42 |
    |       41 |
    |       38 |
    |       36 |
    |       37 |
    +----------+
    (6 rows)

    SELECT COUNT(*) FROM students GROUP BY major_id;
        
    +-------+
    | count |
    +-------+
    |     8 |
    |     1 |
    |     6 |
    |     4 |
    |     6 |
    |     6 |
    +-------+
    (6 rows)

    SELECT major_id, COUNT(*) FROM students GROUP BY major_id;
            
    +----------+-------+
    | major_id | count |
    +----------+-------+
    |          |     8 |
    |       42 |     1 |
    |       41 |     6 |
    |       38 |     4 |
    |       36 |     6 |
    |       37 |     6 |
    +----------+-------+
    (6 rows)


    SELECT major_id, MIN(gpa) FROM students GROUP BY major_id;
            
    +----------+-----+
    | major_id | min |
    +----------+-----+
    |          | 2.3 |
    |       42 | 2.6 |
    |       41 | 2.1 |
    |       38 | 2.2 |
    |       36 | 1.9 |
    |       37 | 1.8 |
    +----------+-----+
    (6 rows)

    SELECT major_id, MIN(gpa), MAX(gpa) FROM students GROUP BY major_id;
                
    +----------+-----+-----+
    | major_id | min | max |
    +----------+-----+-----+
    |          | 2.3 | 3.8 |
    |       42 | 2.6 | 2.6 |
    |       41 | 2.1 | 4.0 |
    |       38 | 2.2 | 3.4 |
    |       36 | 1.9 | 3.7 |
    |       37 | 1.8 | 4.0 |
    +----------+-----+-----+
    (6 rows)

    SELECT major_id, MIN(gpa), MAX(gpa) FROM students GROUP BY major_id HAVING MAX(gpa) = 4.0 ;
        
    +----------+-----+-----+
    | major_id | min | max |
    +----------+-----+-----+
    |       41 | 2.1 | 4.0 |
    |       37 | 1.8 | 4.0 |
    +----------+-----+-----+
    (2 rows)

    SELECT major_id, MIN(gpa) AS min_gpa , MAX(gpa) FROM students GROUP BY major_id HAVING MAX(gpa) = 4.0 ;
                
    +----------+---------+-----+
    | major_id | min_gpa | max |
    +----------+---------+-----+
    |       41 |     2.1 | 4.0 |
    |       37 |     1.8 | 4.0 |
    +----------+---------+-----+
    (2 rows)

    SELECT major_id, MIN(gpa) AS min_gpa , MAX(gpa) AS max_gpa FROM students GROUP BY major_id HAVING MAX(gpa) = 4.0 ;
                    
    +----------+---------+---------+
    | major_id | min_gpa | max_gpa |
    +----------+---------+---------+
    |       41 |     2.1 |     4.0 |
    |       37 |     1.8 |     4.0 |
    +----------+---------+---------+
    (2 rows)

    SELECT major_id, COUNT(*) AS number_of_students  MIN(gpa) AS min_gpa , MAX(gpa) AS max_gpa FROM students GROUP BY major_id HAVING MAX(gpa) = 4.0 ;
    ERROR:  syntax error at or near "MIN"
    LINE 1: SELECT major_id, COUNT(*) AS number_of_students  MIN(gpa) AS...
                                                            ^
    SELECT major_id, COUNT(*) AS number_of_students, MIN(gpa) AS min_gpa , MAX(gpa) AS max_gpa FROM students GROUP BY major_id HAVING MAX(gpa) = 4.0 ;
                               
    +----------+--------------------+---------+---------+
    | major_id | number_of_students | min_gpa | max_gpa |
    +----------+--------------------+---------+---------+
    |       41 |                  6 |     2.1 |     4.0 |
    |       37 |                  6 |     1.8 |     4.0 |
    +----------+--------------------+---------+---------+
    (2 rows)

    SELECT majoSELECT major_id, COUNT(major_id) AS number_of_students, MIN(gpa) AS min_gpa , MAX(gpa) AS max_gpa FROM students GROUP BY major_id HAVING MAX(gpa) = 4.0 ;
                            
    +----------+--------------------+---------+---------+
    | major_id | number_of_students | min_gpa | max_gpa |
    +----------+--------------------+---------+---------+
    |       41 |                  6 |     2.1 |     4.0 |
    |       37 |                  6 |     1.8 |     4.0 |
    +----------+--------------------+---------+---------+
    (2 rows)

    SELECT major_id, COUNT(major_id) AS number_of_students FROM students GROUP BY major_id;                 
    +----------+--------------------+
    | major_id | number_of_students |
    +----------+--------------------+
    |          |                  0 |
    |       42 |                  1 |
    |       41 |                  6 |
    |       38 |                  4 |
    |       36 |                  6 |
    |       37 |                  6 |
    +----------+--------------------+
    (6 rows)

    SELECT major_id, COUNT(*) AS number_of_students FROM students GROUP BY major_id;
                     
    +----------+--------------------+
    | major_id | number_of_students |
    +----------+--------------------+
    |          |                  8 |
    |       42 |                  1 |
    |       41 |                  6 |
    |       38 |                  4 |
    |       36 |                  6 |
    |       37 |                  6 |
    +----------+--------------------+
    (6 rows)


    SELECT major_id,
    COUNT(*) 
    AS number_of_students 
    FROM students 
    GROUP BY major_id 
    HAVING COUNT(*) < 8 ;
    
    +----------+--------------------+
    | major_id | number_of_students |
    +----------+--------------------+
    |       42 |                  1 |
    |       41 |                  6 |
    |       38 |                  4 |
    |       36 |                  6 |
    |       37 |                  6 |
    +----------+--------------------+
    (5 rows)


    SELECT major_id,
    COUNT(*) AS number_of_students,
    ROUND(AVG(gpa), 2) AS average_gpa
    FROM students
    GROUP BY major_id
    HAVING COUNT(*) > 1;
                            
    +----------+--------------------+-------------+
    | major_id | number_of_students | average_gpa |
    +----------+--------------------+-------------+
    |          |                  8 |        2.97 |
    |       41 |                  6 |        3.53 |
    |       38 |                  4 |        2.73 |
    |       36 |                  6 |        2.92 |
    |       37 |                  6 |        3.38 |
    +----------+--------------------+-------------+
    (5 rows)


-- Joining tables
    SELECT * FROM students FULL JOIN majors ON students.major_id = majors.major_id;
                                                    
    +------------+------------+--------------+----------+-----+----------+-------------------------+
    | student_id | first_name |  last_name   | major_id | gpa | major_id |          major          |
    +------------+------------+--------------+----------+-----+----------+-------------------------+
    |          6 | Rhea       | Kellems      |       36 | 2.5 |       36 | Database Administration |
    |          7 | Emma       | Gilbert      |          |     |          |                         |
    |          8 | Kimberly   | Whitley      |       37 | 3.8 |       37 | Web Development         |
    |          9 | Jimmy      | Felipe       |       36 | 3.7 |       36 | Database Administration |
    |         10 | Kyle       | Stimson      |          | 2.8 |          |                         |
    |         11 | Casares    | Hijo         |       41 | 4.0 |       41 | Game Design             |
    |         12 | Noe        | Savage       |          | 3.6 |          |                         |
    |         13 | Sterling   | Boss         |       41 | 3.9 |       41 | Game Design             |
    |         14 | Brian      | Davis        |          | 2.3 |          |                         |
    |         15 | Kaija      | Uronen       |       41 | 3.7 |       41 | Game Design             |
    |         16 | Faye       | Conn         |       41 | 2.1 |       41 | Game Design             |
    |         17 | Efren      | Reilly       |       37 | 3.9 |       37 | Web Development         |
    |         18 | Danh       | Nhung        |          | 2.4 |          |                         |
    |         19 | Maxine     | Hagenes      |       36 | 2.9 |       36 | Database Administration |
    |         20 | Larry      | Saunders     |       38 | 2.2 |       38 | Data Science            |
    |         21 | Karl       | Kuhar        |       37 |     |       37 | Web Development         |
    |         22 | Lieke      | Hazenveld    |       41 | 3.5 |       41 | Game Design             |
    |         23 | Obie       | Hilpert      |       37 |     |       37 | Web Development         |
    |         24 | Peter      | Booysen      |          | 2.9 |          |                         |
    |         25 | Nathan     | Turner       |       36 | 3.3 |       36 | Database Administration |
    |         26 | Gerald     | Osiki        |       38 | 2.2 |       38 | Data Science            |
    |         27 | Vanya      | Hassanah     |       41 | 4.0 |       41 | Game Design             |
    |         28 | Roxelana   | Florescu     |       36 | 3.2 |       36 | Database Administration |
    |         29 | Helene     | Parker       |       38 | 3.4 |       38 | Data Science            |
    |         30 | Mariana    | Russel       |       37 | 1.8 |       37 | Web Development         |
    |         31 | Ajit       | Dhungel      |          | 3.0 |          |                         |
    |         32 | Mehdi      | Vandenberghe |       36 | 1.9 |       36 | Database Administration |
    |         33 | Dejon      | Howell       |       37 | 4.0 |       37 | Web Development         |
    |         34 | Aliya      | Gulgowski    |       42 | 2.6 |       42 | System Administration   |
    |         35 | Ana        | Tupajic      |       38 | 3.1 |       38 | Data Science            |
    |         36 | Hugo       | Duran        |          | 3.8 |          |                         |
    |            |            |              |          |     |       39 | Network Engineering     |
    |            |            |              |          |     |       40 | Computer Programming    |
    +------------+------------+--------------+----------+-----+----------+-------------------------+
    (33 rows)

    SELECT * FROM students LEFT JOIN majors ON students.major_id = majors.major_id;
                                                    
    +------------+------------+--------------+----------+-----+----------+-------------------------+
    | student_id | first_name |  last_name   | major_id | gpa | major_id |          major          |
    +------------+------------+--------------+----------+-----+----------+-------------------------+
    |          6 | Rhea       | Kellems      |       36 | 2.5 |       36 | Database Administration |
    |          7 | Emma       | Gilbert      |          |     |          |                         |
    |          8 | Kimberly   | Whitley      |       37 | 3.8 |       37 | Web Development         |
    |          9 | Jimmy      | Felipe       |       36 | 3.7 |       36 | Database Administration |
    |         10 | Kyle       | Stimson      |          | 2.8 |          |                         |
    |         11 | Casares    | Hijo         |       41 | 4.0 |       41 | Game Design             |
    |         12 | Noe        | Savage       |          | 3.6 |          |                         |
    |         13 | Sterling   | Boss         |       41 | 3.9 |       41 | Game Design             |
    |         14 | Brian      | Davis        |          | 2.3 |          |                         |
    |         15 | Kaija      | Uronen       |       41 | 3.7 |       41 | Game Design             |
    |         16 | Faye       | Conn         |       41 | 2.1 |       41 | Game Design             |
    |         17 | Efren      | Reilly       |       37 | 3.9 |       37 | Web Development         |
    |         18 | Danh       | Nhung        |          | 2.4 |          |                         |
    |         19 | Maxine     | Hagenes      |       36 | 2.9 |       36 | Database Administration |
    |         20 | Larry      | Saunders     |       38 | 2.2 |       38 | Data Science            |
    |         21 | Karl       | Kuhar        |       37 |     |       37 | Web Development         |
    |         22 | Lieke      | Hazenveld    |       41 | 3.5 |       41 | Game Design             |
    |         23 | Obie       | Hilpert      |       37 |     |       37 | Web Development         |
    |         24 | Peter      | Booysen      |          | 2.9 |          |                         |
    |         25 | Nathan     | Turner       |       36 | 3.3 |       36 | Database Administration |
    |         26 | Gerald     | Osiki        |       38 | 2.2 |       38 | Data Science            |
    |         27 | Vanya      | Hassanah     |       41 | 4.0 |       41 | Game Design             |
    |         28 | Roxelana   | Florescu     |       36 | 3.2 |       36 | Database Administration |
    |         29 | Helene     | Parker       |       38 | 3.4 |       38 | Data Science            |
    |         30 | Mariana    | Russel       |       37 | 1.8 |       37 | Web Development         |
    |         31 | Ajit       | Dhungel      |          | 3.0 |          |                         |
    |         32 | Mehdi      | Vandenberghe |       36 | 1.9 |       36 | Database Administration |
    |         33 | Dejon      | Howell       |       37 | 4.0 |       37 | Web Development         |
    |         34 | Aliya      | Gulgowski    |       42 | 2.6 |       42 | System Administration   |
    |         35 | Ana        | Tupajic      |       38 | 3.1 |       38 | Data Science            |
    |         36 | Hugo       | Duran        |          | 3.8 |          |                         |
    +------------+------------+--------------+----------+-----+----------+-------------------------+
    (31 rows)

    SELECT * FROM students RIGHT JOIN majors ON students.major_id = majors.major_id;
                                                
    +------------+------------+--------------+----------+-----+----------+-------------------------+
    | student_id | first_name |  last_name   | major_id | gpa | major_id |          major          |
    +------------+------------+--------------+----------+-----+----------+-------------------------+
    |          6 | Rhea       | Kellems      |       36 | 2.5 |       36 | Database Administration |
    |          8 | Kimberly   | Whitley      |       37 | 3.8 |       37 | Web Development         |
    |          9 | Jimmy      | Felipe       |       36 | 3.7 |       36 | Database Administration |
    |         11 | Casares    | Hijo         |       41 | 4.0 |       41 | Game Design             |
    |         13 | Sterling   | Boss         |       41 | 3.9 |       41 | Game Design             |
    |         15 | Kaija      | Uronen       |       41 | 3.7 |       41 | Game Design             |
    |         16 | Faye       | Conn         |       41 | 2.1 |       41 | Game Design             |
    |         17 | Efren      | Reilly       |       37 | 3.9 |       37 | Web Development         |
    |         19 | Maxine     | Hagenes      |       36 | 2.9 |       36 | Database Administration |
    |         20 | Larry      | Saunders     |       38 | 2.2 |       38 | Data Science            |
    |         21 | Karl       | Kuhar        |       37 |     |       37 | Web Development         |
    |         22 | Lieke      | Hazenveld    |       41 | 3.5 |       41 | Game Design             |
    |         23 | Obie       | Hilpert      |       37 |     |       37 | Web Development         |
    |         25 | Nathan     | Turner       |       36 | 3.3 |       36 | Database Administration |
    |         26 | Gerald     | Osiki        |       38 | 2.2 |       38 | Data Science            |
    |         27 | Vanya      | Hassanah     |       41 | 4.0 |       41 | Game Design             |
    |         28 | Roxelana   | Florescu     |       36 | 3.2 |       36 | Database Administration |
    |         29 | Helene     | Parker       |       38 | 3.4 |       38 | Data Science            |
    |         30 | Mariana    | Russel       |       37 | 1.8 |       37 | Web Development         |
    |         32 | Mehdi      | Vandenberghe |       36 | 1.9 |       36 | Database Administration |
    |         33 | Dejon      | Howell       |       37 | 4.0 |       37 | Web Development         |
    |         34 | Aliya      | Gulgowski    |       42 | 2.6 |       42 | System Administration   |
    |         35 | Ana        | Tupajic      |       38 | 3.1 |       38 | Data Science            |
    |            |            |              |          |     |       39 | Network Engineering     |
    |            |            |              |          |     |       40 | Computer Programming    |
    +------------+------------+--------------+----------+-----+----------+-------------------------+
    (25 rows)


    SELECT * FROM students INNER JOIN majors ON students.major_id = majors.major_id;
                                                    
    +------------+------------+--------------+----------+-----+----------+-------------------------+
    | student_id | first_name |  last_name   | major_id | gpa | major_id |          major          |
    +------------+------------+--------------+----------+-----+----------+-------------------------+
    |          6 | Rhea       | Kellems      |       36 | 2.5 |       36 | Database Administration |
    |          8 | Kimberly   | Whitley      |       37 | 3.8 |       37 | Web Development         |
    |          9 | Jimmy      | Felipe       |       36 | 3.7 |       36 | Database Administration |
    |         11 | Casares    | Hijo         |       41 | 4.0 |       41 | Game Design             |
    |         13 | Sterling   | Boss         |       41 | 3.9 |       41 | Game Design             |
    |         15 | Kaija      | Uronen       |       41 | 3.7 |       41 | Game Design             |
    |         16 | Faye       | Conn         |       41 | 2.1 |       41 | Game Design             |
    |         17 | Efren      | Reilly       |       37 | 3.9 |       37 | Web Development         |
    |         19 | Maxine     | Hagenes      |       36 | 2.9 |       36 | Database Administration |
    |         20 | Larry      | Saunders     |       38 | 2.2 |       38 | Data Science            |
    |         21 | Karl       | Kuhar        |       37 |     |       37 | Web Development         |
    |         22 | Lieke      | Hazenveld    |       41 | 3.5 |       41 | Game Design             |
    |         23 | Obie       | Hilpert      |       37 |     |       37 | Web Development         |
    |         25 | Nathan     | Turner       |       36 | 3.3 |       36 | Database Administration |
    |         26 | Gerald     | Osiki        |       38 | 2.2 |       38 | Data Science            |
    |         27 | Vanya      | Hassanah     |       41 | 4.0 |       41 | Game Design             |
    |         28 | Roxelana   | Florescu     |       36 | 3.2 |       36 | Database Administration |
    |         29 | Helene     | Parker       |       38 | 3.4 |       38 | Data Science            |
    |         30 | Mariana    | Russel       |       37 | 1.8 |       37 | Web Development         |
    |         32 | Mehdi      | Vandenberghe |       36 | 1.9 |       36 | Database Administration |
    |         33 | Dejon      | Howell       |       37 | 4.0 |       37 | Web Development         |
    |         34 | Aliya      | Gulgowski    |       42 | 2.6 |       42 | System Administration   |
    |         35 | Ana        | Tupajic      |       38 | 3.1 |       38 | Data Science            |
    +------------+------------+--------------+----------+-----+----------+-------------------------+
    (23 rows)

    SELECT * FROM students LEFT JOIN majors ON students.major_id = majors.major_id;
                                                    
    +------------+------------+--------------+----------+-----+----------+-------------------------+
    | student_id | first_name |  last_name   | major_id | gpa | major_id |          major          |
    +------------+------------+--------------+----------+-----+----------+-------------------------+
    |          6 | Rhea       | Kellems      |       36 | 2.5 |       36 | Database Administration |
    |          7 | Emma       | Gilbert      |          |     |          |                         |
    |          8 | Kimberly   | Whitley      |       37 | 3.8 |       37 | Web Development         |
    |          9 | Jimmy      | Felipe       |       36 | 3.7 |       36 | Database Administration |
    |         10 | Kyle       | Stimson      |          | 2.8 |          |                         |
    |         11 | Casares    | Hijo         |       41 | 4.0 |       41 | Game Design             |
    |         12 | Noe        | Savage       |          | 3.6 |          |                         |
    |         13 | Sterling   | Boss         |       41 | 3.9 |       41 | Game Design             |
    |         14 | Brian      | Davis        |          | 2.3 |          |                         |
    |         15 | Kaija      | Uronen       |       41 | 3.7 |       41 | Game Design             |
    |         16 | Faye       | Conn         |       41 | 2.1 |       41 | Game Design             |
    |         17 | Efren      | Reilly       |       37 | 3.9 |       37 | Web Development         |
    |         18 | Danh       | Nhung        |          | 2.4 |          |                         |
    |         19 | Maxine     | Hagenes      |       36 | 2.9 |       36 | Database Administration |
    |         20 | Larry      | Saunders     |       38 | 2.2 |       38 | Data Science            |
    |         21 | Karl       | Kuhar        |       37 |     |       37 | Web Development         |
    |         22 | Lieke      | Hazenveld    |       41 | 3.5 |       41 | Game Design             |
    |         23 | Obie       | Hilpert      |       37 |     |       37 | Web Development         |
    |         24 | Peter      | Booysen      |          | 2.9 |          |                         |
    |         25 | Nathan     | Turner       |       36 | 3.3 |       36 | Database Administration |
    |         26 | Gerald     | Osiki        |       38 | 2.2 |       38 | Data Science            |
    |         27 | Vanya      | Hassanah     |       41 | 4.0 |       41 | Game Design             |
    |         28 | Roxelana   | Florescu     |       36 | 3.2 |       36 | Database Administration |
    |         29 | Helene     | Parker       |       38 | 3.4 |       38 | Data Science            |
    |         30 | Mariana    | Russel       |       37 | 1.8 |       37 | Web Development         |
    |         31 | Ajit       | Dhungel      |          | 3.0 |          |                         |
    |         32 | Mehdi      | Vandenberghe |       36 | 1.9 |       36 | Database Administration |
    |         33 | Dejon      | Howell       |       37 | 4.0 |       37 | Web Development         |
    |         34 | Aliya      | Gulgowski    |       42 | 2.6 |       42 | System Administration   |
    |         35 | Ana        | Tupajic      |       38 | 3.1 |       38 | Data Science            |
    |         36 | Hugo       | Duran        |          | 3.8 |          |                         |
    +------------+------------+--------------+----------+-----+----------+-------------------------+
    (31 rows)

    SELECT * FROM students LEFT JOIN majors ON students.major_id = majors.major_id WHERE major='Data Science';
                                            
    +------------+------------+-----------+----------+-----+----------+--------------+
    | student_id | first_name | last_name | major_id | gpa | major_id |    major     |
    +------------+------------+-----------+----------+-----+----------+--------------+
    |         20 | Larry      | Saunders  |       38 | 2.2 |       38 | Data Science |
    |         26 | Gerald     | Osiki     |       38 | 2.2 |       38 | Data Science |
    |         29 | Helene     | Parker    |       38 | 3.4 |       38 | Data Science |
    |         35 | Ana        | Tupajic   |       38 | 3.1 |       38 | Data Science |
    +------------+------------+-----------+----------+-----+----------+--------------+
    (4 rows)

    SELECT * FROM students LEFT JOIN majors ON students.major_id = majors.major_id WHERE major='Data Science' OR gpa >= 3.8;
                                            
    +------------+------------+-----------+----------+-----+----------+-----------------+
    | student_id | first_name | last_name | major_id | gpa | major_id |      major      |
    +------------+------------+-----------+----------+-----+----------+-----------------+
    |          8 | Kimberly   | Whitley   |       37 | 3.8 |       37 | Web Development |
    |         11 | Casares    | Hijo      |       41 | 4.0 |       41 | Game Design     |
    |         13 | Sterling   | Boss      |       41 | 3.9 |       41 | Game Design     |
    |         17 | Efren      | Reilly    |       37 | 3.9 |       37 | Web Development |
    |         20 | Larry      | Saunders  |       38 | 2.2 |       38 | Data Science    |
    |         26 | Gerald     | Osiki     |       38 | 2.2 |       38 | Data Science    |
    |         27 | Vanya      | Hassanah  |       41 | 4.0 |       41 | Game Design     |
    |         29 | Helene     | Parker    |       38 | 3.4 |       38 | Data Science    |
    |         33 | Dejon      | Howell    |       37 | 4.0 |       37 | Web Development |
    |         35 | Ana        | Tupajic   |       38 | 3.1 |       38 | Data Science    |
    |         36 | Hugo       | Duran     |          | 3.8 |          |                 |
    +------------+------------+-----------+----------+-----+----------+-----------------+
    (11 rows)

    SELECT first_name, last_name, major, gpa FROM students LEFT JOIN majors ON students.major_id = majors.major_id WHERE major='Data Science' OR gpa >= 3.8;
                            
    +------------+-----------+-----------------+-----+
    | first_name | last_name |      major      | gpa |
    +------------+-----------+-----------------+-----+
    | Kimberly   | Whitley   | Web Development | 3.8 |
    | Casares    | Hijo      | Game Design     | 4.0 |
    | Sterling   | Boss      | Game Design     | 3.9 |
    | Efren      | Reilly    | Web Development | 3.9 |
    | Larry      | Saunders  | Data Science    | 2.2 |
    | Gerald     | Osiki     | Data Science    | 2.2 |
    | Vanya      | Hassanah  | Game Design     | 4.0 |
    | Helene     | Parker    | Data Science    | 3.4 |
    | Dejon      | Howell    | Web Development | 4.0 |
    | Ana        | Tupajic   | Data Science    | 3.1 |
    | Hugo       | Duran     |                 | 3.8 |
    +------------+-----------+-----------------+-----+
    (11 rows)

    -- Aliasing tables can make the joins easier to read and work with
    students=> SELECT s.major_id FROM students AS s FULL JOIN majors AS m ON s.major_id = m.major_id;
        
    +----------+
    | major_id |
    +----------+
    |       36 |
    |          |
    |       37 |
    |       36 |
    |          |
    |       41 |
    |          |
    |       41 |
    |          |
    |       41 |
    |       41 |
    |       37 |
    |          |
    |       36 |
    |       38 |
    |       37 |
    |       41 |
    |       37 |
    |          |
    |       36 |
    |       38 |
    |       41 |
    |       36 |
    |       38 |
    |       37 |
    |          |
    |       36 |
    |       37 |
    |       42 |
    |       38 |
    |          |
    |          |
    |          |
    +----------+
    (33 rows)
    

    -- If the join column is named the same in both tables they can be joined by using the keyword USING()
    SELECT * FROM students FULL JOIN majors USING(major_id);
                                            
    +----------+------------+------------+--------------+-----+-------------------------+
    | major_id | student_id | first_name |  last_name   | gpa |          major          |
    +----------+------------+------------+--------------+-----+-------------------------+
    |       36 |          6 | Rhea       | Kellems      | 2.5 | Database Administration |
    |          |          7 | Emma       | Gilbert      |     |                         |
    |       37 |          8 | Kimberly   | Whitley      | 3.8 | Web Development         |
    |       36 |          9 | Jimmy      | Felipe       | 3.7 | Database Administration |
    |          |         10 | Kyle       | Stimson      | 2.8 |                         |
    |       41 |         11 | Casares    | Hijo         | 4.0 | Game Design             |
    |          |         12 | Noe        | Savage       | 3.6 |                         |
    |       41 |         13 | Sterling   | Boss         | 3.9 | Game Design             |
    |          |         14 | Brian      | Davis        | 2.3 |                         |
    |       41 |         15 | Kaija      | Uronen       | 3.7 | Game Design             |
    |       41 |         16 | Faye       | Conn         | 2.1 | Game Design             |
    |       37 |         17 | Efren      | Reilly       | 3.9 | Web Development         |
    |          |         18 | Danh       | Nhung        | 2.4 |                         |
    |       36 |         19 | Maxine     | Hagenes      | 2.9 | Database Administration |
    |       38 |         20 | Larry      | Saunders     | 2.2 | Data Science            |
    |       37 |         21 | Karl       | Kuhar        |     | Web Development         |
    |       41 |         22 | Lieke      | Hazenveld    | 3.5 | Game Design             |
    |       37 |         23 | Obie       | Hilpert      |     | Web Development         |
    |          |         24 | Peter      | Booysen      | 2.9 |                         |
    |       36 |         25 | Nathan     | Turner       | 3.3 | Database Administration |
    |       38 |         26 | Gerald     | Osiki        | 2.2 | Data Science            |
    |       41 |         27 | Vanya      | Hassanah     | 4.0 | Game Design             |
    |       36 |         28 | Roxelana   | Florescu     | 3.2 | Database Administration |
    |       38 |         29 | Helene     | Parker       | 3.4 | Data Science            |
    |       37 |         30 | Mariana    | Russel       | 1.8 | Web Development         |
    |          |         31 | Ajit       | Dhungel      | 3.0 |                         |
    |       36 |         32 | Mehdi      | Vandenberghe | 1.9 | Database Administration |
    |       37 |         33 | Dejon      | Howell       | 4.0 | Web Development         |
    |       42 |         34 | Aliya      | Gulgowski    | 2.6 | System Administration   |
    |       38 |         35 | Ana        | Tupajic      | 3.1 | Data Science            |
    |          |         36 | Hugo       | Duran        | 3.8 |                         |
    |       39 |            |            |              |     | Network Engineering     |
    |       40 |            |            |              |     | Computer Programming    |
    +----------+------------+------------+--------------+-----+-------------------------+
    (33 rows)