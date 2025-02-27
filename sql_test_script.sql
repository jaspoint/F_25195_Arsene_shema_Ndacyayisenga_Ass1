Microsoft Windows [Version 10.0.26100.2894]
(c) Microsoft Corporation. All rights reserved.

C:\Users\HP>sqlplus sys as sysdba

SQL*Plus: Release 21.0.0.0.0 - Production on Thu Feb 27 22:23:49 2025
Version 21.3.0.0.0

Copyright (c) 1982, 2021, Oracle.  All rights reserved.

Enter password:

Connected to:
Oracle Database 21c Enterprise Edition Release 21.0.0.0.0 - Production
Version 21.3.0.0.0

SQL> CREATE PLUGGABLE DATABASE thurs_251955_pdb_assI
  2  ADMIN USER admin IDENTIFIED BY admin
  3  ROLES = (DBA)
  4  DEFAULT TABLESPACE users
  5  FILE_NAME_CONVERT = ('C:\APP\HP\ORADATA\ORCL\PDBSEED\',
  6                       'C:\APP\HP\ORADATA\ORCL\THURS_251955_PDB_ASSI\');

Pluggable database created.

SQL> CREATE TABLE Event (
  2      event_id INT PRIMARY KEY,
  3      name VARCHAR(100),
  4      date DATE,
  5      location VARCHAR(100),
  6      description TEXT
  7  );
    date DATE,
    *
ERROR at line 4:
ORA-00904: : invalid identifier


SQL> CREATE TABLE Event (
  2      event_id INT PRIMARY KEY,
  3      name VARCHAR(100),
  4      event_date DATE,
  5      location VARCHAR(100),
  6      description CLOB
  7  );

Table created.

SQL> CREATE TABLE Seat (
  2      seat_id INT PRIMARY KEY,
  3      event_id INT,
  4      seat_number VARCHAR(10),
  5      section VARCHAR(50),
  6      FOREIGN KEY (event_id) REFERENCES Event(event_id)
  7  );

Table created.

SQL> CREATE TABLE Customer (
  2      customer_id INT PRIMARY KEY,
  3      name VARCHAR(100),
  4      email VARCHAR(100),
  5      phone VARCHAR(15)
  6  );

Table created.

SQL> CREATE TABLE Booking (
  2      booking_id INT PRIMARY KEY,
  3      customer_id INT,
  4      seat_id INT UNIQUE,
  5      booking_date TIMESTAMP,
  6      FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
  7      FOREIGN KEY (seat_id) REFERENCES Seat(seat_id)
  8  );

Table created.

SQL> CREATE TABLE Ticket (
  2      ticket_id INT PRIMARY KEY,
  3      booking_id INT,
  4      event_id INT,
  5      ticket_price NUMBER(10,2),
  6      ticket_type VARCHAR(50),
  7      FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
  8      FOREIGN KEY (event_id) REFERENCES Event(event_id)
  9  );

Table created.

SQL> INSERT INTO Event (event_id, name, event_date, location, description)
  2  VALUES (1, 'Tech Conference 2025', TO_DATE('2025-04-15', 'YYYY-MM-DD'), 'Convention Center', 'Annual tech event');

1 row created.

SQL> INSERT INTO Event (event_id, name, event_date, location, description)
  2  VALUES (2, 'Music Festival 2025', TO_DATE('2025-06-20', 'YYYY-MM-DD'), 'Open Air Arena', 'Outdoor music festival');

1 row created.

SQL> INSERT INTO Seat (seat_id, event_id, seat_number, section)
  2  VALUES (1, 1, 'A1', 'VIP');

1 row created.

SQL> INSERT INTO Seat (seat_id, event_id, seat_number, section)
  2  VALUES (2, 2, 'B5', 'Regular');

1 row created.

SQL> INSERT INTO Customer (customer_id, name, email, phone)
  2  VALUES (1, 'John Doe', 'john@example.com', '123456789');

1 row created.

SQL> INSERT INTO Customer (customer_id, name, email, phone)
  2  VALUES (2, 'Janet Ishimwe', 'janet@ishimwe.com', '078654321');

1 row created.

SQL> INSERT INTO Booking (booking_id, customer_id, seat_id, booking_date)
  2  VALUES (1, 1, 1, SYSTIMESTAMP);

1 row created.

SQL> INSERT INTO Booking (booking_id, customer_id, seat_id, booking_date)
  2  VALUES (2, 2, 2, SYSTIMESTAMP);

1 row created.

SQL> INSERT INTO Ticket (ticket_id, booking_id, event_id, ticket_price, ticket_type)
  2  VALUES (1, 1, 1, 150.00, 'VIP');

1 row created.

SQL> INSERT INTO Ticket (ticket_id, booking_id, event_id, ticket_price, ticket_type)
  2  VALUES (2, 2, 2, 50.00, 'Regular');

1 row created.

SQL> UPDATE Customer
  2  SET name = 'John Dylan', email = 'john@dylan.com'
  3  WHERE customer_id = 1;

1 row updated.

SQL> SELECT
  2      c.name AS customer_name,
  3      s.seat_number,
  4      e.name AS event_name,
  5      b.booking_date
  6  FROM Booking b
  7  JOIN Customer c ON b.customer_id = c.customer_id
  8  JOIN Seat s ON b.seat_id = s.seat_id
  9  JOIN Event e ON s.event_id = e.event_id;

CUSTOMER_NAME
--------------------------------------------------------------------------------
SEAT_NUMBE
----------
EVENT_NAME
--------------------------------------------------------------------------------
BOOKING_DATE
---------------------------------------------------------------------------
John Dylan
A1
Tech Conference 2025
27-FEB-25 10.34.21.644000 PM


CUSTOMER_NAME
--------------------------------------------------------------------------------
SEAT_NUMBE
----------
EVENT_NAME
--------------------------------------------------------------------------------
BOOKING_DATE
---------------------------------------------------------------------------
Janet Ishimwe
B5
Music Festival 2025
27-FEB-25 10.34.30.352000 PM


SQL> Select * from customer;

CUSTOMER_ID
-----------
NAME
--------------------------------------------------------------------------------
EMAIL
--------------------------------------------------------------------------------
PHONE
---------------
          1
John Dylan
john@dylan.com
123456789


CUSTOMER_ID
-----------
NAME
--------------------------------------------------------------------------------
EMAIL
--------------------------------------------------------------------------------
PHONE
---------------
          2
Janet Ishimwe
janet@ishimwe.com
078654321


SQL> SELECT name, email
  2  FROM Customer
  3  WHERE customer_id IN (
  4      SELECT b.customer_id
  5      FROM Booking b
  6      JOIN Seat s ON b.seat_id = s.seat_id
  7      WHERE s.section = 'VIP'
  8  );

NAME
--------------------------------------------------------------------------------
EMAIL
--------------------------------------------------------------------------------
John Dylan
john@dylan.com


SQL> SELECT booking_id, customer_id, seat_id, booking_date
  2  FROM Booking
  3  WHERE booking_date >= SYSDATE - 7;

BOOKING_ID CUSTOMER_ID    SEAT_ID
---------- ----------- ----------
BOOKING_DATE
---------------------------------------------------------------------------
         1           1          1
27-FEB-25 10.34.21.644000 PM

         2           2          2
27-FEB-25 10.34.30.352000 PM


SQL>