SELECT * from Region
SELECT * from Categories
SELECT * from CustomerCustomerDemo
SELECT * from CustomerDemographics
SELECT * from Customers
SELECT * from Employees
SELECT * from EmployeeTerritories
SELECT * from Orders
SELECT * from Products
SELECT * from Shippers
SELECT * from Suppliers
SELECT * from Territories

--a)Mostre todos os supplier

SELECT Su.CompanyName from Suppliers as Su

--b)Mostre todas as categorias

SELECT Ca.CategoryName from Categories as Ca 

--c)Mostre o produto mais caro por categoria, ordenado por valor

SELECT Ca.CategoryName, Pr.ProductName, Max(pr.UnitPrice) AS MaxPrice 
from Categories as Ca    
INNER JOIN Products as Pr
on Ca.CategoryID = Pr.CategoryID 
GROUP by ca.CategoryName, Pr.ProductName
ORDER BY MaxPrice DESC

--d) Mostre o nome da categoria, o nome do produto, e o preço total dos 5 produtos com descontos mais elevado

SELECT top 5 Ca.CategoryName, Pr.ProductName, SUM((Pr.UnitPrice - Od.Discount) * Od.Quantity) as TotalPrice 
from Categories as Ca     
INNER JOIN Products as Pr 
on Ca.CategoryID = Pr.CategoryID 
INNER JOIN [Order Details] as Od 
on Pr.ProductID = Od.ProductID
GROUP BY Ca.CategoryName, Pr.ProductName
ORDER by TotalPrice DESC


--e) Mostre o primeiro e último nome dos empregados, o nome dos territórios e das regiões atribuídos a cada um.

SELECT Em.FirstName, Em.LastName, Te.TerritoryDescription, Re.RegionDescription from Employees as Em
inner JOIN EmployeeTerritories as ET 
on Em.EmployeeID = ET.EmployeeID
INNER JOIN Territories as Te 
on ET.TerritoryID = TE.TerritoryID
INNER JOIN Region as Re 
on Te.RegionID = Re.RegionID

--f. Mostrar qual o volume de negócios por cidade

SELECT cu.City, Sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) as TotalSales from Customers as Cu 
INNER JOIN Orders as Ord 
on Cu.CustomerID = Ord.CustomerID
INNER JOIN [Order Details] as od 
on ord.OrderID = od.OrderID
GROUP BY cu.City
ORDER by TotalSales Desc 

--g. Mostrar quais os cientes que não fizeram compras

SELECT cu.CustomerID, cu.CompanyName from Customers as Cu 
LEFT JOIN Orders as Ord 
on Cu.CustomerID = Ord.CustomerID
WHERE ord.OrderID is NULL

--h. Mostrar quantas encomendas cada transportadora transportou.

SELECT ord.ShipVia, COUNT(*) as NumOrders from Orders as Ord 
GROUP by ord.ShipVia

--i. Mostre o primeiro e último nome dos empregados e o primeiro e último nome do responsável de cada um dele

SELECT Em.FirstName as EmployeeFristName, Em.LastName AS EmployeeLastName ,Man.FirstName as ManagerFristName, Man.LastName AS ManagerLastName
from Employees as Em
left JOIN Employees as Man on em.ReportsTo = man.EmployeeID --tive de associar parametros na mesma tabela para obter o que queria
ORDER by EmployeeFristName, EmployeeLastName

--j. Categorias vendidas por regiões de Empregados

SELECT Em.region, Ca.CategoryName, Count(Distinct(ord.OrderID)) as TotalOrders from Employees as Em 
JOIN Orders as Ord ON Em.EmployeeID = Ord.EmployeeID
JOIN [Order Details] as Od ON Ord.OrderID = od.OrderID
JOIN Products AS Pr ON od.ProductID = Pr.ProductID
JOIN Categories as Ca  ON Pr.CategoryID = Ca.CategoryID
GROUP by em.Region, ca.CategoryName
ORDER by em.Region, TotalOrders DESC

--k. Categorias vendidas no mês abril de 1997

SELECT Ca.CategoryName, Sum(od.Quantity) as TotalQuantidades from Employees as Em 
JOIN Orders as Ord ON Em.EmployeeID = Ord.EmployeeID
JOIN [Order Details] as Od ON Ord.OrderID = od.OrderID
JOIN Products AS Pr ON od.ProductID = Pr.ProductID
JOIN Categories as Ca  ON Pr.CategoryID = Ca.CategoryID
WHERE MONTH(ord.OrderDate) = 4 and YEAR(ord.OrderDate) = 1997
GROUP by ca.CategoryName
ORDER BY TotalQuantidades DESC


--l. Pedidos (Orders) que tenham sido enviados apos o sexto dia do pedido

SELECT ord.OrderID from Orders as Ord 
where DATEDIFF(DAY, ord.OrderDate, ord.ShippedDate) >6




