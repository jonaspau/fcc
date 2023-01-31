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

students=> SELECT COUNT(*) FROM students GROUP BY major_id;
     
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

students=> SELECT major_id, COUNT(*) FROM students GROUP BY major_id;
          
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


students=> SELECT major_id, MIN(gpa) FROM students GROUP BY major_id;
          
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

students=> SELECT major_id, MIN(gpa), MAX(gpa) FROM students GROUP BY major_id;
            
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

students=> SELECT major_id, MIN(gpa), MAX(gpa) FROM students GROUP BY major_id HAVING MAX(gpa) = 4.0 ;
      
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

students=> SELECT major_id, COUNT(*) AS number_of_students  MIN(gpa) AS min_gpa , MAX(gpa) AS max_gpa FROM students GROUP BY major_id HAVING MAX(gpa) = 4.0 ;
ERROR:  syntax error at or near "MIN"
LINE 1: SELECT major_id, COUNT(*) AS number_of_students  MIN(gpa) AS...
                                                         ^
students=> SELECT major_id, COUNT(*) AS number_of_students, MIN(gpa) AS min_gpa , MAX(gpa) AS max_gpa FROM students GROUP BY major_id HAVING MAX(gpa) = 4.0 ;
students=>                            
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

students=> SELECT major_id, COUNT(major_id) AS number_of_students FROM students GROUP BY major_id;                 
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

students=> SELECT major_id, COUNT(@) AS number_of_students FROM students GROUP BY major_id;
ERROR:  syntax error at or near ")"
LINE 1: SELECT major_id, COUNT(@) AS number_of_students FROM student...
                                ^
students=> SELECT major_id, COUNT(*) AS number_of_students FROM students GROUP BY major_id;
students=>                  
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


students=> SELECT major_id, COUNT(*) AS number_of_students FROM students GROUP BY major_id HAVING number_of_students > 8 ;
ERROR:  column "number_of_students" does not exist
LINE 1: ...f_students FROM students GROUP BY major_id HAVING number_of_...
                                                             ^
students=> SELECT major_id, COUNT(*) AS number_of_students FROM students GROUP BY major_id HAVING COUNT(*) > 8 ;
                 
+----------+--------------------+
| major_id | number_of_students |
+----------+--------------------+
+----------+--------------------+
(0 rows)

students=> SELECT major_id, COUNT(*) AS number_of_students FROM students GROUP BY major_id HAVING COUNT(*) < 8 ;
students=>                  
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
