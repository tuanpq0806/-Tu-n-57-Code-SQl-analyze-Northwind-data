/* 32. High-value customers
We want to send all of our high-value customers a
special VIP gift. We're defining high-value
customers as those who've made at least 1 order with
a total value (not including the discount) equal to
$10,000 or more. We only want to consider orders
made in the year 2016. */

Select
Customers.CustomerID
,Customers.CompanyName
,Orders.OrderID
,TotalOrderAmount = SUM(Quantity * UnitPrice)
From Customers
Join Orders
on Orders.CustomerID = Customers.CustomerID
Join OrderDetails
on Orders.OrderID = OrderDetails.OrderID
Where
OrderDate >= '20160101'
and OrderDate < '20170101'
Group by
Customers.CustomerID
,Customers.CompanyName
,Orders.Orderid
Having Sum(Quantity * UnitPrice) > 10000
Order by TotalOrderAmount DESC

/* 33.  High-value customers - total orders
The manager has changed his mind. Instead of
requiring that customers have at least one individual
orders totaling $10,000 or more, he wants to define
high-value customers as those who have orders
totaling $15,000 or more in 2016. How would you
change the answer to the problem above? */

Select
Customers.CustomerID
,Customers.CompanyName
--,Orders.OrderID
,TotalOrderAmount = SUM(Quantity * UnitPrice)
From Customers
Join Orders
on Orders.CustomerID = Customers.CustomerID
Join OrderDetails
on Orders.OrderID = OrderDetails.OrderID
Where
OrderDate >= '20160101'
and OrderDate < '20170101'
Group by
Customers.CustomerID
,Customers.CompanyName
--,Orders.Orderid
Having sum(Quantity * UnitPrice) > 15000
Order by TotalOrderAmount desc;

/* 34. High-value customers - with discount
Change the above query to use the discount when
calculating high-value customers. Order by the total
amount which includes the discount.*/

Select
Customers.CustomerID
,Customers.CompanyName
,TotalsWithoutDiscount = SUM(Quantity * UnitPrice)
,TotalsWithDiscount = SUM(Quantity * UnitPrice * (1- Discount))
From Customers
Join Orders
on Orders.CustomerID = Customers.CustomerID
Join OrderDetails
on Orders.OrderID = OrderDetails.OrderID
Where
OrderDate >= '20160101'
and OrderDate < '20170101'
Group by
Customers.CustomerID
,Customers.CompanyName
Having sum(Quantity * UnitPrice * (1- Discount)) > 10000
Order by TotalsWithDiscount DESC;

/* 35. Month-end orders
At the end of the month, salespeople are likely to try
much harder to get orders, to meet their month-end
quotas. Show all orders made on the last day of the
month. Order by EmployeeID and OrderID */

Select
EmployeeID
,OrderID
,OrderDate
From Orders
Where OrderDate = EOMONTH(OrderDate )
Order by
EmployeeID
,OrderID

/* 36. Orders with many line items
The Northwind mobile app developers are testing an app that customers will use to show orders. In order
to make sure that even the largest orders will show up correctly on the app, they'd like some samples of
orders that have lots of individual line items. Show the 10 orders with the most line items, in order of
total line items */

Select top 10
Orders.OrderID
,TotalOrderDetails = count(*)
From Orders
Join OrderDetails
on Orders.OrderID = OrderDetails.OrderID
Group By Orders.OrderID
Order By count(*) desc

/* 37. Orders - random assortment
The Northwind mobile app developers would now like to just get a random assortment of orders for beta
testing on their app. Show a random set of 2% of all orders. */

Select top 2 percent
OrderID
From Orders
Order By NewID()

/* 38. Orders - accidental double-entry
Janet Leverling, one of the salespeople, has come to you with a request. She thinks that she accidentally
double-entered a line item on an order, with a different ProductID, but the same quantity. She
remembers that the quantity was 60 or more. Show all the OrderIDs with line items that match this, in order of OrderID */

Select OrderID, Quantity
From OrderDetails
Where Quantity >=60
Group by OrderID, Quantity
Having Count(*) > 1

/* 39. Orders - accidental double-entry details
Based on the previous question, we now want to show details of the order, for orders that match the above criteria */

With a as (
Select OrderID
From OrderDetails
Where Quantity >=60
Group by OrderID, Quantity
Having count (*) >1
)

Select OrderID, ProductID, UnitPrice, Quantity, Discount
From OrderDetails
Where OrderID IN (select OrderID from a)
Order by OrderID, Quantity

-- Cách 2
Select
OrderDetails.OrderID
,ProductID
,UnitPrice
,Quantity
,Discount
From OrderDetails
Join (
Select distinct
OrderID
From OrderDetails
Where Quantity >= 60
Group By OrderID, Quantity
Having Count(*) > 1
) PotentialProblemOrders
on PotentialProblemOrders.OrderID = OrderDetails.OrderID
Order by OrderID, ProductID

/* 41. Late orders
Some customers are complaining about their orders
arriving late. Which orders are late? */

Select OrderID,OrderDate, RequiredDate, ShippedDate
From Orders
Where ShippedDate >= RequiredDate

/* 42. Late orders - which employees?
Some salespeople have more orders arriving late than others. Maybe they're not following up on the order
process, and need more training. Which salespeople have the most orders arriving late? */

Select a.EmployeeID, b.LastName,
       Total_OrderID_late = Count(*)
From Orders as a
join Employees as b
On a.EmployeeID = b.EmployeeID
Where a.ShippedDate >= a.RequiredDate
Group by a.EmployeeID, b.LastName
Order by Total_OrderID_late desc

/* 43. Late orders vs. total orders
Andrew, the VP of sales, has been doing some more thinking some more about the problem of late orders.
He realizes that just looking at the number of orders arriving late for each salesperson isn't a good idea. It
needs to be compared against the total number of orders per salesperson. Return results like the following: */

With Lateorders_table as(
  Select EmployeeID, Total_Orders = Count(*)
  From Orders
  Where ShippedDate >= RequiredDate
  Group by EmployeeID
)
, All_Orders_table as(
  Select EmployeeID, Total_Orders = Count(*)
  From Orders
  Group by EmployeeID 
)

Select Employees.EmployeeID, LastName, All_Orders = All_Orders_table.Total_Orders, Lateorders= Lateorders_table.Total_Orders
From Employees
Join All_Orders_table
On All_Orders_table.EmployeeID = Employees.EmployeeID
Join Lateorders_table
On Employees.EmployeeID =  Lateorders_table.EmployeeID
Order by All_Orders, Lateorders desc





