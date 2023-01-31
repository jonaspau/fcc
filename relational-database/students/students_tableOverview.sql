codeally@c942270b00da:~/project$ psql --username=freecodecamp --dbname=students
Border style is 2.
Title is " ".
Pager usage is off.
psql (12.9 (Ubuntu 12.9-2.pgdg20.04+1))
Type "help" for help.

students=> \l
students=>                                  List of databases
+-----------+--------------+----------+---------+---------+-----------------------+
|   Name    |    Owner     | Encoding | Collate |  Ctype  |   Access privileges   |
+-----------+--------------+----------+---------+---------+-----------------------+
| postgres  | postgres     | UTF8     | C.UTF-8 | C.UTF-8 |                       |
| students  | freecodecamp | UTF8     | C.UTF-8 | C.UTF-8 |                       |
| template0 | postgres     | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +|
|           |              |          |         |         | postgres=CTc/postgres |
| template1 | postgres     | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +|
|           |              |          |         |         | postgres=CTc/postgres |
+-----------+--------------+----------+---------+---------+-----------------------+
(4 rows)


students=> \c
You are now connected to database "students" as user "freecodecamp".
students=> \d
students=>                       List of relations
+--------+-------------------------+----------+--------------+
| Schema |          Name           |   Type   |    Owner     |
+--------+-------------------------+----------+--------------+
| public | courses                 | table    | freecodecamp |
| public | courses_course_id_seq   | sequence | freecodecamp |
| public | majors                  | table    | freecodecamp |
| public | majors_courses          | table    | freecodecamp |
| public | majors_major_id_seq     | sequence | freecodecamp |
| public | students                | table    | freecodecamp |
| public | students_student_id_seq | sequence | freecodecamp |
+--------+-------------------------+----------+--------------+
(7 rows)


students=> \d students
students=>                                           Table "public.students"
+------------+-----------------------+-----------+----------+----------------------------------------------+
|   Column   |         Type          | Collation | Nullable |                   Default                    |
+------------+-----------------------+-----------+----------+----------------------------------------------+
| student_id | integer               |           | not null | nextval('students_student_id_seq'::regclass) |
| first_name | character varying(50) |           | not null |                                              |
| last_name  | character varying(50) |           | not null |                                              |
| major_id   | integer               |           |          |                                              |
| gpa        | numeric(2,1)          |           |          |                                              |
+------------+-----------------------+-----------+----------+----------------------------------------------+
Indexes:
    "students_pkey" PRIMARY KEY, btree (student_id)
Foreign-key constraints:
    "students_major_id_fkey" FOREIGN KEY (major_id) REFERENCES majors(major_id)

\d majors
                                        Table "public.majors"
+----------+-----------------------+-----------+----------+------------------------------------------+
|  Column  |         Type          | Collation | Nullable |                 Default                  |
+----------+-----------------------+-----------+----------+------------------------------------------+
| major_id | integer               |           | not null | nextval('majors_major_id_seq'::regclass) |
| major    | character varying(50) |           | not null |                                          |
+----------+-----------------------+-----------+----------+------------------------------------------+
Indexes:
    "majors_pkey" PRIMARY KEY, btree (major_id)
Referenced by:
    TABLE "majors_courses" CONSTRAINT "majors_courses_major_id_fkey" FOREIGN KEY (major_id) REFERENCES majors(major_id)
    TABLE "students" CONSTRAINT "students_major_id_fkey" FOREIGN KEY (major_id) REFERENCES majors(major_id)

students=> \d courses
students=>                                           Table "public.courses"
+-----------+------------------------+-----------+----------+--------------------------------------------+
|  Column   |          Type          | Collation | Nullable |                  Default                   |
+-----------+------------------------+-----------+----------+--------------------------------------------+
| course_id | integer                |           | not null | nextval('courses_course_id_seq'::regclass) |
| course    | character varying(100) |           | not null |                                            |
+-----------+------------------------+-----------+----------+--------------------------------------------+
Indexes:
    "courses_pkey" PRIMARY KEY, btree (course_id)
Referenced by:
    TABLE "majors_courses" CONSTRAINT "majors_courses_course_id_fkey" FOREIGN KEY (course_id) REFERENCES courses(course_id)

\d majors_courses
             Table "public.majors_courses"
+-----------+---------+-----------+----------+---------+
|  Column   |  Type   | Collation | Nullable | Default |
+-----------+---------+-----------+----------+---------+
| major_id  | integer |           | not null |         |
| course_id | integer |           | not null |         |
+-----------+---------+-----------+----------+---------+
Indexes:
    "majors_courses_pkey" PRIMARY KEY, btree (major_id, course_id)
Foreign-key constraints:
    "majors_courses_course_id_fkey" FOREIGN KEY (course_id) REFERENCES courses(course_id)
    "majors_courses_major_id_fkey" FOREIGN KEY (major_id) REFERENCES majors(major_id)

students=> SELECT * FROM majors
students-> ;
                   
+----------+-------------------------+
| major_id |          major          |
+----------+-------------------------+
|        1 | Database Administration |
|        2 | major                   |
|        3 | Web Development         |
|        4 | Data Science            |
+----------+-------------------------+
(4 rows)

students=> TRUNCATE majors;
ERROR:  cannot truncate a table referenced in a foreign key constraint
DETAIL:  Table "majors_courses" references "majors".
HINT:  Truncate table "majors_courses" at the same time, or use TRUNCATE ... CASCADE.
students=> TRUNCATE majors,students, majors_courses;
students=> TRUNCATE TABLE
TRUNCATE ma
students=> SELECT * FROM majors
;
          
+----------+-------+
| major_id | major |
+----------+-------+
+----------+-------+
(0 rows)

students=> SELECT * FROM majors_courses
;
            
+----------+-----------+
| major_id | course_id |
+----------+-----------+
+----------+-----------+
(0 rows)

students=> 
students=> SELECT * FROM students;
students=>                             
+------------+------------+-----------+----------+-----+
| student_id | first_name | last_name | major_id | gpa |
+------------+------------+-----------+----------+-----+
+------------+------------+-----------+----------+-----+
(0 rows)

SELECT * FROM courses;
                       
+-----------+--------------------------------+
| course_id |             course             |
+-----------+--------------------------------+
|         1 | Data Structures and Algorithms |
+-----------+--------------------------------+
(1 row)

students=> TRUNCATE courses;
ERROR:  cannot truncate a table referenced in a foreign key constraint
DETAIL:  Table "majors_courses" references "courses".
HINT:  Truncate table "majors_courses" at the same time, or use TRUNCATE ... CASCADE.
students=> TRUNCATE courses, majors_courses;
TRUNCATE TABLE
students=> SELECT * FROM courses;
           
+-----------+--------+
| course_id | course |
+-----------+--------+
+-----------+--------+
(0 rows)

students=> SELECT * FROM majors        
;
                   
+----------+-------------------------+
| major_id |          major          |
+----------+-------------------------+
|        5 | major                   |
|        6 | Database Administration |
|        7 | Web Development         |
|        8 | Data Science            |
+----------+-------------------------+
(4 rows)

students=> TRUNCATE majors,students, majors_courses;
students=> TRUNCATE TABLE

students=> SELECT * FROM majors
;
          
+----------+-------+
| major_id | major |
+----------+-------+
+----------+-------+
(0 rows)

students=> 