/* 1. Which shippers do we have? 
We have a table called Shippers. Return all the fields from all the shippers */

Select
*
From Shippers

/*2. Certain fields from Categories
In the Categories table, selecting all the fields using
this SQL:
Select * from Categories
…will return 4 columns. We only want to see two
columns, CategoryName and Description.*/

Select
CategoryName
,Description
from Categories

/* 3. Sales Representatives
We’d like to see just the FirstName, LastName, and
HireDate of all the employees with the Title of Sales
Representative. Write a SQL statement that returns
only those employees*/

Select
FirstName
,LastName
,HireDate
From Employees
Where
Title = 'Sales Representative'

/* 4. Sales Representatives in the United
States
Now we’d like to see the same columns as above, but
only for those employees that both have the title of
Sales Representative, and also are in the United
States */

Select
FirstName
,LastName
,HireDate
From Employees
Where
Title = 'Sales Representative'
and Country = 'USA'

/* 5. Orders placed by specific EmployeeID
Show all the orders placed by a specific employee.
The EmployeeID for this Employee (Steven
Buchanan) is 5 */

Select
OrderID
,OrderDate
From Orders
Where
EmployeeID = 5

/* 6. Suppliers and ContactTitles
In the Suppliers table, show the SupplierID,
ContactName, and ContactTitle for those Suppliers
whose ContactTitle is not Marketing Manager. */

Select
SupplierID
,ContactName
,ContactTitle
From Suppliers
Where
ContactTitle <> 'Marketing Manager'

/* 7. Products with “queso” in ProductName */

Select
ProductID
,ProductName
From Products
Where
ProductName like '%queso%'

/* 8. Orders shipping to France or Belgium
Looking at the Orders table, there’s a field called
ShipCountry. Write a query that shows the OrderID,
CustomerID, and ShipCountry for the orders where
the ShipCountry is either France or Belgium. */

Select
OrderID
,CustomerID
,ShipCountry
From Orders
where
ShipCountry = 'France'
or ShipCountry = 'Belgium'

/* 9. Orders shipping to any country in Latin
America. Now, instead of just wanting to return all the orders
from France of Belgium, we want to show all the
orders from any Latin American country. But we
don’t have a list of Latin American countries in a
table in the Northwind database. So, we’re going to
just use this list of Latin American countries that
happen to be in the Orders table:
Brazil
Mexico
Argentina
Venezuela
It doesn’t make sense to use multiple Or statements
anymore, it would get too convoluted. Use the In
statement */

Select
OrderID
,CustomerID
,ShipCountry
From Orders
where
ShipCountry in
(
'Brazil'
,'Mexico'
,'Argentina'
,'Venezuela')

/* 10. Employees, in order of age
For all the employees in the Employees table, show
the FirstName, LastName, Title, and BirthDate.
Order the results by BirthDate, so we have the oldest
employees first. */

Select
FirstName
,LastName
,Title
,BirthDate
From Employees
Order By Birthdate

/* 11. Showing only the Date with a
DateTime field
In the output of the query above, showing the
Employees in order of BirthDate, we see the time of
the BirthDate field, which we don’t want. Show only
the date portion of the BirthDate field. */

Select
FirstName
,LastName
,Title
,DateOnlyBirthDate = convert(date, BirthDate)
From Employees
Order By Birthdate

/* 12. Employees full name
Show the FirstName and LastName columns from
the Employees table, and then create a new column
called FullName, showing FirstName and LastName
joined together in one column, with a space inbetween */

Select
FirstName
,LastName
,FullName = FirstName + ' ' + LastName
From Employees

/* 13. OrderDetails amount per line item
In the OrderDetails table, we have the fields
UnitPrice and Quantity. Create a new field,
TotalPrice, that multiplies these two together. We’ll
ignore the Discount field for now.
In addition, show the OrderID, ProductID, UnitPrice,
and Quantity. Order by OrderID and ProductID */

Select
OrderID
,ProductID
,UnitPrice
,Quantity
,TotalPrice = UnitPrice * Quantity
From OrderDetails
Order by
OrderID
,ProductID

/* 14. How many customers?
How many customers do we have in the Customers
table? Show one value only, and don’t rely on getting
the recordcount at the end of a resultset */

Select
TotalCustomers = count(*)
from Customers

/* 15. When was the first order?
Show the date of the first order ever made in the
Orders table */

Select
FirstOrder = min(OrderDate)
From Orders

/* 16. Countries where there are customers
Show a list of countries where the Northwind
company has customers */

Select
Country
From Customers
Group by
Country

/* 17. Contact titles for customers
Show a list of all the different values in the
Customers table for ContactTitles. Also include a
count for each ContactTitle.
This is similar in concept to the previous question
“Countries where there are customers”
, except we
now want a count for each ContactTitle */

Select
ContactTitle
,TotalContactTitle = count(*)
From Customers
Group by
ContactTitle
Order by
count(*) desc

/* 18. Products with associated supplier
names
We’d like to show, for each product, the associated
Supplier. Show the ProductID, ProductName, and the
CompanyName of the Supplier. Sort by ProductID.*/

Select
ProductID
,ProductName
,Supplier = CompanyName
From Products
Join Suppliers
on Products.SupplierID = Suppliers.SupplierID

/* 19. Orders and the Shipper that was used
We’d like to show a list of the Orders that were
made, including the Shipper that was used. Show the
OrderID, OrderDate (date only), and CompanyName
of the Shipper, and sort by OrderID.
In order to not show all the orders (there’s more than
800), show only those rows with an OrderID of less
than 10300. */

Select
OrderID
,OrderDate = convert(date, OrderDate)
,Shipper = CompanyName
From Orders
join Shippers
on Shippers.ShipperID = Orders.ShipVia
Where
OrderID < 10300
Order by
OrderID








