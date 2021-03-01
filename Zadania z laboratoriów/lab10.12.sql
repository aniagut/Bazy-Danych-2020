-- Napisz polecenie, kt�re oblicza warto�� sprzeda�y dla ka�dego zam�wienia w tablicy order details
--i zwraca wynik posortowany w malej�cej kolejno�ci (wg warto�ci sprzeda�y).


SELECT orderid, SUM(UnitPrice*Quantity*(1-discount)) AS [total price]
FROM [order details]
GROUP BY orderid
ORDER BY [total price] DESC






--� Zmodyfikuj zapytanie z poprzedniego punktu, tak aby zwraca�o pierwszych 10 wierszy
--cena
SELECT TOP 10 orderid, SUM(UnitPrice*Quantity*(1-discount)) AS [total price]
FROM [order details]
GROUP BY orderid
ORDER BY [total price] DESC




--Podaj liczb� zam�wionych jednostek produkt�w dla produkt�w, dla kt�rych productid <3

SELECT productid,SUM(quantity)
FROM [order details]
WHERE productid<3
GROUP BY productid





--Zmodyfikuj zapytanie z poprzedniego punktu, tak aby podawa�o liczb� zam�wionych 
--jednostek produktu dla wszystkich produkt�w
 SELECT productid,SUM(quantity)
FROM [order details]
GROUP BY productid
ORDER BY productid




--Podaj nr zam�wienia oraz warto�� zam�wienia, dla zam�wie�, dla kt�rych ��czna liczba
--zamawianych jednostek produkt�w jest > 250 

SELECT orderid, SUM(unitprice*quantity*(1-discount)) AS [total price], SUM(quantity) AS [total quantity]
FROM [order details]
GROUP BY orderid
HAVING SUM(quantity)>250



--Dla ka�dego pracownika podaj liczb� obs�ugiwanych przez niego zam�wie�

SELECT employeeid,COUNT(orderid)
FROM orders
GROUP BY employeeid

 





--Dla ka�dego spedytora/przewo�nika podaj warto�� "op�ata za przesy�k�" przewo�onych przez niego zam�wie�


SELECT shipvia,SUM(freight) AS [op�ata za przesy�k�]
FROM orders
GROUP BY shipvia






--Dla ka�dego spedytora/przewo�nika podaj warto�� "op�ata za przesy�k�" przewo�onych przez niego zam�wie� w latach o 1996 do 1997
SELECT shipvia,orderid,SUM(freight) AS [op�ata za przesy�k�]
FROM orders
WHERE year(shippeddate) BETWEEN 1996 AND 1997
GROUP BY shipvia





--Dla ka�dego pracownika podaj liczb� obs�ugiwanych przez niego zam�wie� z podzia�em na lata i miesi�ce

SELECT customerid, year(orderdate) AS rok ,month(orderdate) AS miesi�c, COUNT(orderid) AS [ilo�� zam�wie�]
FROM orders
GROUP BY customerid, year(orderdate),month(orderdate)
WITH ROLLUP






--Dla ka�dej kategorii podaj maksymaln� i minimaln� cen� produktu w tej kategorii

SELECT categoryid, max(unitprice) AS [maksymalna cena],min(unitprice) AS [minimalna cena]
FROM products
GROUP BY categoryid





--join



--Wybierz nazwy i ceny produkt�w (baza northwind) o cenie jednostkowej pomi�dzy 20.00 a 30.00, dla ka�dego produktu podaj
--dane adresowe dostawcy

SELECT productname,unitprice,address,companyname,city,region,postalcode,country
FROM products
INNER JOIN suppliers
ON products.SupplierID=suppliers.SupplierID





--Wybierz nazwy produkt�w oraz inf. o stanie magazynu dla produkt�w dostarczanych przez firm� �Tokyo Traders�

SELECT productname, unitsinstock
FROM products
INNER JOIN Suppliers
ON Suppliers.SupplierID=Products.SupplierID
WHERE companyname='Tokyo Traders'





--Czy s� jacy� klienci kt�rzy nie z�o�yli �adnego zam�wienia w 1997 roku, je�li tak to poka� ich dane adresowe

SELECT companyname,address,city,region,postalcode,country,orderdate
FROM customers
INNER JOIN orders
ON Customers.CustomerID=Orders.CustomerID
WHERE orders.customerid NOT IN (SELECT customerid FROM orders WHERE year(orderdate)=1997)





--Wybierz nazwy i numery telefon�w dostawc�w, dostarczaj�cych produkty, kt�rych aktualnie nie ma w magazynie

SELECT companyname,phone
FROM suppliers
INNER JOIN products
ON Suppliers.SupplierID=Products.ProductID
WHERE isnull(unitsinstock,0)=0


----------------------------------------------------------------------------------------------------------------------------------


--Napisz polecenie, kt�re wy�wietla list� dzieci b�d�cych cz�onkami biblioteki (baza library). Interesuje nas imi�,
--nazwisko i data urodzenia dziecka.
SELECT firstname,lastname,birth_date
FROM member
INNER JOIN juvenile
ON member.member_no=juvenile.member_no





--Napisz polecenie, kt�re podaje tytu�y aktualnie wypo�yczonych ksi��ek
SELECT DISTINCT title
FROM title
INNER JOIN loan
ON title.title_no=loan.title_no





--Podaj informacje o karach zap�aconych za przetrzymywanie ksi��ki o tytule �Tao Teh King�.
--Interesuje nas data oddania ksi��ki, ile dni by�a przetrzymywana i jak� zap�acono kar�
 SELECT due_date, datediff(day,in_date,due_date),fine_paid
 FROM loanhist
 INNER JOIN title
 ON loanhist.title_no=title.title_no
 WHERE title='Tao Teh King' AND fine_paid IS NOT NULL


 


--Napisz polecenie kt�re podaje list� ksi��ek (mumery ISBN) zarezerwowanych przez osob� o nazwisku: Stephen A. Graff

SELECT isbn
FROM reservation
INNER JOIN member
ON reservation.member_no=member.member_no
WHERE firstname='Stephen' AND middleinitial='A' AND lastname='Graff'






--Wybierz nazwy i ceny produkt�w (baza northwind) o cenie jednostkowej pomi�dzy 20.00 a 30.00, dla ka�dego produktu podaj
--dane adresowe dostawcy, interesuj� nas tylko produkty z kategorii �Meat/Poultry�
SELECT productname,unitprice,companyname,address,city,region,postalcode,country
FROM products
INNER JOIN Suppliers
ON Products.SupplierID=Suppliers.SupplierID
INNER JOIN categories
ON Products.CategoryID=Categories.CategoryID
WHERE unitprice BETWEEN 20.00 AND 30.00 AND categoryname='Meat/Poultry'





--Wybierz nazwy i ceny produkt�w z kategorii �Confections� dla ka�dego produktu podaj nazw� dostawcy.
SELECT productname,unitprice,companyname
FROM products
INNER JOIN Suppliers
ON products.SupplierID=Suppliers.SupplierID
INNER JOIN Categories
ON Products.CategoryID=Categories.CategoryID
WHERE categoryname='Confections'







--Wybierz nazwy i numery telefon�w klient�w , kt�rym w 1997 roku przesy�ki dostarcza�a firma �United Package�
SELECT DISTINCT customers.companyname,customers.phone
FROM customers
INNER JOIN Orders
ON customers.CustomerID=orders.CustomerID AND year(orderdate)=1997
INNER JOIN shippers
ON shippers.ShipperID=Orders.ShipVia AND shippers.CompanyName='United Package'



--Wybierz nazwy i numery telefon�w klient�w, kt�rzy kupowali produkty z kategorii �Confections�
SELECT DISTINCT companyname,phone
FROM customers
INNER JOIN orders
ON Customers.CustomerID=Orders.CustomerID
INNER JOIN [order details]
ON Orders.OrderID=[Order Details].OrderID
INNER JOIN products
ON [order details].ProductID=Products.ProductID
INNER JOIN Categories
ON products.CategoryID=Categories.CategoryID
WHERE categoryname='Confections'



--Napisz polecenie, kt�re wy�wietla list� dzieci b�d�cych cz�onkami biblioteki (baza library). 
--Interesuje nas imi�, nazwisko, data urodzenia dziecka i adres zamieszkania dziecka.
SELECT firstname,lastname,birth_date,street+' '+city+' '+state AS [adres zamieszkania]
FROM member
INNER JOIN juvenile
ON member.member_no=juvenile.member_no
INNER JOIN adult
ON adult.member_no=juvenile.adult_member_no





--Napisz polecenie, kt�re wy�wietla list� dzieci b�d�cych cz�onkami biblioteki (baza library). 
--Interesuje nas imi�, nazwisko, data urodzenia dziecka, adres zamieszkania dziecka oraz imi� i nazwisko rodzica. 
SELECT m.firstname,m.lastname,j.birth_date,a.street+' '+a.city+ ' '+a.state AS [adres zamieszkania], ma.firstname, ma.lastname
FROM member AS m
INNER JOIN juvenile j
ON j.member_no=m.member_no
INNER JOIN adult a 
ON a.member_no=j.adult_member_no
INNER JOIN member ma
ON ma.member_no=a.member_no



--Napisz polecenie, kt�re wy�wietla pracownik�w oraz ich podw�adnych (baza northwind)
SELECT em1.firstname+' '+em1.lastname,em2.firstname+' '+em2.lastname
FROM employees AS em1
INNER JOIN employees AS em2
ON em1.employeeid=em2.reportsto
GROUP BY em1.firstname+' '+em1.lastname, em2.firstname+' '+em2.lastname
WITH ROLLUP
HAVING em1.firstname+' '+em1.lastname IS NOT NULL and em2.firstname+' '+em2.lastname IS NOT NULL






--Napisz polecenie, kt�re wy�wietla pracownik�w, kt�rzy nie maj� podw�adnych (baza northwind)
SELECT em1.firstname+' '+em1.lastname
FROM Employees as em1
LEFT JOIN Employees AS em2
ON em1.EmployeeID=em2.ReportsTo
GROUP BY em1.firstname+' '+em1.lastname
HAVING COUNT(em2.employeeid)=0


------------------------------------------------------------------------------------------------------------------------------------


--Napisz polecenie, kt�re wy�wietla adresy cz�onk�w biblioteki, kt�rzy maj� dzieci urodzone przed 1 stycznia 1996
SELECT DISTINCT m.firstname+' '+m.lastname, a.street, a.city, a. state
FROM adult AS a
INNER JOIN member m
ON a.member_no=m.member_no
INNER JOIN juvenile j
ON a.member_no=j.adult_member_no AND year(birth_date)<1996








--Napisz polecenie, kt�re wy�wietla adresy cz�onk�w biblioteki, kt�rzy maj� dzieci urodzone przed 1 stycznia 1996. 
--Interesuj� nas tylko adresy takich cz�onk�w biblioteki, kt�rzy aktualnie nie przetrzymuj� ksi��ek.
SELECT m.firstname+' '+m.lastname, a.street, a.city, a. state
FROM adult AS a
INNER JOIN member m
ON a.member_no=m.member_no
INNER JOIN juvenile j
ON a.member_no=j.adult_member_no AND year(birth_date)<1996
LEFT JOIN loan l 
ON a.member_no=l.member_no
GROUP BY m.firstname+' '+m.lastname, a.street, a.city, a. state
HAVING COUNT(l.isbn)=0





--Napisz polecenie kt�re zwraca imi� i nazwisko (jako pojedyncz� kolumn� � name), oraz informacje o adresie: ulica, miasto, stan kod
--(jako pojedyncz� kolumn� � address) dla wszystkich doros�ych cz�onk�w biblioteki
SELECT firstname+' '+lastname  AS name, street+' '+city+' '+state+' '+zip AS address
FROM member
INNER JOIN adult
ON member.member_no=adult.member_no





--Napisz polecenie, kt�re zwraca: isbn, copy_no, on_loan, title, translation, cover, dla ksi��ek o isbn 1, 500 i 1000. 
--Wynik posortuj wg ISBN
SELECT item.isbn, copy_no,on_loan,title,translation, cover
FROM item
INNER JOIN copy
ON item.isbn=copy.isbn AND item.isbn IN (1,500,100)
INNER JOIN title
ON item.title_no=title.title_no
ORDER BY isbn




--Napisz polecenie kt�re zwraca o u�ytkownikach biblioteki o nr 250, 342, i 1675 (dla ka�dego u�ytkownika: nr, imi� i nazwisko
--cz�onka biblioteki), oraz informacj� o zarezerwowanych ksi��kach (isbn,data)
SELECT member.member_no,firstname,lastname,isbn,log_date
FROM member
LEFT JOIN reservation
ON member.member_no=reservation.member_no
WHERE member.member_no IN (250,342,1675)
GROUP BY member.member_no,firstname,lastname,isbn,log_date




--Podaj list� cz�onk�w biblioteki mieszkaj�cych w Arizonie (AZ) maj� wi�cej ni� dwoje dzieci zapisanych do biblioteki
SELECT member.member_no,firstname,lastname
FROM member
INNER JOIN adult
ON member.member_no=adult.member_no AND state='AZ'
LEFT JOIN juvenile
ON member.member_no=juvenile.adult_member_no
GROUP BY member.member_no,firstname,lastname
HAVING COUNT(juvenile.adult_member_no)>2



--Podaj list� cz�onk�w biblioteki mieszkaj�cych w Arizonie (AZ) kt�rzy maj� wi�cej ni� dwoje dzieci zapisanych do biblioteki
--oraz takich kt�rzy mieszkaj� w Kaliforni (CA) i maj� wi�cej ni� troje dzieci zapisanych do biblioteki
SELECT member.member_no,firstname,lastname
FROM member
INNER JOIN adult
ON member.member_no=adult.member_no AND state='AZ'
LEFT JOIN juvenile
ON member.member_no=juvenile.adult_member_no
GROUP BY member.member_no,firstname,lastname
HAVING COUNT(juvenile.adult_member_no)>2
UNION
SELECT member.member_no,firstname,lastname
FROM member
INNER JOIN adult
ON member.member_no=adult.member_no AND state='CA'
LEFT JOIN juvenile
ON member.member_no=juvenile.adult_member_no
GROUP BY member.member_no,firstname,lastname
HAVING COUNT(juvenile.adult_member_no)>3





--31 join


--Dla ka�dego zam�wienia podaj ��czn� liczb� zam�wionych jednostek towaru oraz nazw� klienta.
SELECT orders.orderid, SUM(quantity),companyname
FROM orders
INNER JOIN [order details]
ON orders.OrderID=[Order Details].OrderID
INNER JOIN customers
ON orders.CustomerID=customers.CustomerID
GROUP BY orders.orderid,companyname




--Zmodyfikuj poprzedni przyk�ad, aby pokaza� tylko takie zam�wienia, dla kt�rych ��czna liczb� zam�wionych jednostek
--jest wi�ksza ni� 250
SELECT orders.orderid, SUM(quantity),companyname
FROM orders
INNER JOIN [order details]
ON orders.OrderID=[Order Details].OrderID
INNER JOIN customers
ON orders.CustomerID=customers.CustomerID
GROUP BY orders.orderid,companyname
HAVING SUM(quantity)>250





--Dla ka�dego zam�wienia podaj ��czn� warto�� tego zam�wienia oraz nazw� klienta.
SELECT orders.orderid, SUM(unitprice*quantity*(1-discount)),companyname
FROM orders
INNER JOIN [Order Details]
ON orders.OrderID=[Order Details].OrderID
INNER JOIN Customers
ON orders.CustomerID=Customers.CustomerID
GROUP BY orders.orderid,companyname





--Zmodyfikuj poprzedni przyk�ad, aby pokaza� tylko takie zam�wienia, dla kt�rych ��czna liczba jednostek jest wi�ksza ni� 250.
SELECT orders.orderid, ROUND(SUM(unitprice*quantity*(1-discount)),2),companyname
FROM orders
INNER JOIN [Order Details]
ON orders.OrderID=[Order Details].OrderID
INNER JOIN Customers
ON orders.CustomerID=Customers.CustomerID
GROUP BY orders.orderid,companyname
HAVING SUM(quantity)>250






--Zmodyfikuj poprzedni przyk�ad tak �eby doda� jeszcze imi� i nazwisko pracownika obs�uguj�cego zam�wienie
SELECT orders.orderid, ROUND(SUM(unitprice*quantity*(1-discount)),2),companyname, firstname+' '+lastname
FROM orders
INNER JOIN [Order Details]
ON orders.OrderID=[Order Details].OrderID
INNER JOIN Customers
ON orders.CustomerID=Customers.CustomerID
INNER JOIN employees
ON orders.EmployeeID=Employees.EmployeeID
GROUP BY orders.orderid,companyname,firstname+' '+lastname
HAVING SUM(quantity)>250




--Dla ka�dej kategorii produktu (nazwa), podaj ��czn� liczb� zam�wionych przez klient�w jednostek towar�w z tek kategorii.
SELECT categoryname, SUM(quantity)
FROM categories
INNER JOIN products
ON categories.CategoryID=Products.categoryid
INNER JOIN [order details]
ON Products.ProductID=[Order Details].ProductID
GROUP BY categoryname




--Posortuj wyniki w zapytaniu z poprzedniego punktu wg: a) ��cznej warto�ci zam�wie� b) ��cznej liczby zam�wionych 
--przez klient�w jednostek towar�w.





--Dla ka�dej kategorii produktu (nazwa), podaj ��czn� warto�� zam�wionych przez klient�w jednostek towar�w z tek kategorii.

SELECT categoryname, SUM(quantity*[order details].unitprice*(1-discount))
FROM categories
INNER JOIN products
ON categories.CategoryID=Products.categoryid
INNER JOIN [order details]
ON Products.ProductID=[Order Details].ProductID
GROUP BY categoryname, categories.categoryid





SELECT categoryname, SUM(quantity)
FROM categories
INNER JOIN products
ON categories.CategoryID=Products.categoryid
INNER JOIN [order details]
ON Products.ProductID=[Order Details].ProductID
GROUP BY categoryname
ORDER BY categoryname




--Dla ka�dego zam�wienia podaj jego warto�� uwzgl�dniaj�c op�at� za przesy�k�
SELECT [order details].orderid, (SUM(unitprice*quantity*(1-discount))+freight)
FROM [order details]
INNER JOIN orders
ON [order details].orderid=orders.orderid
GROUP BY [order details].orderid,freight




--Dla ka�dego przewo�nika (nazwa) podaj liczb� zam�wie� kt�re przewie�li w 1997r
SELECT companyname,COUNT(orderid)
FROM shippers
INNER JOIN orders
ON shippers.ShipperID=orders.shipvia AND year(ShippedDate)=1997
GROUP BY companyname




--Kt�ry z przewo�nik�w by� najaktywniejszy (przewi�z� najwi�ksz� liczb� zam�wie�) w 1997r, podaj nazw� tego przewo�nika

SELECT TOP 1 companyname
FROM shippers
INNER JOIN orders
ON shippers.ShipperID=orders.shipvia AND year(shippeddate)=1997
GROUP BY companyname, shippers.shipperid
ORDER BY COUNT(orderid) DESC





--Dla ka�dego pracownika (imi� i nazwisko) podaj ��czn� warto�� zam�wie� obs�u�onych przez tego pracownika
SELECT firstname+' '+lastname, COUNT(orderid)
FROM employees
INNER JOIN orders
ON employees.EmployeeID=orders.EmployeeID
GROUP BY firstname+' '+lastname





--Kt�ry z pracownik�w obs�u�y� najwi�ksz� liczb� zam�wie� w 1997r, podaj imi� i nazwisko takiego pracownika
SELECT TOP 1 firstname+' '+lastname, COUNT(orderid)
FROM employees
INNER JOIN orders
ON employees.EmployeeID=orders.EmployeeID AND year(orderdate)=1997
GROUP BY firstname+' '+lastname
ORDER BY COUNT(orderid) DESC



--Kt�ry z pracownik�w obs�u�y� najaktywniejszy (obs�u�y� zam�wieniao najwi�kszej warto�ci) w 1997r, podaj imi� i nazwisko takiego
--pracownika
SELECT TOP 1 firstname+' '+lastname, SUM(quantity*unitprice*(1-discount))
FROM employees
INNER JOIN orders
ON employees.EmployeeID=orders.EmployeeID AND year(orderdate)=1997
INNER JOIN [order details]
ON orders.OrderID=[Order Details].orderid
GROUP BY firstname+' '+lastname
ORDER BY SUM(quantity*unitprice*(1-discount)) DESC




--Dla ka�dego pracownika (imi� i nazwisko) podaj ��czn� warto�� zam�wie� obs�u�onych przez tego pracownika
SELECT firstname+' '+lastname,SUM(quantity*unitprice*(1-discount))
FROM employees
INNER JOIN orders
ON employees.EmployeeID=orders.EmployeeID
INNER JOIN [order details]
ON orders.OrderID=[Order Details].orderid
GROUP BY firstname+' '+lastname

--Ogranicz wynik tylko do pracownik�w
--a) kt�rzy maj� podw�adnych
SELECT e.firstname+' '+e.lastname,SUM(quantity*unitprice*(1-discount))
FROM employees AS e
INNER JOIN orders
ON e.EmployeeID=orders.EmployeeID
INNER JOIN [order details]
ON orders.OrderID=[Order Details].orderid
INNER JOIN employees em2
ON e.EmployeeID=em2.ReportsTo 
GROUP BY e.firstname+' '+e.lastname




--b) kt�rzy nie maj� podw�adnych
SELECT e.firstname+' '+e.lastname,SUM(quantity*unitprice*(1-discount))
FROM employees AS e
INNER JOIN orders
ON e.EmployeeID=orders.EmployeeID
INNER JOIN [order details]
ON orders.OrderID=[Order Details].orderid
LEFT JOIN employees em2
ON e.EmployeeID=em2.ReportsTo 
WHERE em2.EmployeeID IS NULL
GROUP BY e.firstname+' '+e.lastname


-------------------------
--Wybierz nazwy i numery telefon�w klient�w , kt�rym w 1997 roku przesy�ki dostarcza�a firma United Package.



SELECT DISTINCT Customers.CompanyName, Customers.Phone
FROM Customers
INNER JOIN Orders O on Customers.CustomerID = O.CustomerID
INNER JOIN Shippers S on O.ShipVia = S.ShipperID
WHERE year(ShippedDate) = 1997 AND S.CompanyName = 'United Package'









SELECT DISTINCT C.CompanyName, C.Phone
FROM Customers AS C
WHERE EXISTS (SELECT ShippedDate FROM Orders AS O WHERE
O.CustomerID = C.CustomerID AND year(ShippedDate) = 1997 AND
 (SELECT DISTINCT CompanyName FROM Shippers AS S WHERE S.ShipperID
= O.ShipVia) = 'United Package')











SELECT DISTINCT C.CompanyName, C.Phone
FROM Customers AS C
WHERE C.CustomerID IN (
 SELECT DISTINCT O.CustomerID
 FROM Orders AS O
 WHERE year(O.ShippedDate) = 1997
 AND O.ShipVia IN (
 SELECT DISTINCT S.ShipperID
 FROM Shippers AS S
 WHERE S.CompanyName = 'United Package'
 )






 -- Wybierz nazwy i numery telefon�w klient�w, kt�rzy kupowali produkty z kategorii Confections.

SELECT DISTINCT C.CompanyName, C.Phone
FROM Customers AS C
INNER JOIN Orders O on C.CustomerID = O.CustomerID
INNER JOIN [Order Details] OD on OD.OrderID = O.OrderID
INNER JOIN Products P on OD.ProductID = P.ProductID
INNER JOIN Categories C2 on P.CategoryID = C2.CategoryID
WHERE C2.CategoryName = 'Confections'









SELECT DISTINCT C.CompanyName, C.Phone
FROM Customers AS C
WHERE EXISTS (SELECT O.CustomerID FROM Orders O WHERE O.CustomerID
= C.CustomerID AND EXISTS(SELECT D.OrderID FROM [Order Details] D WHERE D.OrderID =
O.OrderID AND
 EXISTS(SELECT P.ProductID FROM Products P WHERE P.ProductID =
D.ProductID AND
 EXISTS(SELECT C2.CategoryID FROM Categories C2 WHERE C2.CategoryID =
P.CategoryID AND C2.CategoryName = 'Confections'))))




--Wybierz nazwy i numery telefon�w klient�w, kt�rzy nie kupowali produkt�w z kategorii Confections
SELECT DISTINCT Cus2.CompanyName, Cus2.Phone
FROM Customers AS C
INNER JOIN Orders O on C.CustomerID = O.CustomerID
INNER JOIN [Order Details] OD on OD.OrderID = O.OrderID
INNER JOIN Products P on OD.ProductID = P.ProductID
INNER JOIN Categories C2 on P.CategoryID = C2.CategoryID and
C2.CategoryName = 'Confections'
right outer join Customers as cus2 on cus2.CustomerID = C.CustomerID
where C.CustomerID is null












SELECT DISTINCT C.CompanyName, C.Phone
FROM Customers AS C
WHERE NOT EXISTS (SELECT O.CustomerID FROM Orders O WHERE
O.CustomerID = C.CustomerID AND
 EXISTS(SELECT D.OrderID FROM [Order Details] D WHERE D.OrderID =
O.OrderID AND
 EXISTS(SELECT P.ProductID FROM Products P WHERE P.ProductID =
D.ProductID AND
 EXISTS(SELECT C2.CategoryID FROM Categories C2 WHERE C2.CategoryID =
P.CategoryID AND C2.CategoryName = 'Confections'))))




--Dla ka�dego produktu podaj maksymaln� liczb� zam�wionych jednostek
SELECT P.ProductID, MAX(OD.Quantity)
FROM Products P
INNER JOIN [Order Details] OD ON OD.ProductID = P.ProductID
GROUP BY P.ProductID
ORDER BY P.ProductID










SELECT P.ProductName, (
 SELECT MAX(OD.Quantity)
 FROM [Order Details] OD
 WHERE OD.ProductID = P.ProductID)
FROM Products P








--Podaj wszystkie produkty kt�rych cena jest mniejsza ni� �rednia cena produktu
SELECT P.ProductName, P.UnitPrice
FROM Products P
WHERE P.UnitPrice < (
 SELECT AVG(UnitPrice) FROM Products)





--Podaj wszystkie produkty kt�rych cena jest mniejsza ni� �rednia cena produktu danej kategorii
SELECT P.ProductID, P.ProductName
FROM Products AS P
WHERE P.UnitPrice < (
 SELECT AVG(UnitPrice)
 FROM Products AS P2
 WHERE P2.CategoryID = P.CategoryID)





--Dla ka�dego produktu podaj jego nazw�, cen�, �redni� cen� wszystkich produkt�w oraz r�nic� mi�dzy cen� produktu 
--a �redni� cen� wszystkich produkt�w

SELECT P.ProductName, P.UnitPrice,
 (SELECT AVG(UnitPrice)
 FROM Products) AS 'averagePrice',
 P.UnitPrice - (SELECT AVG(UnitPrice) FROM Products) AS 'difference'
FROM Products AS P







--Dla ka�dego produktu podaj jego nazw� kategorii, nazw� produktu, cen�, �redni� cen� wszystkich produkt�w danej 
--kategorii oraz r�nic� mi�dzy cen� produktu a �redni� cen� wszystkich produkt�w danej kategorii

SELECT (SELECT C.CategoryName
 FROM Categories AS C
 WHERE C.CategoryID = P.CategoryID) AS 'CategoryName',
 P.ProductName, P.UnitPrice,
 (SELECT AVG(P2.UnitPrice)
 FROM Products AS P2
 WHERE P2.CategoryID = P.CategoryID) AS 'AveragePriceByCategory',
 P.UnitPrice - (SELECT AVG(P2.UnitPrice)
 FROM Products AS P2
 WHERE P2.CategoryID = P.CategoryID) AS 'difference'
FROM Products AS P





--Podaj ��czn� warto�� zam�wienia o numerze 1025 (uwzgl�dnij cen� za przesy�k�)

SELECT O.Freight + (SELECT SUM(OD.UnitPrice*OD.Quantity*(1-OD.Discount))
FROM [Order Details] AS OD
WHERE OD.OrderID = O.OrderID
GROUP BY OD.OrderID)
FROM Orders AS O
WHERE O.OrderID = 1025






--Podaj ��czn� warto�� zam�wie� ka�dego zam�wienia (uwzgl�dnij cen� za przesy�k�)

SELECT O.OrderID, O.Freight + (SELECT
SUM(OD.UnitPrice*OD.Quantity*(1-OD.Discount))
FROM [Order Details] AS OD
WHERE OD.OrderID = O.OrderID
GROUP BY OD.OrderID)
FROM Orders AS O


--Czy s� jacy� klienci kt�rzy nie z�o�yli �adnego zam�wienia w 1997 roku, je�li tak to poka� ich dane adresowe

SELECT C.Address
FROM Customers AS C
WHERE C.CustomerID NOT IN (
 SELECT O.CustomerID
 FROM Orders AS O
 WHERE year(O.OrderDate) = 1997)


--Podaj produkty kupowane przez wi�cej ni� jednego klienta

select P.ProductName, count(*)
from Products as p
inner join [Order Details] od on od.ProductID = p.ProductID
inner join Orders O on od.OrderID = O.OrderID
group by p.ProductName
having count(*) > 1


--Dla ka�dego pracownika (imi� i nazwisko) podaj ��czn� warto�� zam�wie� obs�u�onych przez tego pracownika 
--(przy obliczaniu warto�ci zam�wie� uwzgl�dnij cen� za przesy�k�
SELECT E.FirstName + ' ' + E.LastName AS 'name', (
 SELECT SUM(OD.UnitPrice*od.quantity*(1-od.Discount))
 from Orders AS O
 INNER JOIN [Order Details] as OD ON O.OrderID = OD.OrderID
 WHERE E.EmployeeID = O.EmployeeID
 ) + (
 SELECT sum(O.Freight)
 from Orders as o
 WHERE o.EmployeeID = e.EmployeeID
 )
FROM Employees AS E

--Kt�ry z pracownik�w obs�u�y� najaktywniejszy (obs�u�y� zam�wienia o najwi�kszej warto�ci) w 1997r,
--podaj imi� i nazwisko takiego pracownika
SELECT TOP 1 E.FirstName + ' ' + e.LastName as 'name', (
 SELECT SUM(OD.UnitPrice*od.quantity*(1-od.Discount))
 from Orders AS O
 INNER JOIN [Order Details] as OD ON O.OrderID = OD.OrderID
 WHERE E.EmployeeID = O.EmployeeID AND year(O.ShippedDate) = 1997
 ) AS 'value'
FROM Employees as e
ORDER BY value DESC

--Ogranicz wynik z pkt 1 tylko do pracownik�w
--a) kt�rzy maj� podw�adnych
SELECT E.FirstName + ' ' + E.LastName AS 'name', (
 SELECT SUM(OD.UnitPrice*od.quantity*(1-od.Discount))
 from Orders AS O
 INNER JOIN [Order Details] as OD ON O.OrderID = OD.OrderID
 WHERE E.EmployeeID = O.EmployeeID) +
 (SELECT sum(O.Freight)
 from Orders as o
 WHERE o.EmployeeID = e.EmployeeID)
FROM Employees AS E
WHERE e.EmployeeID IN (select distinct a.EmployeeID
 from Employees as a
 inner join Employees as b on a.EmployeeID = b.ReportsTo)


--b) kt�rzy nie maj� podw�adnych
SELECT E.FirstName + ' ' + E.LastName AS 'name', (
 SELECT SUM(OD.UnitPrice*od.quantity*(1-od.Discount))
 from Orders AS O
 INNER JOIN [Order Details] as OD ON O.OrderID = OD.OrderID
 WHERE E.EmployeeID = O.EmployeeID) +
 (SELECT sum(O.Freight)
 from Orders as o
 WHERE o.EmployeeID = e.EmployeeID)
FROM Employees AS E
WHERE e.EmployeeID IN (select distinct a.EmployeeID
 from Employees as a
 left join Employees as b on a.EmployeeID = b.ReportsTo
 where b.EmployeeID is null)

 

