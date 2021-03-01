--Wybieranie danych z pojedynczej tabeli
--Baza northwind
--1. Wybierz nazwy i adresy wszystkich klient�w
SELECT CompanyName, Address,City,Region,PostalCode,Country
FROM Customers
--2. Wybierz nazwiska i numery telefon�w pracownik�w
SELECT Lastname,HomePhone
FROM Employees
--3. Wybierz nazwy i ceny produkt�w
SELECT ProductName,UnitPrice
FROM Products
--4. Poka� wszystkie kategorie produkt�w (nazwy i opisy)
SELECT CategoryName,Description
FROM Categories
--5. Poka� nazwy i adresy stron www dostawc�w
SELECT CompanyName, HomePage
FROM Suppliers
--6. Wybierz nazwy i adresy wszystkich klient�w maj�cych siedziby w Londynie
SELECT CompanyName,Address,City,Region,PostalCode,Country
FROM Customers
WHERE City='London'
--7. Wybierz nazwy i adresy wszystkich klient�w maj�cych siedziby we Francji lub w Hiszpanii
SELECT CompanyName,Address,City,Region,PostalCode,Country
FROM Customers
WHERE Country IN ('Spain','France')
--8. Wybierz nazwy i ceny produkt�w o cenie jednostkowej pomi�dzy 20.00 a 30.00
SELECT ProductName,UnitPrice
FROM Products
WHERE Unitprice BETWEEN 20.00 AND 30.00
--9. Wybierz nazwy i ceny produkt�w z kategorii �meat...�
SELECT ProductName,UnitPrice
FROM Products
WHERE CategoryID=(SELECT CategoryID FROM Categories WHERE CategoryName LIKE '%meat%')
--10. Wybierz nazwy produkt�w oraz inf. o stanie magazynu dla produkt�w dostarczanych przez firm� 
--�Tokyo Traders�
SELECT ProductName,UnitsInStock
FROM Products
WHERE SupplierID=(SELECT SupplierID FROM Suppliers WHERE CompanyName='Tokyo Traders')
--11. Wybierz nazwy produkt�w kt�rych nie ma w magazynie Szukamy informacji o 
--produktach sprzedawanych w butelkach (�bottle�)
SELECT ProductName
FROM Products
WHERE ISNULL(UnitsInStock,0)=0 AND QuantityPerUnit LIKE '%bottle%'
--12. Wyszukaj informacje o stanowisku pracownik�w, kt�rych nazwiska zaczynaj� si�
--na liter� z zakresu od B do L
SELECT FirstName,LastName, Title
FROM Employees
WHERE LastName LIKE '[B-L]%'
--13. Wyszukaj informacje o stanowisku pracownik�w, kt�rych nazwiska zaczynaj� si�
--na liter� B lub L
SELECT FirstName,LastName, Title
FROM Employees
WHERE LastName LIKE '[B-L]%'
--14. Znajd� nazwy kategorii, kt�re w opisie zawieraj� przecinek
SELECT CategoryName
FROM Categories
WHERE Description LIKE '%,%'
--15. Znajd� klient�w, kt�rzy w swojej nazwie maj� w kt�rym� miejscu s�owo �Store�
SELECT CompanyName
FROM Customers
WHERE CompanyName LIKE '%Store%'
--16. Szukamy informacji o produktach o cenach mniejszych ni� 10 lub wi�kszych ni� 20
SELECT *
FROM Products
WHERE UnitPrice<10 OR UnitPrice>20
--17. Napisz instrukcj� select tak aby wybra� numer zlecenia, dat� zam�wienia,
--numer klienta dla wszystkich niezrealizowanych jeszcze zlece�, dla kt�rych
--krajem odbiorcy jest Argentyna
SELECT OrderID,OrderDate,CustomerID
FROM Orders
WHERE ShippedDate IS NULL AND ShipCountry='Argentina'
--18. Wybierz nazwy i kraje wszystkich klient�w, wyniki posortuj wed�ug kraju, w
--ramach danego kraju, nazwy firm posortuj alfabetycznie
SELECT CompanyName,Country
FROM Customers
ORDER BY Country,CompanyName
--19. Wybierz informacj� o produktach (grupa, nazwa, cena), produkty posortuj wg
--grup a w grupach malej�co wg ceny
SELECT CategoryID,ProductName,UnitPrice
FROM Products
ORDER BY CategoryID, UnitPrice DESC
--20. Wybierz nazwy i kraje wszystkich klient�w maj�cych siedziby w Japonii (Japan)
--lub we W�oszech (Italy), wyniki posortuj wed�ug kraju, w ramach danego kraju
--nazwy firm posortuj alfabetycznie
SELECT CompanyName,Country
FROM Customers
WHERE Country IN ('Italy','Japan')
ORDER BY Country,CompanyName
--21. Napisz polecenie, kt�re oblicza warto�� ka�dej pozycji zam�wienia o numerze 10250
SELECT ProductID, UnitPrice
FROM [Order Details]
WHERE OrderID=10250
--22. Napisz polecenie kt�re dla ka�dego dostawcy (supplier) poka�e pojedyncz�
--kolumn� zawieraj�c� nr telefonu i nr faksu (numer telefonu i faksu maj� by�
--oddzielone przecinkiem)
SELECT SupplierID, Phone + ', ' + Fax
FROM Suppliers
--Baza LIBRARY
--1. Napisz polecenie, kt�re wybiera numer tytu�u i tytu� dla wszystkich rekord�w
--zawieraj�cych s�owo �adventures� gdzie� w tytule
SELECT title_no,title
FROM title
WHERE title LIKE '%adventures%'

--2. Napisz polecenie, tak by zwr�ci�o �list� proponowanych login�w email� utworzonych przez po��czenie imienia cz�onka biblioteki,
--z inicja�em drugiego imienia i pierwszymi dwoma literami nazwiska (wszystko ma�ymi ma�ymi literami).
SELECT member_no,firstname,middleinitial,lastname, LOWER(firstname+middleinitial+SUBSTRING(lastname,1,2))
FROM member

--3. Napisz polecenie, kt�re wybiera title i title_no z tablicy title. Wynikiem powinna
--by� pojedyncza kolumna o formacie jak w przyk�adzie poni�ej:
--The title is: Poems, title number 7
--Czyli zapytanie powinno zwraca� pojedyncz� kolumn� w oparciu o wyra�enie, kt�re ��czy 4 elementy:
--sta�a znakowa �The title is:�
--warto�� kolumny title
--sta�a znakowa �title number�
--warto�� kolumny title_no
SELECT 'The title is: '+title+' , title number '+CONVERT(varchar,title_no)
FROM title
--Baza NORTHWIND
--1. Policz �redni� cen� jednostkow� dla wszystkich produkt�w w tabeli products.
SELECT CAST(AVG(UnitPrice) AS DECIMAL (10,2))
FROM Products
--2. Zsumuj wszystkie warto�ci w kolumnie quantity w tabeli order details
SELECT SUM(Quantity)
FROM [Order Details]
--3. Podaj liczb� produkt�w o cenach mniejszych ni� 10 lub wi�kszych ni� 20
SELECT COUNT(ProductID)
FROM Products
WHERE UnitPrice<10 OR UnitPrice>20
--4. Podaj maksymaln� cen� produktu dla produkt�w o cenach poni�ej 20
SELECT MAX(UnitPrice)
FROM Products
WHERE UnitPrice<20
--5. Podaj maksymaln� i minimaln� i �redni� cen� produktu dla produkt�w o
--produktach sprzedawanych w butelkach (�bottle�)
SELECT CAST(MIN(UnitPrice) AS DECIMAL(10,2)),CAST(MAX(UnitPrice) AS DECIMAL(10,2)),
CAST(AVG(UnitPrice) AS DECIMAL(10,2))
FROM Products
WHERE QuantityPerUnit LIKE '%bottle%'
--6. Wypisz informacj� o wszystkich produktach o cenie powy�ej �redniej
SELECT *
FROM Products
WHERE UnitPrice>(SELECT AVG(UnitPrice) FROM Products)
--7. Napisz polecenie, kt�re zwraca informacje o zam�wieniach z tablicy order
--details. Zapytanie ma grupowa� i wy�wietla� identyfikator ka�dego produktu a
--nast�pnie oblicza� og�ln� zam�wion� ilo��. Og�lna ilo�� jest sumowana funkcj�
--agreguj�c� SUM i wy�wietlana jako jedna warto�� dla ka�dego produktu.
SELECT ProductID,SUM(Quantity)
FROM [Order Details]
GROUP BY ProductID
--8. Podaj maksymaln� cen� zamawianego produktu dla ka�dego zam�wienia
SELECT OrderID,MAX(UnitPrice)
FROM [Order Details]
GROUP BY OrderID
--9. Posortuj zam�wienia wg maksymalnej ceny produktu
SELECT OrderID,MAX(UnitPrice)
FROM [Order Details]
GROUP BY OrderID
ORDER BY MAX(UnitPrice)
--10. Podaj maksymaln� i minimaln� cen� zamawianego produktu dla ka�dego zam�wienia
SELECT OrderID,MAX(UnitPrice),MIN(UnitPrice)
FROM [Order Details]
GROUP BY OrderID
--11. Podaj liczb� zam�wie� dostarczanych przez poszczeg�lnych spedytor�w
SELECT ShipVia,COUNT(OrderID)
FROM Orders
GROUP BY ShipVia
--12. Kt�ry z spedytor�w by� najaktywniejszy w 1997 roku
SELECT TOP 1 ShipVia,COUNT(OrderID)
FROM Orders
WHERE year(OrderDate)=1997
GROUP BY ShipVia
ORDER BY COUNT(OrderID) DESC
--13. Wy�wietl zam�wienia dla kt�rych liczba pozycji zam�wienia jest wi�ksza ni� 5
SELECT OrderID, COUNT(ProductID)
FROM [Order Details]
GROUP BY OrderID
HAVING COUNT(ProductID)>5
--14. Wy�wietl klient�w kt�rzy dla kt�rych w 1998 roku zrealizowano wi�cej ni� 8
--zam�wie� (wyniki posortuj malej�co wg ��cznej kwoty za dostarczenie zam�wie� dla ka�dego z klient�w)
SELECT CustomerID,COUNT(OrderID)
FROM Orders
WHERE year(OrderDate)=1998
GROUP BY CustomerID
HAVING COUNT(OrderID)>8
ORDER BY SUM(Freight) DESC
--15. Podaj sum� (��czn� warto��) zam�wienia o numerze 10250
SELECT CAST(SUM(Quantity*UnitPrice*(1-Discount)) AS DECIMAL (10,2))
FROM [Order Details]
WHERE OrderID=10250
--16. Dla ka�dego zam�wienia podaj jego ��czn� warto��.
SELECT OrderID, CAST(SUM(Quantity*UnitPrice*(1-Discount)) AS DECIMAL (10,2))
FROM [Order Details]
GROUP BY OrderID
--Baza LIBRARY
--1. Policz ile dzieci urodzi�o si� w poszczeg�lnych latach, w poszczeg�lnych
--miesi�cach
SELECT year(birth_date),month(birth_date),COUNT(birth_date)
FROM juvenile
GROUP BY year(birth_date),month(birth_date)
--2. Dla ka�dego doros�ego cz�onka biblioteki podaj liczb� jego dzieci zapisanych do biblioteki.
SELECT m.member_no, COUNT(j.member_no)
FROM member AS m
LEFT JOIN juvenile j ON m.member_no=j.adult_member_no
GROUP BY m.member_no
--3. Podaj ile razy by�y czytane ksi��ki poszczeg�lnych tytu��w (title_n) w lutym 2002
SELECT t.title_no, COUNT(lh.title_no)
FROM title AS t
LEFT JOIN loanhist lh ON lh.title_no=t.title_no
WHERE year(out_date)=2002 AND month(out_date)=2
GROUP BY t.title_no
--4. Podaj ��czn� liczb� dni przez kt�re by�y wypo�yczone ksi��ki poszczeg�lnych tytu��w w 02.2002
SELECT t.title_no, SUM(DATEDIFF(day,out_date,in_date))
FROM title AS t
LEFT JOIN loanhist lh ON lh.title_no=t.title_no
WHERE year(out_date)=2002 AND month(out_date)=2
GROUP BY t.title_no
--5. Podaj ��czn� liczb� dni przez kt�re by�y wypo�yczone ksi��ki przez poszczeg�lnych czytelnik�w w 02.2002
SELECT m.member_no, SUM(ISNULL(DATEDIFF(day,out_date,in_date),0))
FROM member AS m
LEFT JOIN loanhist lh ON m.member_no=lh.member_no AND year(out_date)=2002 AND month(out_date)=2
GROUP BY m.member_no

--1. Napisz polecenie zwracaj�ce nazwy produkt�w i firmy je dostarczaj�ce
SELECT ProductName, CompanyName
FROM Products
INNER JOIN Suppliers ON Products.SupplierID=Suppliers.SupplierID

--2. Napisz polecenie zwracaj�ce jako wynik nazwy klient�w, kt�rzy z�o�yli zam�wienia po 01 marca 1998
SELECT DISTINCT CompanyName, OrderDate
FROM Customers
INNER JOIN Orders ON Orders.CustomerID=Customers.CustomerID AND OrderDate>'03/01/1998'

--3. Napisz polecenie zwracaj�ce wszystkich klient�w z datami zam�wie�.
SELECT CompanyName, OrderDate
FROM Customers
INNER JOIN Orders ON Orders.CustomerID=Customers.CustomerID
ORDER BY Customers.CustomerID
--Baza LIBRARY
--1. Napisz polecenie, kt�re wy�wietla list� dzieci b�d�cych cz�onkami biblioteki.
--Interesuje nas imi�, nazwisko i data urodzenia dziecka.
SELECT firstname,lastname,birth_date
FROM member
INNER JOIN juvenile ON member.member_no=juvenile.member_no
--2. Napisz polecenie, kt�re podaje tytu�y aktualnie wypo�yczonych ksi��ek
SELECT title
FROM title
INNER JOIN item ON item.title_no=title.title_no
INNER JOIN copy ON copy.isbn=item.isbn AND copy.on_loan='Y'
GROUP BY title
--3. Podaj informacje o karach zap�aconych za przetrzymywanie ksi��ki o tytule �Tao
--Teh King�. Interesuje nas data oddania ksi��ki, ile dni by�a przetrzymywana i jak�
--zap�acono kar�
SELECT in_date,DATEDIFF(day,due_date,out_date),fine_paid
FROM loanhist
INNER JOIN copy ON copy.copy_no=loanhist.copy_no
INNER JOIN title ON title.title_no=copy.title_no AND title='Tao Teh King'
WHERE DATEDIFF(day,due_date,out_date)>0
--4. Napisz polecenie kt�re podaje list� ksi��ek (numery ISBN) zarezerwowanych
--przez osob� o nazwisku: Stephen A. Graff 
SELECT isbn FROM reservation
INNER JOIN member ON reservation.member_no=member.member_no AND firstname='Stephen' AND middleinitial='A' AND lastname='Graff'
--Baza NORTHWIND
--1. Wybierz nazwy i ceny produkt�w o cenie jednostkowej pomi�dzy 20.00 a 30.00,
--dla ka�dego produktu podaj dane adresowe dostawcy
SELECT ProductName, UnitPrice, Address,City,Region,Postalcode,Country
FROM Products
INNER JOIN Suppliers ON Products.SupplierID=Suppliers.SupplierID
WHERE UnitPrice BETWEEN 20.00 AND 30.00
--2. Wybierz nazwy produkt�w oraz inf. o stanie magazynu dla produkt�w
--dostarczanych przez firm� �Tokyo Traders�
SELECT ProductName, UnitsInStock
FROM Products
INNER JOIN Suppliers ON Products.SupplierID=Suppliers.SupplierID AND CompanyName='Tokyo Traders'

--3. Czy s� jacy� klienci kt�rzy nie z�o�yli �adnego zam�wienia w 1997 roku, je�li tak to poka� ich dane adresowe
SELECT companyname,address,city,region,postalcode,country,orderdate
FROM customers
INNER JOIN orders
ON Customers.CustomerID=Orders.CustomerID
WHERE orders.customerid NOT IN (SELECT customerid FROM orders WHERE year(orderdate)=1997)

--4. Wybierz nazwy i numery telefon�w dostawc�w, dostarczaj�cych produkty,
--kt�rych aktualnie nie ma w magazynie
SELECT CompanyName, Phone
FROM Suppliers
INNER JOIN Products ON Products.ProductID=Suppliers.SupplierID AND UnitsInStock=0

--5. Napisz polecenie zwracaj�ce list� produkt�w zamawianych w dniu 1996-07-08.
SELECT DISTINCT ProductName
FROM Products
INNER JOIN [Order Details] ON Products.ProductID=[Order Details].ProductID
INNER JOIN Orders ON Orders.OrderID=[Order Details].OrderID AND OrderDate='1996-07-08'

--6. Wybierz nazwy i ceny produkt�w o cenie jednostkowej pomi�dzy 20.00 a 30.00,
--dla ka�dego produktu podaj dane adresowe dostawcy, interesuj� nas tylko produkty z kategorii �Meat/Poultry�
SELECT ProductName, UnitPrice,Address,City,Region,PostalCode,Country
FROM Products
INNER JOIN Suppliers ON Suppliers.SupplierID=Products.SupplierID
INNER JOIN Categories ON Categories.CategoryID=Products.CategoryID AND CategoryName='Meat/Poultry'
--7. Wybierz nazwy i ceny produkt�w z kategorii �Confections� dla ka�dego produktu podaj nazw� dostawcy.
SELECT ProductName, UnitPrice, CompanyName
FROM Products
INNER JOIN Categories ON Products.CategoryID=Categories.CategoryID AND CategoryName='Confections'
INNER JOIN Suppliers ON Suppliers.SupplierID=Products.SupplierID
--8. Wybierz nazwy i numery telefon�w klient�w , kt�rym w 1997 roku przesy�ki dostarcza�a firma �United Package�
SELECT Customers.CompanyName, Customers.Phone
FROM Customers
INNER JOIN Orders ON Orders.CustomerID=Customers.CustomerID
INNER JOIN Shippers ON Shippers.ShipperID=Orders.ShipVia AND Shippers.CompanyName='United Package'
--9. Wybierz nazwy i numery telefon�w klient�w, kt�rzy kupowali produkty z kategorii �Confections�
SELECT DISTINCT CompanyName, Phone
FROM Customers
INNER JOIN Orders ON Orders.CustomerID=Customers.CustomerID
INNER JOIN [Order Details] ON [Order Details].OrderID=Orders.OrderID
INNER JOIN Products ON [Order Details].ProductID=Products.ProductID
INNER JOIN Categories ON Products.CategoryID=Categories.CategoryID AND CategoryName='Confections'
--Baza LIBRARY
--1. Dla ka�dego doros�ego cz�onka biblioteki podaj jego imi� i nazwisko oraz liczb�
--jego dzieci zapisanych do biblioteki.
SELECT m.member_no,firstname,lastname,COUNT(j.member_no)
FROM member AS m
INNER JOIN juvenile j ON j.adult_member_no=m.member_no
GROUP BY m.member_no,firstname,lastname
--2. Dla ka�dego doros�ego cz�onka biblioteki podaj jego imi� i nazwisko oraz
--wy�wietl dat� urodzenia jego najm�odszego dziecka.
SELECT m.member_no,firstname,lastname,birth_date
FROM member AS m
INNER JOIN juvenile j ON j.adult_member_no=m.member_no AND birth_date=(SELECT TOP 1 birth_date FROM juvenile
WHERE adult_member_no=m.member_no ORDER BY birth_date DESC)
GROUP BY m.member_no,firstname,lastname,birth_date

--3. Dla ka�dego doros�ego cz�onka biblioteki podaj liczb� jego dzieci zapisanych do
--biblioteki. Dodatkowo wy�wietl dat� urodzenia jego najm�odszego dziecka.
SELECT m.member_no,firstname,lastname,COUNT(j1.birth_date),j.birth_date
FROM member AS m
INNER JOIN juvenile j1 ON j1.adult_member_no=m.member_no
INNER JOIN juvenile j ON j.adult_member_no=m.member_no AND j.birth_date=(SELECT TOP 1 birth_date FROM juvenile
WHERE adult_member_no=m.member_no ORDER BY birth_date DESC)
GROUP BY m.member_no,firstname,lastname,j.birth_date
--4. Dla ka�dego doros�ego cz�onka biblioteki podaj liczb� przeczytanych przez niego
--ksi��ek od 06.2002 do 08.2002. Zbi�r wynikowy powinien zawiera� imi� i
--nazwisko cz�onka biblioteki, jego adres, oraz liczb� przeczytanych ksi��ek.
SELECT firstname,lastname,street,city,state,COUNT(isbn)
FROM member
INNER JOIN adult  ON adult.member_no=member.member_no
LEFT JOIN loanhist ON loanhist.member_no=member.member_no AND out_date BETWEEN '2020-06-01' AND '2020-07-31'
GROUP BY member.member_no,member.firstname,member.lastname,street,city,state
--5. Napisz polecenie, kt�re wy�wietla list� dzieci b�d�cych cz�onkami biblioteki.
--Interesuje nas imi�, nazwisko, data urodzenia dziecka i adres zamieszkania dziecka.
SELECT firstname,lastname,birth_date,city,state
FROM juvenile
INNER JOIN member ON member.member_no=juvenile.member_no
INNER JOIN adult ON juvenile.adult_member_no=adult.member_no
--6. Napisz polecenie, kt�re wy�wietla list� dzieci b�d�cych cz�onkami biblioteki.
--Interesuje nas imi�, nazwisko, data urodzenia dziecka, adres zamieszkania
--dziecka oraz imi� i nazwisko rodzica.
SELECT m.firstname,m.lastname,birth_date,city,state,m1.firstname,m1.lastname
FROM juvenile AS j
INNER JOIN member m ON m.member_no=j.member_no
INNER JOIN adult ON j.adult_member_no=adult.member_no
INNER JOIN member m1 ON adult.member_no=m1.member_no

--Baza NORTHWIND
--Dla ka�dej kategorii produktu, podaj ��czn� liczb� zam�wionych jednostek
SELECT C.CategoryID, C.CategoryName,SUM(Quantity)
FROM Categories AS C
INNER JOIN Products ON Products.CategoryID=C.CategoryID
INNER JOIN [Order Details] ON [Order Details].ProductID=Products.ProductID
GROUP BY C.CategoryID,C.CategoryName

--1. Dla ka�dego zam�wienia podaj ��czn� liczb� zam�wionych jednostek
SELECT O.OrderID, SUM(Quantity)
FROM Orders AS O
INNER JOIN [Order Details] ON O.OrderID=[Order Details].OrderID
GROUP BY O.OrderID

--2. Zmodyfikuj poprzedni przyk�ad, aby pokaza� tylko takie zam�wienia, dla kt�rych
--��czna liczba jednostek jest wi�ksza ni� 250
SELECT O.OrderID, SUM(Quantity)
FROM Orders AS O
INNER JOIN [Order Details] ON O.OrderID=[Order Details].OrderID
GROUP BY O.OrderID
HAVING SUM(Quantity)>250
--3. Podaj sum� (��czn� warto��) zam�wienia o numerze 10250, uwzgl�dnij op�at� za przesy�k�
SELECT CAST(SUM((Quantity*UnitPrice)*(1-Discount))+Freight AS DECIMAL (6,2))
FROM Orders
INNER JOIN [Order Details] ON [Order Details].OrderID=Orders.OrderID AND Orders.OrderID=10250
GROUP BY Freight
--4. Dla ka�dego zam�wienia podaj jego ��czn� warto��, uwzgl�dnij op�at� za przesy�k�
SELECT  Orders.OrderID, CAST(SUM((Quantity*UnitPrice)*(1-Discount))+Freight AS DECIMAL (8,2))
FROM Orders
INNER JOIN [Order Details] ON [Order Details].OrderID=Orders.OrderID
GROUP BY Orders.OrderID,Freight

--5. Dla ka�dego zam�wienia podaj jego ��czn� warto��, uwzgl�dnij cen� za
--przesy�k�. Zbi�r wynikowy powinien zawiera� Imi� i nazwisko pracownika
--obs�uguj�cego zam�wienie, nr zam�wienia, dat� zam�wienia oraz ��czn� warto�� zam�wienia.
SELECT FirstName, LastName, Orders.OrderID,CAST(SUM((Quantity*UnitPrice)*(1-Discount))+Freight AS DECIMAL (8,2))
FROM Orders
INNER JOIN [Order Details] ON [Order Details].OrderID=Orders.OrderID
INNER JOIN Employees ON Employees.EmployeeID=Orders.EmployeeID
GROUP BY Orders.OrderID,FirstName,LastName,Freight

--6. Dla ka�dego zam�wienia podaj jego ��czn� warto��, uwzgl�dnij cen� za
--przesy�k�. Zbi�r wynikowy powinien zawiera� Imi� i nazwisko pracownika
--obs�uguj�cego zam�wienie, nr zam�wienia, dat� zam�wienia, ��czn� warto��
--zam�wienia (bez op�aty za przesy�k�), warto�� op�aty za przesy�k�, oraz pe�n�
--��czn� warto�� zam�wienia (wraz z op�ata za przesy�k�)
SELECT FirstName, LastName, Orders.OrderID,OrderDate,CAST(SUM((Quantity*UnitPrice)*(1-Discount)) AS DECIMAL (8,2)),
Freight,CAST(SUM((Quantity*UnitPrice)*(1-Discount))+Freight AS DECIMAL (8,2))
FROM Orders
INNER JOIN [Order Details] ON [Order Details].OrderID=Orders.OrderID
INNER JOIN Employees ON Employees.EmployeeID=Orders.EmployeeID
GROUP BY Orders.OrderID,OrderDate,FirstName,LastName,Freight

--7. Dla ka�dego klienta podaj ��czn� warto�� jego zam�wie�
SELECT Customers.CustomerID, CompanyName, CAST(SUM((Quantity*UnitPrice)*(1-Discount)) AS DECIMAL (8,2))
FROM Customers 
INNER JOIN Orders ON Orders.CustomerID=Customers.CustomerID
INNER JOIN [Order Details] ON [Order Details].OrderID=Orders.OrderID
GROUP BY Customers.CustomerID, CompanyName,Freight
--8. Dla ka�dego klienta podaj pe�na ��czn� warto�� jego zam�wie� (uwzgl�dnij op�aty za przesy�k�)
SELECT Customers.CustomerID, CompanyName, CAST(SUM((Quantity*UnitPrice)*(1-Discount))+Freight AS DECIMAL (8,2))
FROM Customers 
INNER JOIN Orders ON Orders.CustomerID=Customers.CustomerID
INNER JOIN [Order Details] ON [Order Details].OrderID=Orders.OrderID
GROUP BY Customers.CustomerID, CompanyName,Freight
