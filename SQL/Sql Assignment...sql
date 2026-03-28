create database Company_X;

CREATE TABLE Company (
    CompanyID INT PRIMARY KEY,
    CompanyName VARCHAR(45),
    Street VARCHAR(45),
    City VARCHAR(45),
    State VARCHAR(2),
    Zip VARCHAR(10)
);

# 1) Statement to create the Contact table 

CREATE TABLE Contact (
    ContactID INT PRIMARY KEY,
    CompanyID INT,
    FirstName VARCHAR(45),
    LastName VARCHAR(45),
    Street varchar(20),
    City varchar(10),
    State varchar(20),
    Zip varchar(10),
    Ismain boolean,
    Email varchar(45),
    Phone varchar(12),
    FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID)
)  ENGINE=INNODB;

# 2) Statement to create the Employee table

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(45),
    LastName VARCHAR(45),
    Salary decimal(10,2),
    HireDate Date,
    JobTitle Varchar(25),
    Email varchar(25),
    Phone varchar(12));
) ENGINE=InnoDB;

# 3) Statement to create the ContactEmployee table

CREATE TABLE ContactEmployee (
    ContactEmployeeID INT PRIMARY KEY,
    ContactID INT,
    EmployeeID INT,
    ContactDate DATE,
    Description VARCHAR(100),
    FOREIGN KEY (ContactID) REFERENCES Contact(ContactID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
) ENGINE=InnoDB;
drop table company;

Insert into Company (CompanyID, CompanyName, Street, City, State, Zip) 
values
(1, 'TechNova Pvt Ltd', 'MG Road', 'Mumbai', 'MH', '400001'),
(2, 'Urban Outfitters, Inc.', 'Ring Road', 'Delhi', 'DL', '110001'),
(3, 'Toll Brothers', 'HSR Layout', 'Bangalore', 'KA', '560102'),
(4, 'FinEdge Corp', 'SG Highway', 'Ahmedabad', 'GJ', '380015'),
(5, 'NextGen Labs', 'Baner Road', 'Pune', 'MH', '411045');

Insert into Contact (ContactID, CompanyID, FirstName, LastName, Street, City, State, Zip, IsMain, Email, Phone) 
values
(1, 1, 'Rahul', 'Sharma', 'MG Road', 'Mumbai', 'MH', '400001', TRUE, 'rahul@technova.com', '9876543210'),
(2, 2, 'Priya', 'Verma', 'Ring Road', 'Delhi', 'DL', '110001', TRUE, 'priya@datasoft.com', '9876501234'),
(3, 3, 'Dianne', 'Connor', 'HSR Layout', 'Bangalore', 'KA', '560102', FALSE, 'amit@cloudnet.com', '9123456780'),
(4, 3, 'Neha', 'Mehta', 'SG Highway', 'Ahmedabad', 'GJ', '380015', TRUE, 'neha@finedge.com', '9988776655'),
(5, 5, 'Karan', 'Singh', 'Baner Road', 'Pune', 'MH', '411045', FALSE, 'karan@nextgen.com', '9012345678');

insert into Employee (EmployeeID, FirstName, LastName, Salary, HireDate, JobTitle, Email, Phone)
Values
(1, 'Lesley', 'Bland', 50000.00, '2022-01-15', 'Data Analyst', 'ankit@gmail.com', '9000000001'),
(2, 'Jack', 'Lee', 60000.00, '2021-06-10', 'Manager', 'sneha@gmail.com', '9000000002'),
(3, 'Rohit', 'Das', 45000.00, '2023-03-20', 'Developer', 'rohit@gmail.com', '9000000003'),
(4, 'Pooja', 'Nair', 70000.00, '2020-09-05', 'HR', 'pooja@gmail.com', '9000000004'),
(5, 'Vikas', 'Yadav', 55000.00, '2022-11-11', 'Support Engineer', 'vikas@gmail.com', '9000000005');

insert into ContactEmployee (ContactEmployeeID, ContactID, EmployeeID, ContactDate, Description)
values
(1, 1, 1, '2024-01-10', 'Project discussion'),
(2, 2, 2, '2024-02-15', 'Business meeting'),
(3, 3, 3, '2024-03-05', 'Technical support'),
(4, 4, 4, '2024-03-20', 'HR policy discussion'),
(5, 5, 5, '2024-04-01', 'Client onboarding');

;
# Q.4) In the Employee table, the statement that changes Lesley Bland’s phone number to 215-555-8800 

update Employee
Set phone = '215-555-8800'
Where FirstName = 'Lesley' and LastName = 'Bland';

select * from Employee;

# Q.5) In the Company table, the statement that changes the name of “Urban Outfitters, Inc.” to “Urban Outfitters”. 

update company
set CompanyName = 'Urban Outfitters'
where CompanyName = 'Urban Outfitters, Inc.';                 

# 6) In ContactEmployee table, the statement that removes Dianne Connor’s contact event with Jack Lee (one statement).

delete from contactEmployee
where ContactEmployeeID = (
SELECT ContactEmployeeID FROM (
     select contactEmployeeID from contactEmployee ce
     join Contact c on ce.ContactID = c.ContactID
     join Employee e on ce.EmployeeID = e.EmployeeID
	where c.FirstName = 'Dianne' and c.LastName = 'Connor'
    and e.FirstName = 'Jack' and e.LastName = 'Lee')
    As temp
);

select * from company;
select * from contact;  

# Q.7) Write the SQL SELECT query that displays the names of the employees that have contacted Toll Brothers (one statement). 
#	   Run the SQL SELECT query in MySQL Workbench. Copy the results below as well. 

select company.CompanyName,
	   contact.FirstName from company
join contact on company.CompanyID = contact.CompanyID
where CompanyName = "Toll Brothers";

/* 
8) What is the significance of “%” and “_” operators in the LIKE statement? 
Ans : % (Percent)

Meaning: Represents 0, 1, or many characters
Importance: Used for flexible searching when the exact text is not known

Example:
Where name Like 'A%' 

_ (Underscore)
Meaning: Represents exactly one character
Importance: Used when fixed number of characters is required

Example:
Where name Like 'A_'
Finds 2-letter names starting with A (Aj, Al)

9.  Explain normalization in the context of databases. 
ANS : Normalization is the process of organizing data in a database to reduce redundancy (duplicate data) and 
      improve data integrity (accuracy & consistency).

Importance:
Eliminates duplicate data
Ensures data consistency
Makes database efficient and easy to maintain

10. What does a join in MySQL mean? 
Ans :  A JOIN in MySQL is used to combine data from two or more tables based on a related column (common field).

Importance
Retrieves data from multiple tables in one query
Helps maintain normalized databases
Avoids data duplication

11. What do you understand about DDL, DCL, and DML in MySQL
ANS:     1. DDL (Data Definition Language)
       Meaning: Used to define or change database structure
	   Commands: CREATE, ALTER, DROP, TRUNCATE
       
       2. DML (Data Manipulation Language)
       Meaning: Used to manage data inside tables
	   Commands: INSERT, UPDATE, DELETE
       
       DCL (Data Control Language)
       Meaning: Used to control access/permissions
	   Commands: GRANT, REVOKE
       
12. What is the role of the MySQL JOIN clause in a query, and what are some
common types of joins?
ANS: 
    The JOIN clause is used to combine data from multiple tables based on a related column.

  Types of Joins:
INNER JOIN
LEFT JOIN (LEFT OUTER JOIN)
RIGHT JOIN (RIGHT OUTER JOIN)
FULL JOIN (FULL OUTER JOIN)
CROSS JOIN
SELF JOIN
*/
