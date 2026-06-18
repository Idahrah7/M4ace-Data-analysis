--Select CustomerName as [Customer Name], Notes from Customers

--Select distinct CustomerName as [Customer Name] from Customers

--Select top(3) * from Customers

--select*
--from Customers 
--where State= 'wa'

--select*
--from Customers 
--where State <> 'wa'

--select*
--from Customers 
--where State != 'wa'
--/* also means not equal to /*


--select*
--from Customers 
--where State= 'wa' or State= 'NY'

--select*
--from Customers 
--where State  In('wa','ny','ut')

--select*
--from Customers 
--where State not In('wa','ny','ut')


--select*
--from Customers 
--where CustomerName = 'Tres Delicious' and country ='united states'

--select*
--from Customers 
--where CustomerName = 'Tres Delicious' and country ='united states' or Country = 'france'

--select*
--from Customers 
--where CustomerName like 'A%' and (country ='united states' or Country = 'france')

--select*
--from Customers 
--where CustomerName not like 'A%' and (country ='united states' or Country = 'france')


--SELECT TOP (1000) [OrderID]
--      ,[OrderDate]
--      ,[CustomerID]
--      ,[OrderTotal]
--  FROM [KCC].[dbo].[Orders]
--  where OrderTotal>1000


--SELECT TOP (1000) [OrderID]
--      ,[OrderDate]
--      ,[CustomerID]
--      ,[OrderTotal]
--  FROM [KCC].[dbo].[Orders]
--  where OrderTotal<=1000


--SELECT TOP (1000) [OrderID]
--      ,[OrderDate]
--      ,[CustomerID]
--      ,[OrderTotal]
--  FROM [KCC].[dbo].[Orders]
--  where OrderTotal between 1000 and 1500

--Select OrderID as 'Order ID' ,
--OrderDate as 'Order Date' ,
--OrderTotal as 'Order Total',
--CustomerName as 'Customer Name' ,
--Phone
--From Orders
--Join Customers on Orders.CustomerID = Customers. CustomerID



--Select OrderID as 'Order ID' ,
--OrderDate as 'Order Date' ,
--OrderTotal as 'Order Total',
--CustomerName as 'Customer Name' ,
--Phone
--From Orders o
--Join Customers c on o.CustomerID = c. CustomerID
--/* here i used an alais c and o/*

--Select OrderID as 'Order ID' ,
--OrderDate as 'Order Date' ,
--OrderTotal as 'Order Total',
--CustomerName as 'Customer Name' ,
--Phone
--From Orders o
--inner Join Customers c on o.CustomerID = c. CustomerID

--Select OrderID as 'Order ID' ,
--OrderDate as 'Order Date' ,
--OrderTotal as 'Order Total',
--CustomerName as 'Customer Name' ,
--Phone
--From Orders o
--right outer Join Customers c on o.CustomerID = c. CustomerID

--Select OrderID as 'Order ID' ,
--OrderDate as 'Order Date' ,
--OrderTotal as 'Order Total',
--CustomerName as 'Customer Name' ,
--Phone,
--c.customerId
--From Orders o
--left outer Join Customers c on o.CustomerID = c. CustomerID

--Select OrderID as 'Order ID' ,
--OrderDate as 'Order Date' ,
--OrderTotal as 'Order Total',
--CustomerName as 'Customer Name' ,
--Phone,
--c.customerId
--From Orders o
--left outer Join Customers c on o.CustomerID = c. CustomerID
--order by OrderTotal

--Select OrderID as 'Order ID' ,
--OrderDate as 'Order Date' ,
--OrderTotal as 'Order Total',
--CustomerName as 'Customer Name' ,
--Phone,
--c.customerId
--From Orders o
--left outer Join Customers c on o.CustomerID = c. CustomerID
--order by OrderTotal desc

--select * from Orders
--where OrderDate >= '2/18/2022'

--select * from Orders
--where OrderDate >= Dateadd(month, -1, getdate())
--/* i use this incase iwant to run the same query again next week it wont be hard/*

--select sum(OrderTotal) as 'Sum of Total Order'
-- from dbo. Orders
--where OrderDate >= '2/18/2022'
--group by CustomerID 

SELECT Customers.CustomerName, Orders.OrderDate, Orders.OrderID, Orders.OrderTotal
FROM   Customers INNER JOIN
             Orders ON Customers.CustomerID = Orders.CustomerID

