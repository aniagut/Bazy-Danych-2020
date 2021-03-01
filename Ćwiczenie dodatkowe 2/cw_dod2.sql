--Wybieranie danych z pojedynczej tabeli
--Baza northwind
--1. Wybierz nazwy i adresy wszystkich klientów
SELECT CompanyName, Address,City,Region,PostalCode,Country
FROM Customers
--2. Wybierz nazwiska i numery telefonów pracowników
SELECT Lastname,HomePhone
FROM Employees
--3. Wybierz nazwy i ceny produktów
SELECT ProductName,UnitPrice
FROM Products
--4. Poka¿ wszystkie kategorie produktów (nazwy i opisy)
SELECT CategoryName,Description
FROM Categories
--5. Poka¿ nazwy i adresy stron www dostawców
SELECT CompanyName, HomePage
FROM Suppliers
--6. Wybierz nazwy i adresy wszystkich klientów maj¹cych siedziby w Londynie
SELECT CompanyName,Address,City,Region,PostalCode,Country
FROM Customers
WHERE City='London'
--7. Wybierz nazwy i adresy wszystkich klientów maj¹cych siedziby we Francji lub w Hiszpanii
SELECT CompanyName,Address,City,Region,PostalCode,Country
FROM Customers
WHERE Country IN ('Spain','France')
--8. Wybierz nazwy i ceny produktów o cenie jednostkowej pomiêdzy 20.00 a 30.00
SELECT ProductName,UnitPrice
FROM Products
WHERE Unitprice BETWEEN 20.00 AND 30.00
--9. Wybierz nazwy i ceny produktów z kategorii ‘meat...’
SELECT ProductName,UnitPrice
FROM Products
WHERE CategoryID=(SELECT CategoryID FROM Categories WHERE CategoryName LIKE '%meat%')
--10. Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów dostarczanych przez firmê 
--‘Tokyo Traders’
SELECT ProductName,UnitsInStock
FROM Products
WHERE SupplierID=(SELECT SupplierID FROM Suppliers WHERE CompanyName='Tokyo Traders')
--11. Wybierz nazwy produktów których nie ma w magazynie Szukamy informacji o 
--produktach sprzedawanych w butelkach (‘bottle’)
SELECT ProductName
FROM Products
WHERE ISNULL(UnitsInStock,0)=0 AND QuantityPerUnit LIKE '%bottle%'
--12. Wyszukaj informacje o stanowisku pracowników, których nazwiska zaczynaj¹ siê
--na literê z zakresu od B do L
SELECT FirstName,LastName, Title
FROM Employees
WHERE LastName LIKE '[B-L]%'
--13. Wyszukaj informacje o stanowisku pracowników, których nazwiska zaczynaj¹ siê
--na literê B lub L
SELECT FirstName,LastName, Title
FROM Employees
WHERE LastName LIKE '[B-L]%'
--14. ZnajdŸ nazwy kategorii, które w opisie zawieraj¹ przecinek
SELECT CategoryName
FROM Categories
WHERE Description LIKE '%,%'
--15. ZnajdŸ klientów, którzy w swojej nazwie maj¹ w którymœ miejscu s³owo ‘Store’
SELECT CompanyName
FROM Customers
WHERE CompanyName LIKE '%Store%'
--16. Szukamy informacji o produktach o cenach mniejszych ni¿ 10 lub wiêkszych ni¿ 20
SELECT *
FROM Products
WHERE UnitPrice<10 OR UnitPrice>20
--17. Napisz instrukcjê select tak aby wybraæ numer zlecenia, datê zamówienia,
--numer klienta dla wszystkich niezrealizowanych jeszcze zleceñ, dla których
--krajem odbiorcy jest Argentyna
SELECT OrderID,OrderDate,CustomerID
FROM Orders
WHERE ShippedDate IS NULL AND ShipCountry='Argentina'
--18. Wybierz nazwy i kraje wszystkich klientów, wyniki posortuj wed³ug kraju, w
--ramach danego kraju, nazwy firm posortuj alfabetycznie
SELECT CompanyName,Country
FROM Customers
ORDER BY Country,CompanyName
--19. Wybierz informacjê o produktach (grupa, nazwa, cena), produkty posortuj wg
--grup a w grupach malej¹co wg ceny
SELECT CategoryID,ProductName,UnitPrice
FROM Products
ORDER BY CategoryID, UnitPrice DESC
--20. Wybierz nazwy i kraje wszystkich klientów maj¹cych siedziby w Japonii (Japan)
--lub we W³oszech (Italy), wyniki posortuj wed³ug kraju, w ramach danego kraju
--nazwy firm posortuj alfabetycznie
SELECT CompanyName,Country
FROM Customers
WHERE Country IN ('Italy','Japan')
ORDER BY Country,CompanyName
--21. Napisz polecenie, które oblicza wartoœæ ka¿dej pozycji zamówienia o numerze 10250
SELECT ProductID, UnitPrice
FROM [Order Details]
WHERE OrderID=10250
--22. Napisz polecenie które dla ka¿dego dostawcy (supplier) poka¿e pojedyncz¹
--kolumnê zawieraj¹c¹ nr telefonu i nr faksu (numer telefonu i faksu maj¹ byæ
--oddzielone przecinkiem)
SELECT SupplierID, Phone + ', ' + Fax
FROM Suppliers
--Baza LIBRARY
--1. Napisz polecenie, które wybiera numer tytu³u i tytu³ dla wszystkich rekordów
--zawieraj¹cych s³owo „adventures” gdzieœ w tytule
SELECT title_no,title
FROM title
WHERE title LIKE '%adventures%'

--2. Napisz polecenie, tak by zwróci³o „listê proponowanych loginów email” utworzonych przez po³¹czenie imienia cz³onka biblioteki,
--z inicja³em drugiego imienia i pierwszymi dwoma literami nazwiska (wszystko ma³ymi ma³ymi literami).
SELECT member_no,firstname,middleinitial,lastname, LOWER(firstname+middleinitial+SUBSTRING(lastname,1,2))
FROM member

--3. Napisz polecenie, które wybiera title i title_no z tablicy title. Wynikiem powinna
--byæ pojedyncza kolumna o formacie jak w przyk³adzie poni¿ej:
--The title is: Poems, title number 7
--Czyli zapytanie powinno zwracaæ pojedyncz¹ kolumnê w oparciu o wyra¿enie, które ³¹czy 4 elementy:
--sta³a znakowa ‘The title is:’
--wartoœæ kolumny title
--sta³a znakowa ‘title number’
--wartoœæ kolumny title_no
SELECT 'The title is: '+title+' , title number '+CONVERT(varchar,title_no)
FROM title
--Baza NORTHWIND
--1. Policz œredni¹ cenê jednostkow¹ dla wszystkich produktów w tabeli products.
SELECT CAST(AVG(UnitPrice) AS DECIMAL (10,2))
FROM Products
--2. Zsumuj wszystkie wartoœci w kolumnie quantity w tabeli order details
SELECT SUM(Quantity)
FROM [Order Details]
--3. Podaj liczbê produktów o cenach mniejszych ni¿ 10 lub wiêkszych ni¿ 20
SELECT COUNT(ProductID)
FROM Products
WHERE UnitPrice<10 OR UnitPrice>20
--4. Podaj maksymaln¹ cenê produktu dla produktów o cenach poni¿ej 20
SELECT MAX(UnitPrice)
FROM Products
WHERE UnitPrice<20
--5. Podaj maksymaln¹ i minimaln¹ i œredni¹ cenê produktu dla produktów o
--produktach sprzedawanych w butelkach (‘bottle’)
SELECT CAST(MIN(UnitPrice) AS DECIMAL(10,2)),CAST(MAX(UnitPrice) AS DECIMAL(10,2)),
CAST(AVG(UnitPrice) AS DECIMAL(10,2))
FROM Products
WHERE QuantityPerUnit LIKE '%bottle%'
--6. Wypisz informacjê o wszystkich produktach o cenie powy¿ej œredniej
SELECT *
FROM Products
WHERE UnitPrice>(SELECT AVG(UnitPrice) FROM Products)
--7. Napisz polecenie, które zwraca informacje o zamówieniach z tablicy order
--details. Zapytanie ma grupowaæ i wyœwietlaæ identyfikator ka¿dego produktu a
--nastêpnie obliczaæ ogóln¹ zamówion¹ iloœæ. Ogólna iloœæ jest sumowana funkcj¹
--agreguj¹c¹ SUM i wyœwietlana jako jedna wartoœæ dla ka¿dego produktu.
SELECT ProductID,SUM(Quantity)
FROM [Order Details]
GROUP BY ProductID
--8. Podaj maksymaln¹ cenê zamawianego produktu dla ka¿dego zamówienia
SELECT OrderID,MAX(UnitPrice)
FROM [Order Details]
GROUP BY OrderID
--9. Posortuj zamówienia wg maksymalnej ceny produktu
SELECT OrderID,MAX(UnitPrice)
FROM [Order Details]
GROUP BY OrderID
ORDER BY MAX(UnitPrice)
--10. Podaj maksymaln¹ i minimaln¹ cenê zamawianego produktu dla ka¿dego zamówienia
SELECT OrderID,MAX(UnitPrice),MIN(UnitPrice)
FROM [Order Details]
GROUP BY OrderID
--11. Podaj liczbê zamówieñ dostarczanych przez poszczególnych spedytorów
SELECT ShipVia,COUNT(OrderID)
FROM Orders
GROUP BY ShipVia
--12. Który z spedytorów by³ najaktywniejszy w 1997 roku
SELECT TOP 1 ShipVia,COUNT(OrderID)
FROM Orders
WHERE year(OrderDate)=1997
GROUP BY ShipVia
ORDER BY COUNT(OrderID) DESC
--13. Wyœwietl zamówienia dla których liczba pozycji zamówienia jest wiêksza ni¿ 5
SELECT OrderID, COUNT(ProductID)
FROM [Order Details]
GROUP BY OrderID
HAVING COUNT(ProductID)>5
--14. Wyœwietl klientów którzy dla których w 1998 roku zrealizowano wiêcej ni¿ 8
--zamówieñ (wyniki posortuj malej¹co wg ³¹cznej kwoty za dostarczenie zamówieñ dla ka¿dego z klientów)
SELECT CustomerID,COUNT(OrderID)
FROM Orders
WHERE year(OrderDate)=1998
GROUP BY CustomerID
HAVING COUNT(OrderID)>8
ORDER BY SUM(Freight) DESC
--15. Podaj sumê (³¹czn¹ wartoœæ) zamówienia o numerze 10250
SELECT CAST(SUM(Quantity*UnitPrice*(1-Discount)) AS DECIMAL (10,2))
FROM [Order Details]
WHERE OrderID=10250
--16. Dla ka¿dego zamówienia podaj jego ³¹czn¹ wartoœæ.
SELECT OrderID, CAST(SUM(Quantity*UnitPrice*(1-Discount)) AS DECIMAL (10,2))
FROM [Order Details]
GROUP BY OrderID
--Baza LIBRARY
--1. Policz ile dzieci urodzi³o siê w poszczególnych latach, w poszczególnych
--miesi¹cach
SELECT year(birth_date),month(birth_date),COUNT(birth_date)
FROM juvenile
GROUP BY year(birth_date),month(birth_date)
--2. Dla ka¿dego doros³ego cz³onka biblioteki podaj liczbê jego dzieci zapisanych do biblioteki.
SELECT m.member_no, COUNT(j.member_no)
FROM member AS m
LEFT JOIN juvenile j ON m.member_no=j.adult_member_no
GROUP BY m.member_no
--3. Podaj ile razy by³y czytane ksi¹¿ki poszczególnych tytu³ów (title_n) w lutym 2002
SELECT t.title_no, COUNT(lh.title_no)
FROM title AS t
LEFT JOIN loanhist lh ON lh.title_no=t.title_no
WHERE year(out_date)=2002 AND month(out_date)=2
GROUP BY t.title_no
--4. Podaj ³¹czn¹ liczbê dni przez które by³y wypo¿yczone ksi¹¿ki poszczególnych tytu³ów w 02.2002
SELECT t.title_no, SUM(DATEDIFF(day,out_date,in_date))
FROM title AS t
LEFT JOIN loanhist lh ON lh.title_no=t.title_no
WHERE year(out_date)=2002 AND month(out_date)=2
GROUP BY t.title_no
--5. Podaj ³¹czn¹ liczbê dni przez które by³y wypo¿yczone ksi¹¿ki przez poszczególnych czytelników w 02.2002
SELECT m.member_no, SUM(ISNULL(DATEDIFF(day,out_date,in_date),0))
FROM member AS m
LEFT JOIN loanhist lh ON m.member_no=lh.member_no AND year(out_date)=2002 AND month(out_date)=2
GROUP BY m.member_no

--1. Napisz polecenie zwracaj¹ce nazwy produktów i firmy je dostarczaj¹ce
SELECT ProductName, CompanyName
FROM Products
INNER JOIN Suppliers ON Products.SupplierID=Suppliers.SupplierID

--2. Napisz polecenie zwracaj¹ce jako wynik nazwy klientów, którzy z³o¿yli zamówienia po 01 marca 1998
SELECT DISTINCT CompanyName, OrderDate
FROM Customers
INNER JOIN Orders ON Orders.CustomerID=Customers.CustomerID AND OrderDate>'03/01/1998'

--3. Napisz polecenie zwracaj¹ce wszystkich klientów z datami zamówieñ.
SELECT CompanyName, OrderDate
FROM Customers
INNER JOIN Orders ON Orders.CustomerID=Customers.CustomerID
ORDER BY Customers.CustomerID
--Baza LIBRARY
--1. Napisz polecenie, które wyœwietla listê dzieci bêd¹cych cz³onkami biblioteki.
--Interesuje nas imiê, nazwisko i data urodzenia dziecka.
SELECT firstname,lastname,birth_date
FROM member
INNER JOIN juvenile ON member.member_no=juvenile.member_no
--2. Napisz polecenie, które podaje tytu³y aktualnie wypo¿yczonych ksi¹¿ek
SELECT title
FROM title
INNER JOIN item ON item.title_no=title.title_no
INNER JOIN copy ON copy.isbn=item.isbn AND copy.on_loan='Y'
GROUP BY title
--3. Podaj informacje o karach zap³aconych za przetrzymywanie ksi¹¿ki o tytule ‘Tao
--Teh King’. Interesuje nas data oddania ksi¹¿ki, ile dni by³a przetrzymywana i jak¹
--zap³acono karê
SELECT in_date,DATEDIFF(day,due_date,out_date),fine_paid
FROM loanhist
INNER JOIN copy ON copy.copy_no=loanhist.copy_no
INNER JOIN title ON title.title_no=copy.title_no AND title='Tao Teh King'
WHERE DATEDIFF(day,due_date,out_date)>0
--4. Napisz polecenie które podaje listê ksi¹¿ek (numery ISBN) zarezerwowanych
--przez osobê o nazwisku: Stephen A. Graff 
SELECT isbn FROM reservation
INNER JOIN member ON reservation.member_no=member.member_no AND firstname='Stephen' AND middleinitial='A' AND lastname='Graff'
--Baza NORTHWIND
--1. Wybierz nazwy i ceny produktów o cenie jednostkowej pomiêdzy 20.00 a 30.00,
--dla ka¿dego produktu podaj dane adresowe dostawcy
SELECT ProductName, UnitPrice, Address,City,Region,Postalcode,Country
FROM Products
INNER JOIN Suppliers ON Products.SupplierID=Suppliers.SupplierID
WHERE UnitPrice BETWEEN 20.00 AND 30.00
--2. Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów
--dostarczanych przez firmê ‘Tokyo Traders’
SELECT ProductName, UnitsInStock
FROM Products
INNER JOIN Suppliers ON Products.SupplierID=Suppliers.SupplierID AND CompanyName='Tokyo Traders'

--3. Czy s¹ jacyœ klienci którzy nie z³o¿yli ¿adnego zamówienia w 1997 roku, jeœli tak to poka¿ ich dane adresowe
SELECT companyname,address,city,region,postalcode,country,orderdate
FROM customers
INNER JOIN orders
ON Customers.CustomerID=Orders.CustomerID
WHERE orders.customerid NOT IN (SELECT customerid FROM orders WHERE year(orderdate)=1997)

--4. Wybierz nazwy i numery telefonów dostawców, dostarczaj¹cych produkty,
--których aktualnie nie ma w magazynie
SELECT CompanyName, Phone
FROM Suppliers
INNER JOIN Products ON Products.ProductID=Suppliers.SupplierID AND UnitsInStock=0

--5. Napisz polecenie zwracaj¹ce listê produktów zamawianych w dniu 1996-07-08.
SELECT DISTINCT ProductName
FROM Products
INNER JOIN [Order Details] ON Products.ProductID=[Order Details].ProductID
INNER JOIN Orders ON Orders.OrderID=[Order Details].OrderID AND OrderDate='1996-07-08'

--6. Wybierz nazwy i ceny produktów o cenie jednostkowej pomiêdzy 20.00 a 30.00,
--dla ka¿dego produktu podaj dane adresowe dostawcy, interesuj¹ nas tylko produkty z kategorii ‘Meat/Poultry’
SELECT ProductName, UnitPrice,Address,City,Region,PostalCode,Country
FROM Products
INNER JOIN Suppliers ON Suppliers.SupplierID=Products.SupplierID
INNER JOIN Categories ON Categories.CategoryID=Products.CategoryID AND CategoryName='Meat/Poultry'
--7. Wybierz nazwy i ceny produktów z kategorii ‘Confections’ dla ka¿dego produktu podaj nazwê dostawcy.
SELECT ProductName, UnitPrice, CompanyName
FROM Products
INNER JOIN Categories ON Products.CategoryID=Categories.CategoryID AND CategoryName='Confections'
INNER JOIN Suppliers ON Suppliers.SupplierID=Products.SupplierID
--8. Wybierz nazwy i numery telefonów klientów , którym w 1997 roku przesy³ki dostarcza³a firma ‘United Package’
SELECT Customers.CompanyName, Customers.Phone
FROM Customers
INNER JOIN Orders ON Orders.CustomerID=Customers.CustomerID
INNER JOIN Shippers ON Shippers.ShipperID=Orders.ShipVia AND Shippers.CompanyName='United Package'
--9. Wybierz nazwy i numery telefonów klientów, którzy kupowali produkty z kategorii ‘Confections’
SELECT DISTINCT CompanyName, Phone
FROM Customers
INNER JOIN Orders ON Orders.CustomerID=Customers.CustomerID
INNER JOIN [Order Details] ON [Order Details].OrderID=Orders.OrderID
INNER JOIN Products ON [Order Details].ProductID=Products.ProductID
INNER JOIN Categories ON Products.CategoryID=Categories.CategoryID AND CategoryName='Confections'
--Baza LIBRARY
--1. Dla ka¿dego doros³ego cz³onka biblioteki podaj jego imiê i nazwisko oraz liczbê
--jego dzieci zapisanych do biblioteki.
SELECT m.member_no,firstname,lastname,COUNT(j.member_no)
FROM member AS m
INNER JOIN juvenile j ON j.adult_member_no=m.member_no
GROUP BY m.member_no,firstname,lastname
--2. Dla ka¿dego doros³ego cz³onka biblioteki podaj jego imiê i nazwisko oraz
--wyœwietl datê urodzenia jego najm³odszego dziecka.
SELECT m.member_no,firstname,lastname,birth_date
FROM member AS m
INNER JOIN juvenile j ON j.adult_member_no=m.member_no AND birth_date=(SELECT TOP 1 birth_date FROM juvenile
WHERE adult_member_no=m.member_no ORDER BY birth_date DESC)
GROUP BY m.member_no,firstname,lastname,birth_date

--3. Dla ka¿dego doros³ego cz³onka biblioteki podaj liczbê jego dzieci zapisanych do
--biblioteki. Dodatkowo wyœwietl datê urodzenia jego najm³odszego dziecka.
SELECT m.member_no,firstname,lastname,COUNT(j1.birth_date),j.birth_date
FROM member AS m
INNER JOIN juvenile j1 ON j1.adult_member_no=m.member_no
INNER JOIN juvenile j ON j.adult_member_no=m.member_no AND j.birth_date=(SELECT TOP 1 birth_date FROM juvenile
WHERE adult_member_no=m.member_no ORDER BY birth_date DESC)
GROUP BY m.member_no,firstname,lastname,j.birth_date
--4. Dla ka¿dego doros³ego cz³onka biblioteki podaj liczbê przeczytanych przez niego
--ksi¹¿ek od 06.2002 do 08.2002. Zbiór wynikowy powinien zawieraæ imiê i
--nazwisko cz³onka biblioteki, jego adres, oraz liczbê przeczytanych ksi¹¿ek.
SELECT firstname,lastname,street,city,state,COUNT(isbn)
FROM member
INNER JOIN adult  ON adult.member_no=member.member_no
LEFT JOIN loanhist ON loanhist.member_no=member.member_no AND out_date BETWEEN '2020-06-01' AND '2020-07-31'
GROUP BY member.member_no,member.firstname,member.lastname,street,city,state
--5. Napisz polecenie, które wyœwietla listê dzieci bêd¹cych cz³onkami biblioteki.
--Interesuje nas imiê, nazwisko, data urodzenia dziecka i adres zamieszkania dziecka.
SELECT firstname,lastname,birth_date,city,state
FROM juvenile
INNER JOIN member ON member.member_no=juvenile.member_no
INNER JOIN adult ON juvenile.adult_member_no=adult.member_no
--6. Napisz polecenie, które wyœwietla listê dzieci bêd¹cych cz³onkami biblioteki.
--Interesuje nas imiê, nazwisko, data urodzenia dziecka, adres zamieszkania
--dziecka oraz imiê i nazwisko rodzica.
SELECT m.firstname,m.lastname,birth_date,city,state,m1.firstname,m1.lastname
FROM juvenile AS j
INNER JOIN member m ON m.member_no=j.member_no
INNER JOIN adult ON j.adult_member_no=adult.member_no
INNER JOIN member m1 ON adult.member_no=m1.member_no

--Baza NORTHWIND
--Dla ka¿dej kategorii produktu, podaj ³¹czn¹ liczbê zamówionych jednostek
SELECT C.CategoryID, C.CategoryName,SUM(Quantity)
FROM Categories AS C
INNER JOIN Products ON Products.CategoryID=C.CategoryID
INNER JOIN [Order Details] ON [Order Details].ProductID=Products.ProductID
GROUP BY C.CategoryID,C.CategoryName

--1. Dla ka¿dego zamówienia podaj ³¹czn¹ liczbê zamówionych jednostek
SELECT O.OrderID, SUM(Quantity)
FROM Orders AS O
INNER JOIN [Order Details] ON O.OrderID=[Order Details].OrderID
GROUP BY O.OrderID

--2. Zmodyfikuj poprzedni przyk³ad, aby pokazaæ tylko takie zamówienia, dla których
--³¹czna liczba jednostek jest wiêksza ni¿ 250
SELECT O.OrderID, SUM(Quantity)
FROM Orders AS O
INNER JOIN [Order Details] ON O.OrderID=[Order Details].OrderID
GROUP BY O.OrderID
HAVING SUM(Quantity)>250
--3. Podaj sumê (³¹czn¹ wartoœæ) zamówienia o numerze 10250, uwzglêdnij op³atê za przesy³kê
SELECT CAST(SUM((Quantity*UnitPrice)*(1-Discount))+Freight AS DECIMAL (6,2))
FROM Orders
INNER JOIN [Order Details] ON [Order Details].OrderID=Orders.OrderID AND Orders.OrderID=10250
GROUP BY Freight
--4. Dla ka¿dego zamówienia podaj jego ³¹czn¹ wartoœæ, uwzglêdnij op³atê za przesy³kê
SELECT  Orders.OrderID, CAST(SUM((Quantity*UnitPrice)*(1-Discount))+Freight AS DECIMAL (8,2))
FROM Orders
INNER JOIN [Order Details] ON [Order Details].OrderID=Orders.OrderID
GROUP BY Orders.OrderID,Freight

--5. Dla ka¿dego zamówienia podaj jego ³¹czn¹ wartoœæ, uwzglêdnij cenê za
--przesy³kê. Zbiór wynikowy powinien zawieraæ Imiê i nazwisko pracownika
--obs³uguj¹cego zamówienie, nr zamówienia, datê zamówienia oraz ³¹czn¹ wartoœæ zamówienia.
SELECT FirstName, LastName, Orders.OrderID,CAST(SUM((Quantity*UnitPrice)*(1-Discount))+Freight AS DECIMAL (8,2))
FROM Orders
INNER JOIN [Order Details] ON [Order Details].OrderID=Orders.OrderID
INNER JOIN Employees ON Employees.EmployeeID=Orders.EmployeeID
GROUP BY Orders.OrderID,FirstName,LastName,Freight

--6. Dla ka¿dego zamówienia podaj jego ³¹czn¹ wartoœæ, uwzglêdnij cenê za
--przesy³kê. Zbiór wynikowy powinien zawieraæ Imiê i nazwisko pracownika
--obs³uguj¹cego zamówienie, nr zamówienia, datê zamówienia, ³¹czn¹ wartoœæ
--zamówienia (bez op³aty za przesy³kê), wartoœæ op³aty za przesy³kê, oraz pe³n¹
--³¹czn¹ wartoœæ zamówienia (wraz z op³ata za przesy³kê)
SELECT FirstName, LastName, Orders.OrderID,OrderDate,CAST(SUM((Quantity*UnitPrice)*(1-Discount)) AS DECIMAL (8,2)),
Freight,CAST(SUM((Quantity*UnitPrice)*(1-Discount))+Freight AS DECIMAL (8,2))
FROM Orders
INNER JOIN [Order Details] ON [Order Details].OrderID=Orders.OrderID
INNER JOIN Employees ON Employees.EmployeeID=Orders.EmployeeID
GROUP BY Orders.OrderID,OrderDate,FirstName,LastName,Freight

--7. Dla ka¿dego klienta podaj ³¹czn¹ wartoœæ jego zamówieñ
SELECT Customers.CustomerID, CompanyName, CAST(SUM((Quantity*UnitPrice)*(1-Discount)) AS DECIMAL (8,2))
FROM Customers 
INNER JOIN Orders ON Orders.CustomerID=Customers.CustomerID
INNER JOIN [Order Details] ON [Order Details].OrderID=Orders.OrderID
GROUP BY Customers.CustomerID, CompanyName,Freight
--8. Dla ka¿dego klienta podaj pe³na ³¹czn¹ wartoœæ jego zamówieñ (uwzglêdnij op³aty za przesy³kê)
SELECT Customers.CustomerID, CompanyName, CAST(SUM((Quantity*UnitPrice)*(1-Discount))+Freight AS DECIMAL (8,2))
FROM Customers 
INNER JOIN Orders ON Orders.CustomerID=Customers.CustomerID
INNER JOIN [Order Details] ON [Order Details].OrderID=Orders.OrderID
GROUP BY Customers.CustomerID, CompanyName,Freight
