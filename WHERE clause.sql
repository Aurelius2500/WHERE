-- Database Basics: The WHERE Clause

-- In this video, we will be exploring the same two tables that we have been using in previous tutorials, but with more data
-- We will be inspecting the WHERE clause
-- Notice how the Houses table has an Owner ID column
CREATE TABLE Houses (
Owner_ID VARCHAR(100),
Street VARCHAR(200),
[State] VARCHAR(200),
Price INT,
Price_Date DATE,
Years_since_construction INT
);

INSERT INTO Houses (Owner_ID, Street, [State], Price, Price_Date, Years_since_construction)
VALUES ('1', '240 Main Street', 'CA', 1900000, '2019-01-01', 18), 
('1', '140 Maple Street', 'GA', 1300000, '2021-01-01', 5),
('2', '555 New Way', 'TX', 1100000, '2017-01-01', 12),
('2', '14 Paradise Street', 'MO', 700000, '2020-01-01', 30),
('4', '123 School Street', 'MI', 400000, '2019-01-01', 18),
('1', '70 Smith Way', 'VA', 1500000, '2012-07-10', 12),
('2', '230 Valley Way', 'TX', 1200000, '2007-02-08', 2),
('1', '23 King Drive', 'CA', 3300000, '2022-04-08', 5),
('3', '12 Felicity Way', 'RI', 2200000, '2017-04-12', 1),
('2', '34 Hollow Drive', 'FL', 1950000, '2019-05-29', 2),
('2', '345 Forest Drive', 'FL', 1900000, '2020-05-29', 2),
(NULL, '123 Rock Drive', 'MO', 1000000, '2016-03-29', 12);

-- Recall that the Houses table has the following columns
-- Street is the address of the house
-- State is the U.S State in which the house is located
-- Price is the current listed price of the house
-- Price_Date is when the price was retrieved
-- Years_since_construction is how many years have passed since the house was built

-- We will then create a second table called Owners
CREATE TABLE Owners (
Owner_ID VARCHAR(100),
First_Name VARCHAR(100),
Last_Name VARCHAR(100),
Debt INT
);
-- Owner ID is a unique identifier for each owner
-- First_Name is the given name of the owner
-- Last_Name is the family name of the owner
-- Debt is how much debt the owner has in total, if available

-- We will also need to populate the records
INSERT INTO Owners (Owner_ID, First_Name, Last_Name, Debt)
VALUES ('1', 'Jeremy', 'Smith', 150000),
('2', 'Sarah', 'Rich', 300000),
('3', 'Josh', 'Rice', 50000),
('4', 'Monica', 'Monique', 1500000);
-- We will start with both tables being joined from the FROM tutorial. This way, we have a structure to work from
-- In plain English, we take First Name and last name from the Owners table, and Street, State, Price, and Years_since_construction from the Houses table
SELECT O.First_Name, 
O.Last_Name, 
H.Street, 
H.[State],
H.Price,
H.Years_since_construction
FROM Owners O
FULL JOIN Houses H
ON O.Owner_ID = H.Owner_ID

-- The first concern that we have is that the first and last names are null for the last record
-- The first use of the WHERE clause is to exclude certain records, as it can be seen in the addition to the query below
SELECT O.First_Name, 
O.Last_Name, 
H.Street, 
H.[State],
H.Price,
H.Years_since_construction
FROM Owners O
FULL JOIN Houses H
ON O.Owner_ID = H.Owner_ID
WHERE H.Owner_ID IS NOT NULL

-- The IS NOT NULL constraint tells the query to retrieve records that are not null, or on other words, have a value
-- However, the WHERE clause can be used for so much more, as it is a filter, it can be used in multiple ways, such as finding the houses in California
SELECT O.First_Name, 
O.Last_Name, 
H.Street, 
H.[State],
H.Price,
H.Years_since_construction
FROM Owners O
FULL JOIN Houses H
ON O.Owner_ID = H.Owner_ID
WHERE State = 'CA'

-- Or the other way around, by negating the clause, we can get the houses that are not in California
SELECT O.First_Name, 
O.Last_Name, 
H.Street, 
H.[State],
H.Price,
H.Years_since_construction
FROM Owners O
FULL JOIN Houses H
ON O.Owner_ID = H.Owner_ID
WHERE State != 'CA'

-- We can use multiple conditions on the WHERE CLAUSE. For example, we can get all the records for houses in Georgia or Texas with IN
SELECT O.First_Name, 
O.Last_Name, 
H.Street, 
H.[State],
H.Price,
H.Years_since_construction
FROM Owners O
FULL JOIN Houses H
ON O.Owner_ID = H.Owner_ID
WHERE State IN ('GA', 'TX')

-- If we want to expand this to multiple columns, we can do it easily with OR
SELECT O.First_Name, 
O.Last_Name, 
H.Street, 
H.[State],
H.Price,
H.Years_since_construction
FROM Owners O
FULL JOIN Houses H
ON O.Owner_ID = H.Owner_ID
WHERE State IN ('GA', 'TX')
OR Years_since_construction > 10

-- We could also get the houses that are in Georgia or Texas and have been built more than 10 years ago with AND
SELECT O.First_Name, 
O.Last_Name, 
H.Street, 
H.[State],
H.Price,
H.Years_since_construction
FROM Owners O
FULL JOIN Houses H
ON O.Owner_ID = H.Owner_ID
WHERE State IN ('GA', 'TX')
AND Years_since_construction > 10

-- The last operation that we want to perform if we will not use the tables anymore is drop them
DROP TABLE Houses;
DROP TABLE Owners;