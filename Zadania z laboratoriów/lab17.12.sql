--6. Kt�ry z przewo�nik�w by� najaktywniejszy (przewi�z� najwi�ksz� liczb� zam�wie�)
--w 1997r, podaj nazw� tego przewo�nika

SELECT TOP 1 companyname
FROM shippers
INNER JOIN orders
ON shippers.ShipperID=orders.shipvia AND year(shippeddate)=1997
GROUP BY companyname, shippers.shipperid
ORDER BY COUNT(orderid) DESC







--7.Kt�ry z pracownik�w obs�u�y� najwi�ksz� liczb� zam�wie� w 1997r, podaj imi� i
--nazwisko takiego pracownika

SELECT TOP 1 firstname, lastname, COUNT(orderid)
FROM employees
INNER JOIN orders
ON employees.EmployeeID=orders.EmployeeID AND year(orderdate)=1997
GROUP BY firstname, lastname
ORDER BY COUNT(orderid) DESC






--8. Dla ka�dego pracownika (imi� i nazwisko) podaj ��czn� warto�� zam�wie�
--obs�u�onych przez tego pracownika

SELECT firstname, lastname,ROUND(SUM(quantity*unitprice*(1-discount)),2)
FROM employees
INNER JOIN orders
ON employees.EmployeeID=orders.EmployeeID
INNER JOIN [order details]
ON orders.OrderID=[Order Details].orderid
GROUP BY firstname,lastname



--8.1. Ogranicz wynik do pracownik�w, kt�rzy maj� podw�adnych

SELECT e.firstname,e.lastname,CAST(SUM(quantity*unitprice*(1-discount)) as decimal (10,2))
FROM employees AS e
INNER JOIN orders
ON e.EmployeeID=orders.EmployeeID
INNER JOIN [order details]
ON orders.OrderID=[Order Details].orderid
INNER JOIN employees em2
ON e.EmployeeID=em2.ReportsTo 
GROUP BY e.firstname,e.lastname






--8.2. Ogranicz wynik do pracownik�w, kt�rzy nie maj� podw�adnych

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




--9. Wybierz nazwy i numery telefon�w klient�w, kt�rzy kupowali produkty z kategorii Confections.

SELECT DISTINCT C.CompanyName, C.Phone
FROM Customers AS C
INNER JOIN Orders O on C.CustomerID = O.CustomerID
INNER JOIN [Order Details] OD on OD.OrderID = O.OrderID
INNER JOIN Products P on OD.ProductID = P.ProductID
INNER JOIN Categories C2 on P.CategoryID = C2.CategoryID
WHERE C2.CategoryName = 'Confections'




--10.Wybierz nazwy i numery telefon�w klient�w, kt�rzy nie kupowali produkt�w z kategorii Confections.

SELECT C2.CompanyName, C2.Phone
FROM Orders O
INNER JOIN [Order Details] OD on OD.OrderID = O.OrderID
INNER JOIN Products P on OD.ProductID = P.ProductID
INNER JOIN Categories C on P.CategoryID = C.CategoryID and
C.CategoryName = 'Confections'
RIGHT OUTER JOIN Customers as C2 on C2.CustomerID = O.CustomerID
where O.orderid is null




--11. Wybierz nazwy i numery telefon�w klient�w, kt�rzy w marcu 1997 nie kupowali produkt�w z kategorii Confections.
SELECT DISTINCT C2.CompanyName,C2.CustomerID, C2.Phone
FROM Customers AS C1
INNER JOIN Orders O on C1.CustomerID = O.CustomerID and month(O.OrderDate)=3 and year(O.OrderDate)=1997
INNER JOIN [Order Details] OD on OD.OrderID = O.OrderID
INNER JOIN Products P on OD.ProductID = P.ProductID
INNER JOIN Categories C on P.CategoryID = C.CategoryID and
C.CategoryName = 'Confections'
RIGHT OUTER JOIN Customers as C2 on C2.CustomerID = C1.CustomerID
where C1.CustomerID is null



--12. Podaj liczb�? oraz warto�� zam�wie� (bez op�aty za przesy�k�) obs�u�onych przez
--ka�dego pracownika w 1997 roku. Dodatkowo dla ka�dego pracownika podaj
--informacj� o tym, kiedy obs�u�y� ostatnie zam�wienie w tym roku (najp�niejsza
--data zam�wienia). Zbi�r wynikowy powinien zawiera�: imi�? i nazwisko pracownika, liczb�?
--obs�u�onych zam�wie�, dat� ostatniego zam�wienia, warto�� obs�ugiwanych zam�wie�. Interesuj�?
--nas tylko pracownicy, kt�rzy w roku 1997 obs�u�yli co najmniej 40 zam�wie�.

SELECT firstname, lastname, COUNT(O1.orderid), ROUND(SUM(quantity*unitprice*(1-discount)),2)
FROM Employees AS E1
INNER JOIN Orders O1
ON O1.employeeid=E1.employeeid and year(O1.orderdate)=1997
INNER JOIN [order details] OD
ON O1.OrderID=OD.orderid
GROUP BY firstname, lastname
HAVING COUNT(O1.orderid)>40


--13.Podaj nazwy produkt�w kt�re nie by�y kupowane w marcu 1997 roku. Dla ka�dego z takich podaj dodatkowo nazw� kategorii
--do kt�rej nale�y produkt. Ogranicz wynik do produkt�w nale��cych do kategorii, kt�rych nazwy zaczynaj�
--si� na liter� "c". Zbi�r wynikowy powinien zawiera� nazw� produktu i nazw� kategorii.

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




