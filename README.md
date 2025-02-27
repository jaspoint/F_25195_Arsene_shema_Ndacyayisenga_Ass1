My names are Ndacyayisenga shema arsene Id 25195 and i'm majoring in sofware engineering

This is a database that has been developed to facilitate the management of a ticket reservation system for different events. It contains information about events, available seats, customer bookings, and tickets respectively issued for these bookings.

SQL Commands Summary
CREATE TABLE: This command creates tables Event, Seat, Customer, Booking, and Ticket by specifying their respective one-to-many and one-to-one relationships.
INSERT: This command adds example records namely events, seats, customers, booking, and tickets.
UPDATE: Dispatched modified customer info (name and email) to ensure authenticity.
JOIN: This is the command for unifying the data from the diverse tables forming the end-user details:
SUBQUERY: Used a subquery to get customers who had reserved VIP seats in the whole database by placing this subquery as a column in the SELECT statement.
DATE QUERY: The query used to select all records which were created for the past 7 days with SYSDATE.

Results and Transactions Summary
The current system can trace a specific customer who bought a particular seat, for which event, and at what price.
The transactions (inserts, updates) will resemble real event scheduling and customer interactions.
The selected queries revealed the most recent bookings, VIP customers, and the general summary of the bookings.
