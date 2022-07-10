/* 20. Categories, and the total products in
each category */

Select
CategoryName
,TotalProducts = count(*)
From Products
Join Categories
on Products.CategoryID = Categories.CategoryID
Group by
CategoryName
Order by
count(*) desc

/* 21. Total customers per country/city
In the Customers table, show the total number of
customers per Country and City */

Select
Country
,City
,TotalCustomer = Count(*)
From Customers
Group by
Country
,City
Order by
count(*) desc

/* 22. Products that need reordering
What products do we have in our inventory that
should be reordered? For now, just use the fields
UnitsInStock and ReorderLevel, where UnitsInStock
is less than the ReorderLevel, ignoring the fields
UnitsOnOrder and Discontinued.
Order the results by ProductID */

Select
ProductID
,ProductName
,UnitsInStock
,ReorderLevel
From Products
Where
UnitsInStock <= ReorderLevel
Order by ProductID

/* 23. Products that need reordering,
continued
Now we need to incorporate these fields—
UnitsInStock, UnitsOnOrder, ReorderLevel,
Discontinued—into our calculation. We’ll define
“products that need reordering” with the following:
UnitsInStock plus UnitsOnOrder are less than
or equal to ReorderLevel
The Discontinued flag is false (0). */

Select
ProductID
,ProductName
,UnitsInStock
,UnitsOnOrder
,ReorderLevel
,Discontinued
From Products
Where
UnitsInStock + UnitsOnOrder <= ReorderLevel
and Discontinued = 0
Order by ProductID

/* 24. Customer list by region
A salesperson for Northwind is going on a business
trip to visit customers, and would like to see a list of
all customers, sorted by region, alphabetically.
However, he wants the customers with no region
(null in the Region field) to be at the end, instead of
at the top, where you’d normally find the null values.
Within the same region, companies should be sorted
by CustomerID.*/

Select
CustomerID
,CompanyName
,Region
From Customers
Order By
Case
when Region is null then 1
else 0
End
,Region
,CustomerID

/* 25. High freight charges
Some of the countries we ship to have very high
freight charges. We'd like to investigate some more
shipping options for our customers, to be able to
offer them lower freight charges. Return the three
ship countries with the highest average freight
overall, in descending order by average freight */

Select Top 3
ShipCountry
,AverageFreight = Avg(freight)
From Orders
Group By ShipCountry
Order By AverageFreight desc

/* 26. High freight charges - 2015
We're continuing on the question above on high
freight charges. Now, instead of using all the orders
we have, we only want to see orders from the year
2015. */

Select Top 3
ShipCountry
,AverageFreight = avg(freight)
From Orders
Where
OrderDate >= '20150101'
and OrderDate < '20160101'
Group By ShipCountry
Order By AverageFreight desc

/* 28. High freight charges - last year
We're continuing to work on high freight charges.
We now want to get the three ship countries with the
highest average freight charges. But instead of
filtering for a particular year, we want to use the last
12 months of order data, using as the end date the last
OrderDate in Orders */

Select TOP (3)
ShipCountry
,AverageFreight = Avg(freight)
From Orders
Where
OrderDate >= Dateadd(yy, -1, (Select max(OrderDate) from Orders))
Group by ShipCountry
Order by AverageFreight desc

/* 29. Inventory list
We're doing inventory, and need to show information
like the below, for all orders. Sort by OrderID and
Product ID */

Select
Employees.EmployeeID
,Employees.LastName
,Orders.OrderID
,Products.ProductName
,OrderDetails.Quantity
From Employees
join Orders
on Orders.EmployeeID = Employees.EmployeeID
join OrderDetails
on Orders.OrderID = OrderDetails.OrderID
join Products
on Products.ProductID = OrderDetails.ProductID
Order by
Orders.OrderID
,Products.ProductID

/* 30. Customers with no orders
There are some customers who have never actually
placed an order. Show these customers. */

Select
Customers_CustomerID = Customers.CustomerID
,Orders_CustomerID = Orders.CustomerID
From Customers
left join Orders
on Orders.CustomerID = Customers.CustomerID
Where
Orders.CustomerID is null

/* 31. Customers with no orders for
EmployeeID 4
One employee (Margaret Peacock, EmployeeID 4)
has placed the most orders. However, there are some
customers who've never placed an order with her.
Show only those customers who have never placed
an order with her */

Select
Customers.CustomerID
,Orders.CustomerID
From Customers
left join Orders
on Orders.CustomerID = Customers.CustomerID
and Orders.EmployeeID = 4
Where
Orders.CustomerID is null

