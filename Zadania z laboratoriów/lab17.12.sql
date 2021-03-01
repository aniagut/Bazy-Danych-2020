--6. Który z przewoŸników by³ najaktywniejszy (przewióz³ najwiêksz¹ liczbê zamówieñ)
--w 1997r, podaj nazwê tego przewoŸnika

SELECT TOP 1 companyname
FROM shippers
INNER JOIN orders
ON shippers.ShipperID=orders.shipvia AND year(shippeddate)=1997
GROUP BY companyname, shippers.shipperid
ORDER BY COUNT(orderid) DESC







--7.Który z pracowników obs³u¿y³ najwiêksz¹ liczbê zamówieñ w 1997r, podaj imiê i
--nazwisko takiego pracownika

SELECT TOP 1 firstname, lastname, COUNT(orderid)
FROM employees
INNER JOIN orders
ON employees.EmployeeID=orders.EmployeeID AND year(orderdate)=1997
GROUP BY firstname, lastname
ORDER BY COUNT(orderid) DESC






--8. Dla ka¿dego pracownika (imiê i nazwisko) podaj ³¹czn¹ wartoœæ zamówieñ
--obs³u¿onych przez tego pracownika

SELECT firstname, lastname,ROUND(SUM(quantity*unitprice*(1-discount)),2)
FROM employees
INNER JOIN orders
ON employees.EmployeeID=orders.EmployeeID
INNER JOIN [order details]
ON orders.OrderID=[Order Details].orderid
GROUP BY firstname,lastname



--8.1. Ogranicz wynik do pracowników, którzy maj¹ podw³adnych

SELECT e.firstname,e.lastname,CAST(SUM(quantity*unitprice*(1-discount)) as decimal (10,2))
FROM employees AS e
INNER JOIN orders
ON e.EmployeeID=orders.EmployeeID
INNER JOIN [order details]
ON orders.OrderID=[Order Details].orderid
INNER JOIN employees em2
ON e.EmployeeID=em2.ReportsTo 
GROUP BY e.firstname,e.lastname






--8.2. Ogranicz wynik do pracowników, którzy nie maj¹ podw³adnych

SELECT e.firstname, e.lastname,CAST(SUM(quantity*unitprice*(1-discount)) as decimal (10,2))
FROM employees AS e
INNER JOIN orders
ON e.EmployeeID=orders.EmployeeID
INNER JOIN [order details]
ON orders.OrderID=[Order Details].orderid
LEFT JOIN employees em2
ON e.EmployeeID=em2.ReportsTo 
WHERE em2.EmployeeID IS NULL
GROUP BY e.firstname,e.lastname




--9. Wybierz nazwy i numery telefonów klientów, którzy kupowali produkty z kategorii Confections.

SELECT DISTINCT C.CompanyName, C.Phone
FROM Customers AS C
INNER JOIN Orders O on C.CustomerID = O.CustomerID
INNER JOIN [Order Details] OD on OD.OrderID = O.OrderID
INNER JOIN Products P on OD.ProductID = P.ProductID
INNER JOIN Categories C2 on P.CategoryID = C2.CategoryID
WHERE C2.CategoryName = 'Confections'




--10.Wybierz nazwy i numery telefonów klientów, którzy nie kupowali produktów z kategorii Confections.

SELECT C2.CompanyName, C2.Phone
FROM Orders O
INNER JOIN [Order Details] OD on OD.OrderID = O.OrderID
INNER JOIN Products P on OD.ProductID = P.ProductID
INNER JOIN Categories C on P.CategoryID = C.CategoryID and
C.CategoryName = 'Confections'
RIGHT OUTER JOIN Customers as C2 on C2.CustomerID = O.CustomerID
where O.orderid is null




--11. Wybierz nazwy i numery telefonów klientów, którzy w marcu 1997 nie kupowali produktów z kategorii Confections.
SELECT DISTINCT C2.CompanyName,C2.CustomerID, C2.Phone
FROM Customers AS C1
INNER JOIN Orders O on C1.CustomerID = O.CustomerID and month(O.OrderDate)=3 and year(O.OrderDate)=1997
INNER JOIN [Order Details] OD on OD.OrderID = O.OrderID
INNER JOIN Products P on OD.ProductID = P.ProductID
INNER JOIN Categories C on P.CategoryID = C.CategoryID and
C.CategoryName = 'Confections'
RIGHT OUTER JOIN Customers as C2 on C2.CustomerID = C1.CustomerID
where C1.CustomerID is null



--12. Podaj liczbê? oraz wartoœæ zamówieñ (bez op³aty za przesy³kê) obs³u¿onych przez
--ka¿dego pracownika w 1997 roku. Dodatkowo dla ka¿dego pracownika podaj
--informacjê o tym, kiedy obs³u¿y³ ostatnie zamówienie w tym roku (najpóŸniejsza
--data zamówienia). Zbiór wynikowy powinien zawieraæ: imiê? i nazwisko pracownika, liczbê?
--obs³u¿onych zamówieñ, datê ostatniego zamówienia, wartoœæ obs³ugiwanych zamówieñ. Interesuj¹?
--nas tylko pracownicy, którzy w roku 1997 obs³u¿yli co najmniej 40 zamówieñ.

SELECT firstname, lastname, COUNT(O1.orderid), ROUND(SUM(quantity*unitprice*(1-discount)),2)
FROM Employees AS E1
INNER JOIN Orders O1
ON O1.employeeid=E1.employeeid and year(O1.orderdate)=1997
INNER JOIN [order details] OD
ON O1.OrderID=OD.orderid
GROUP BY firstname, lastname
HAVING COUNT(O1.orderid)>40


--13.Podaj nazwy produktów które nie by³y kupowane w marcu 1997 roku. Dla ka¿dego z takich podaj dodatkowo nazwê kategorii
--do której nale¿y produkt. Ogranicz wynik do produktów nale¿¹cych do kategorii, których nazwy zaczynaj¹
--siê na literê "c". Zbiór wynikowy powinien zawieraæ nazwê produktu i nazwê kategorii.

SELECT p2.productname, p2.categoryid
FROM Products AS p
INNER JOIN categories c 
ON c.CategoryID=p.CategoryID and c.CategoryName LIKE 'C%'
INNER JOIN  [Order Details] OD
ON OD.ProductID=p.ProductID
INNER JOIN Orders O
ON OD.OrderID=O.OrderID and month(orderdate)=3 and year(orderdate)=3
RIGHT OUTER JOIN Products p2
ON p.ProductID=p2.ProductID
WHERE p.ProductID IS NULL




