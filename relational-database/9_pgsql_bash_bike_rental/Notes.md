# Bike rental shop notes

## Task

You are going to build a bike rental shop. 
It will have a database, and a bash script to interact with the database.

## Step by step process to create the db

Open Postgres

``` BASH
$ psql --username=freecodecamp --dbname=postgres
```

List DBs

``` SQL
postgres=> \l
postgres=>                                List of databases
+-----------+----------+----------+---------+---------+-----------------------+
|   Name    |  Owner   | Encoding | Collate |  Ctype  |   Access privileges   |
+-----------+----------+----------+---------+---------+-----------------------+
| postgres  | postgres | UTF8     | C.UTF-8 | C.UTF-8 |                       |
| template0 | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +|
|           |          |          |         |         | postgres=CTc/postgres |
| template1 | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +|
|           |          |          |         |         | postgres=CTc/postgres |
+-----------+----------+----------+---------+---------+-----------------------+
(3 rows)
```

Create DB, and connect to it:

``` SQL
postgres=> CREATE DATABASE bikes
postgres=> \c bikes
You are now connected to database "bikes" as user "freecodecamp".
```

## Set up tables

Create first table, bikes:

```SQL
-- Create empty table:
bikes=> CREATE TABLE bikes();
bikes=> CREATE TABLE
```

List tables

```SQL
-- See the details:
bikes=> \d
bikes=>             List of relations
+--------+-------+-------+--------------+
| Schema | Name  | Type  |    Owner     |
+--------+-------+-------+--------------+
| public | bikes | table | freecodecamp |
+--------+-------+-------+--------------+
(1 row)
```

Add rows

```SQL
-- Add the rows:
bikes=> ALTER TABLE bikes ADD COLUMN bike_id SERIAL PRIMARY KEY;
bikes=> ALTER TABLE
bikes=> ALTER TABLE bikes ADD COLUMN type VARCHAR(50) NOT NULL;
bikes=> ALTER TABLE
bikes=> ALTER TABLE bikes ADD COLUMN size INT NOT NULL;
bikes=> ALTER TABLE
bikes=> ALTER TABLE bikes ADD COLUMN available BOOLEAN NOT NULL DEFAULT TRUE;
bikes=> ALTER TABLE
-- See the details again:
bikes=> \d bikes
                                        Table "public.bikes"
+-----------+-----------------------+-----------+----------+----------------------------------------+
|  Column   |         Type          | Collation | Nullable |                Default                 |
+-----------+-----------------------+-----------+----------+----------------------------------------+
| bike_id   | integer               |           | not null | nextval('bikes_bike_id_seq'::regclass) |
| type      | character varying(50) |           | not null |                                        |
| size      | integer               |           | not null |                                        |
| available | boolean               |           | not null | true                                   |
+-----------+-----------------------+-----------+----------+----------------------------------------+
Indexes:
    "bikes_pkey" PRIMARY KEY, btree (bike_id)
```

Create a customers table

```SQL
-- Create empty table:
bikes=> CREATE TABLE customers();
bikes=> CREATE TABLE
-- Add rows to the table:
bikes=> ALTER TABLE customers ADD COLUMN customer_id SERIAL PRIMARY KEY;
bikes=> ALTER TABLE
bikes=> ALTER TABLE customers ADD COLUMN phone VARCHAR(15) NOT NULL UNIQUE;
bikes=> ALTER TABLE
bikes=> ALTER TABLE customers ADD COLUMN name VARCHAR(40) NOT NULL;
bikes=> ALTER TABLE
-- Inspect the details of the table:
bikes=> \d customers
bikes=>                                            Table "public.customers"
+-------------+-----------------------+-----------+----------+------------------------------------------------+
|   Column    |         Type          | Collation | Nullable |                    Default                     |
+-------------+-----------------------+-----------+----------+------------------------------------------------+
| customer_id | integer               |           | not null | nextval('customers_customer_id_seq'::regclass) |
| phone       | character varying(15) |           | not null |                                                |
| name        | character varying(40) |           | not null |                                                |
+-------------+-----------------------+-----------+----------+------------------------------------------------+
Indexes:
    "customers_pkey" PRIMARY KEY, btree (customer_id)
    "customers_phone_key" UNIQUE CONSTRAINT, btree (phone)
```

Create a rentals table

```SQL
bikes=> CREATE TABLE renatals();
-- Typo, delete/drop the table:
bikes=> DROP TABLE renatals;
-- Actually set up the table:
bikes=> CREATE TABLE rentals();
-- Add columns:
bikes=> ALTER TABLE rentals ADD COLUMN rental_id SERIAL PRIMARY KEY;
bikes=> ALTER TABLE rentals ADD COLUMN customer_id INT NOT NULL;
bikes=> ALTER TABLE rentals ADD COLUMN bike_id INT NOT NULL;
bikes=> ALTER TABLE rentals ADD COLUMN date_rented DATE NOT NULL DEFAULT NOW();
bikes=> ALTER TABLE rentals ADD COLUMN date_returned DATE;
-- Add foreign keys:
bikes=> ALTER TABLE rentals ADD FOREIGN KEY(customer_id) REFERENCES customers(customer_id);
bikes=> ALTER TABLE rentals ADD FOREIGN KEY(bike_id) REFERENCES bikes(bike_id);
bikes=> \d rentals
bikes=>                                     Table "public.rentals"
+---------------+---------+-----------+----------+--------------------------------------------+
|    Column     |  Type   | Collation | Nullable |                  Default                   |
+---------------+---------+-----------+----------+--------------------------------------------+
| rental_id     | integer |           | not null | nextval('rentals_rental_id_seq'::regclass) |
| customer_id   | integer |           | not null |                                            |
| bike_id       | integer |           | not null |                                            |
| date_rented   | date    |           | not null | now()                                      |
| date_returned | date    |           |          |                                            |
+---------------+---------+-----------+----------+--------------------------------------------+
Indexes:
    "rentals_pkey" PRIMARY KEY, btree (rental_id)
Foreign-key constraints:
    "rentals_bike_id_fkey" FOREIGN KEY (bike_id) REFERENCES bikes(bike_id)
    "rentals_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
```

See all the tables

``` SQL
bikes=> \d
bikes=>                        List of relations
+--------+---------------------------+----------+--------------+
| Schema |           Name            |   Type   |    Owner     |
+--------+---------------------------+----------+--------------+
| public | bikes                     | table    | freecodecamp |
| public | bikes_bike_id_seq         | sequence | freecodecamp |
| public | customers                 | table    | freecodecamp |
| public | customers_customer_id_seq | sequence | freecodecamp |
| public | rentals                   | table    | freecodecamp |
| public | rentals_rental_id_seq     | sequence | freecodecamp |
+--------+---------------------------+----------+--------------+
(6 rows)
```

Insert data:

```SQL
-- Insert it:
bikes=> INSERT INTO bikes(type, size) VALUES('Mountain',27);
bikes=> INSERT INTO bikes(type, size) VALUES('Mountain',28);
bikes=> INSERT INTO bikes(type, size) VALUES('Mountain',29);
bikes=> INSERT INTO bikes(type, size) VALUES('ROAD',27);
bikes=> INSERT INTO bikes(type, size) VALUES('Road',27);
bikes=> INSERT INTO bikes(type, size) VALUES('Road',28);
bikes=> INSERT INTO bikes(type, size) VALUES('Road',29);
-- Insert multiple rows with one command:
bikes=> INSERT INTO bikes(type, size) VALUES('BMX',19),
('BMX',20),
('BMX',21);
-- Verify with SELECT:
bikes=> select * FROM bikes;
                     
+---------+----------+------+-----------+
| bike_id |   type   | size | available |
+---------+----------+------+-----------+
|       1 | Mountain |   27 | t         |
+---------+----------+------+-----------+
(1 row)
-- Remove bike by deleting:
bikes=> DELETE FROM bikes WHERE type='ROAD';
```

## Backup DB by exporting it:

Export entire db with tables and content bash command:

```BASH
$ pg_dump --clean --create --inserts --username=freecodecamp bikes > bikes.sql
```

Import the exported file in bash:

```BASH
$ psql -U postgres < students.sql
```
