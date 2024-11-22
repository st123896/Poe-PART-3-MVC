CREATE DATABASE MANAGEMEN;
USE MANAGEMEN;

CREATE TABLE CUSTOMERS(
CUSTOMER_ID VARCHAR(10) NOT NULL PRIMARY KEY,
CUSTOMER_NAME VARCHAR(50) NOT NULL

);


CREATE TABLE VENUES(
VENUE_CODE VARCHAR(5) NOT NULL PRIMARY KEY,
VENUE_NAME VARCHAR(50) NOT NULL,
ADDRESS VARCHAR(50) NOT NULL,
CITY VARCHAR(50) NOT NULL,
MAX_CAPACITY SMALLINT NOT NULL

);

CREATE TABLE ACCOMMODATION_BOOKINGS(
CUSTOMER_ID VARCHAR(10) NOT NULL 
FOREIGN KEY REFERENCES
CUSTOMERS(CUSTOMER_ID),
VENUE_CODE VARCHAR(5) NOT NULL
FOREIGN KEY REFERENCES
VENUES(VENUE_CODE),
CHECKIN_DATE DATE NOT NULL PRIMARY KEY,
NIGHTS SMALLINT NOT NULL,
RATE SMALLMONEY NOT NULL

);


INSERT INTO CUSTOMERS  (CUSTOMER_ID,CUSTOMER_NAME)  VALUES(
'123456' ,'Neo Petlele'),
('246810' ,'Derek Moore'),
('369121' ,'Pedro Ntaba'),
('654321' ,'Thabo Joe'),
('987654' ,'Dominique Woolridge'

)
SELECT * FROM CUSTOMERS

INSERT INTO VENUES (VENUE_CODE,VENUE_NAME,ADDRESS,CITY,MAX_CAPACITY) VALUES(
'V0001', 'Durbs Bed and Breakfast','12 Radar Drive','Durban', '2'),
('V0002' ,'Jacaranda Guesthouse','116 Clearwater Road','Pretoria', '6'),
('V0003', 'Sandton Sun ','1 Waterstone Drive','Sandton' ,'4'),
('V0004', 'Friendly City Hotel','2 Ring Road', 'Port Elizabeth ','4'),
('V0005', 'Belmont Self Catering', '1 Belmont Road','Cape Town', '10'

)
SELECT * FROM VENUES
INSERT INTO ACCOMMODATION_BOOKINGS(CUSTOMER_ID,VENUE_CODE,CHECKIN_DATE,NIGHTS, RATE) VALUES(
'123456', 'V0001', '2020?10?30' ,3 ,1500.00),
('246810', 'V0005', '2020?11?19' ,2 ,980.00),
('246810', 'V0004', '2020?10?15', 5 ,1100.00),
('654321', 'V0002', '2020?09?10', 1, 1350.00),
('987654', 'V0001', '2020?12?15' ,7 ,1300.00),
('123456', 'V0002', '2020?11?01', 3, 1350.00),
('246810', 'V0004', '2020?09?29', 4 ,2100.00

)
SELECT * FROM ACCOMMODATION_BOOKINGS


------------------
---Q.1.1

CREATE VIEW ExtendedBookings AS
SELECT 
    VENUE_CODE,
    CUSTOMER_ID,
    CHECKIN_DATE,
    NIGHTS
FROM 
    ACCOMMODATION_BOOKINGS
WHERE 
    YEAR(CHECKIN_DATE) = 2020
    AND NIGHTS >= 5;

SELECT * FROM ExtendedBookings;

	-------Q.1.2
	CREATE PROCEDURE FindVenueBookings
AS
BEGIN
    SELECT 
        VENUES.VENUE_NAME,
        CUSTOMERS.CUSTOMER_NAME,
        ACCOMMODATION_BOOKINGS.CHECKIN_DATE,
        ACCOMMODATION_BOOKINGS.NIGHTS
    FROM 
        ACCOMMODATION_BOOKINGS
    INNER JOIN 
        CUSTOMERS ON ACCOMMODATION_BOOKINGS.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID
    INNER JOIN 
        VENUES ON ACCOMMODATION_BOOKINGS.VENUE_CODE = VENUES.VENUE_CODE
    WHERE 
        ACCOMMODATION_BOOKINGS.VENUE_CODE = 'V0002';
END;


EXEC FindVenueBookings;


-----------------
SELECT 
    VENUES.VENUE_CODE,
    VENUES.VENUE_NAME,
    VENUES.ADDRESS,
    VENUES.CITY,
    VENUES.MAX_CAPACITY,
    CASE 
        WHEN ACCOMMODATION_BOOKINGS.VENUE_CODE IS NOT NULL THEN 'Bookings recorded'
        ELSE 'No bookings recorded'
    END AS [Booking Status]
FROM 
    VENUES
LEFT JOIN 
    ACCOMMODATION_BOOKINGS ON VENUES.VENUE_CODE = ACCOMMODATION_BOOKINGS.VENUE_CODE
GROUP BY 
    VENUES.VENUE_CODE, 
    VENUES.VENUE_NAME, 
    VENUES.ADDRESS, 
    VENUES.CITY, 
    VENUES.MAX_CAPACITY;