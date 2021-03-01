--1. Wybierz nazwy i adresy wszystkich klient�w maj�cych siedziby w Londynie
SELECT companyname, address, city, region, postalcode, country FROM Customers
WHERE city = 'London'











--2. Wybierz nazwy i adresy wszystkich klient�w maj�cych siedziby we Francji lub w Hiszpanii
SELECT companyname, address, city, region, postalcode, country FROM Customers
WHERE country = 'France' OR country='Spain'












--3. Wybierz nazwy i ceny produkt�w o cenie jednostkowej pomi�dzy 20.00 a 30.00
SELECT productname, unitprice FROM Products WHERE UnitPrice BETWEEN 20.00 AND 30.00











--4. Wybierz nazwy i ceny produkt�w z kategorii �meat�
SELECT productname, unitprice FROM products WHERE categoryid=(SELECT categoryid
FROM Categories WHERE Categoryname='meat/poultry')










--5. Wybierz nazwy produkt�w oraz inf. o stanie magazynu dla produkt�w dostarczanych
--przez firm� �Tokyo Traders�
SELECT productname, unitsinstock FROM products WHERE supplierid=(SELECT supplierid
FROM Suppliers WHERE companyname='Tokyo Traders')










--6. Wybierz nazwy produkt�w kt�rych nie ma w magazynie
SELECT productname FROM products WHERE unitsinstock='0'












--1. Szukamy informacji o produktach sprzedawanych w butelkach (�bottle�)
SELECT * FROM products WHERE quantityperunit LIKE '%bottle%'











--2. Wyszukaj informacje o stanowisku pracownik�w, kt�rych nazwiska zaczynaj� si� na liter� z zakresu od B do L

SELECT lastname, title FROM Employees WHERE lastname LIKE '[B-L]%'











--3. Wyszukaj informacje o stanowisku pracownik�w, kt�rych nazwiska zaczynaj� si� na liter� B lub L

SELECT lastname, title FROM Employees WHERE lastname LIKE '[BL]%'











--4. Znajd� nazwy kategorii, kt�re w opisie zawieraj� przecinek
SELECT categoryname, description FROM Categories WHERE description LIKE '%,%'











--5. Znajd� klient�w, kt�rzy w swojej nazwie maj� w kt�rym� miejscu s�owo �Store'
SELECT companyname FROM customers WHERE companyname LIKE '%Store%'









--1. Szukamy informacji o produktach o cenach mniejszych ni� 10 lub wi�kszych ni� 20
SELECT *
FROM products
WHERE unitprice<10 OR unitprice>20









--2. Wybierz nazwy i ceny produkt�w o cenie jednostkowej pomi�dzy 20.00 a 30.00
SELECT productname, unitprice
FROM products
WHERE unitprice BETWEEN 20.00 AND 30.00








--1. Wybierz nazwy i kraje wszystkich klient�w maj�cych siedziby w Japonii (Japan) lub we W�oszech (Italy)
SELECT companyname, country
FROM customers
WHERE country IN ('Japan' , 'Italy')













--Napisz instrukcj� select tak aby wybra� numer zlecenia, dat� zam�wienia, numer klienta
--dla wszystkich niezrealizowanych jeszcze zlece�, dla kt�rych krajem odbiorcy jest Argentyna


SELECT orderid, orderdate, customerid
FROM orders
WHERE shippeddate IS NULL AND shipcountry='Argentina'









--1. Wybierz nazwy i kraje wszystkich klient�w, wyniki posortuj wed�ug kraju,
--w ramach danego kraju nazwy firm posortuj alfabetycznie
SELECT companyname, country
FROM customers
ORDER BY country,companyname











--2. Wybierz informacj� o produktach (grupa, nazwa, cena), produkty
--posortuj wg grup a w grupach malej�co wg ceny
SELECT categoryid, productname, unitprice
FROM products
ORDER BY categoryid, unitprice DESC













--3. Wybierz nazwy i kraje wszystkich klient�w maj�cych siedziby w
--Japonii (Japan) lub we W�oszech (Italy), wyniki posortuj tak jak w pkt 1
SELECT companyname, country
FROM customers
WHERE country IN ('Japan', 'Italy')
ORDER BY country, companyname












--Napisz polecenie, kt�re oblicza warto�� ka�dej pozycji zam�wienia o numerze 10250
SELECT unitprice, productname
FROM products
WHERE productid IN (select productid FROM "Order Details" WHERE orderid=10250)








--Napisz polecenie kt�re dla ka�dego dostawcy (supplier) poka�e
--pojedyncz� kolumn� zawieraj�c� nr telefonu i nr faksu w formacie
--(numer telefonu i faksu maj� by� oddzielone przecinkiem)

SELECT companyname, phone+', '+ fax
FROM suppliers



--11 pol select






--Napisz polecenie select, za pomoc� kt�rego uzyskasz 
--tytu� i numer ksi��ki
SELECT title, title_no
FROM title










--Napisz polecenie, kt�re wybiera tytu� o numerze 10

SELECT title
FROM title
WHERE title_no=10









--Napisz polecenie, kt�re wybiera numer czytelnika, isbn,
--numer ksi��ki (egzemplarza) i naliczon� kar� dla wierszy
--dla kt�rych
--naliczone kary s� pomi�dzy $8.00 a $9.00

SELECT member_no,isbn,title_no,fine_assessed
FROM loanhist
WHERE fine_assessed BETWEEN 8.00 AND 9.00















--Napisz polecenie select, za pomoc� kt�rego uzyskasz numer
--ksi��ki (nr tyu�u) i autora z tablicy title dla wszystkich ksi��ek,
--kt�rych autorem jest Charles Dickens lub Jane Austen

SELECT title_no,author
FROM title
WHERE author IN ('Jane Austen','Charles Dickens')








--Napisz polecenie, kt�re wybiera numer tytu�u i tytu� 
--dla wszystkich rekord�w zawieraj�cych s�owo 
--�adventures� gdzie� w tytule.

SELECT title_no, title
FROM title
WHERE title LIKE '%adventures%'











--Napisz polecenie, kt�re wybiera numer czytelnika,
--oraz zap�acon� kar�
SELECT member_no, fine_paid
FROM loanhist
WHERE fine_paid is not NULL









--Napisz polecenie, kt�re wybiera wszystkie unikalne
--pary miast i stan�w z tablicy adult.

SELECT DISTINCT city, state
FROM adult











--Napisz polecenie, kt�re wybiera wszystkie tytu�y
--z tablicy title i
--wy�wietla je w porz�dku alfabetycznym.

SELECT title
FROM title
ORDER BY title







--Napisz polecenie, kt�re:
--wybiera numer cz�onka biblioteki (member_no), isbn 
--ksi��ki (isbn) i watro�� naliczonej kary (fine_assessed)
--z tablicy loanhist dla wszystkich wypo�ycze� dla 
--kt�rych naliczono kar� (warto�� nie NULL
--w kolumnie fine_assessed)
SELECT member_no,isbn,fine_assessed
FROM loanhist
WHERE fine_assessed  IS NOT NULL






--stw�rz kolumn� wyliczeniow� zawieraj�c� podwojon�
--warto�� kolumny fine_assessed
SELECT 2*fine_assessed
FROM loanhist
WHERE fine_assessed IS NOT NULL AND fine_assessed>0
ORDER BY fine_assessed






--stw�rz alias �double fine� dla tej kolumny

SELECT 2*fine_assessed AS 'double fine'
FROM loanhist
WHERE fine_assessed IS NOT NULL AND fine_assessed>0
ORDER BY [double fine]













--Napisz polecenie, kt�re
--generuje pojedyncz� kolumn�, kt�ra zawiera kolumny:
--firstname (imi� cz�onka biblioteki), middleinitial (inicja�
--drugiego imienia) i lastname (nazwisko) z tablicy member dla
--wszystkich cz�onk�w biblioteki, kt�rzy nazywaj� si�
--Anderson
SELECT firstname+' '+middleinitial+' '+lastname
FROM member
WHERE lastname='Anderson'










--nazwij tak powsta�� kolumn� email_name (u�yj aliasu
--email_name dla kolumny)
SELECT firstname+' '+middleinitial+' '+lastname AS 'email_name'
FROM member
WHERE lastname='Anderson'









--zmodyfikuj polecenie, tak by zwr�ci�o �list� proponowanych
--login�w e-mail� utworzonych przez po��czenie imienia
--cz�onka biblioteki, z inicja�em drugiego imienia i pierwszymi
--dwoma literami nazwiska (wszystko ma�ymi ma�ymi literami).
--Wykorzystaj funkcj� SUBSTRING do uzyskania cz�ci kolumny
--znakowej oraz LOWER do zwr�cenia wyniku ma�ymi literami.
--Wykorzystaj operator (+) do po��czenia string�w.
SELECT LOWER(firstname+middleinitial+SUBSTRING(lastname,1,2))
AS 'email_name'
FROM member
WHERE lastname='Anderson'










--Napisz polecenie, kt�re wybiera title i title_no z tablicy title.
--Wynikiem powinna by� pojedyncza kolumna o formacie jak w
--przyk�adzie poni�ej:
--The title is: Poems, title number 7
--Czyli zapytanie powinno zwraca� pojedyncz� kolumn� w
--oparciu o wyra�enie, kt�re ��czy 4 elementy:
--sta�a znakowa �The title is:�
--warto�� kolumny title
--sta�a znakowa �title number�
--warto�� kolumny title_no

SELECT 'The title is: '+title+', title number '+CONVERT(varchar(10), title_no)
FROM title








--grupowanie 20


--1. Podaj liczb� produkt�w o cenach mniejszych ni� 10$ lub wi�kszych ni� 20$
SELECT COUNT(*)
FROM products
WHERE unitprice<10 OR unitprice>20


SELECT COUNT(*)
FROM products
WHERE unitprice NOT BETWEEN 10.00 AND 20.00










--2. Podaj maksymaln� cen� produktu dla produkt�w o cenach
--poni�ej 20$
SELECT MAX(unitprice)
FROM products
WHERE unitprice<20











--Podaj maksymaln� i minimaln� i �redni� cen� produktu dla
--produkt�w o produktach sprzedawanych w butelkach
--(�bottle�)
SELECT MAX(unitprice) AS 'maximum',MIN(unitprice) AS 'minimum',AVG(unitprice) AS 'average'
FROM products
WHERE QuantityPerUnit LIKE '%bottle%'













--4. Wypisz informacj� o wszystkich produktach o cenie powy�ej �redniej
SELECT *
FROM products
WHERE unitprice>(SELECT AVG(unitprice) FROM products)











--5. Podaj sum�/warto�� zam�wienia o numerze 10250
SELECT SUM(unitprice)
FROM [Order Details]
WHERE orderid=10250










-- Napisz polecenie, kt�re zwraca informacje o zam�wieniach z tablicy order details. 
--Zapytanie ma grupowa� i wy�wietla� identyfikator ka�dego produktu a nast�pnie oblicza� og�ln� 
--zam�wion� ilo��. Og�lna ilo�� jest sumowana funkcj� agreguj�c� SUM i wy�wietlana jako jedna warto�� dla
--ka�dego produktu.

SELECT orderid,SUM(quantity)
FROM [order details]
GROUP BY orderid










--1. Podaj maksymaln� cen� zamawianego produktu dla ka�dego zam�wienia
SELECT orderid,MAX(unitprice)
FROM [Order Details]
GROUP BY orderid











--2. Posortuj zam�wienia wg maksymalnej ceny produktu

SELECT orderid,MAX(unitprice) AS maximum
FROM [Order Details]
GROUP BY orderid
ORDER BY maximum














--3. Podaj maksymaln� i minimaln� cen� zamawianego produktu dla ka�dego zam�wienia
SELECT orderid,MAX(unitprice) AS maxprice ,MIN(unitprice) AS minprice
FROM [Order Details]
GROUP BY orderid















--4. Podaj liczb� zam�wie� dostarczanych przez poszczeg�lnych spedytor�w (przewo�nik�w)
SELECT supplierid, COUNT(productid)
FROM products
GROUP BY supplierid














--5. Kt�ry z spedytor�w by� najaktywniejszy w 1997 roku
 SELECT TOP 1 supplierid, count (*) AS ilosc_zamowien
 FROM products
 WHERE productid in (SELECT productid FROM [order details] WHERE orderid in (SELECT orderid
 FROM orders WHERE orderdate LIKE '%1997%'))
 GROUP BY supplierid
 ORDER BY ilosc_zamowien DESC

 select Top 1 ShipVia from Orders where YEAR(OrderDate) = 1997 group by ShipVia order by count(OrderDate) desc














 --1. Wy�wietl zam�wienia dla kt�rych liczba pozycji zam�wienia jest wi�ksza ni� 5
 SELECT orderid, count(*) AS ilosc_pozycji
 FROM [order details]
 GROUP BY orderid
 HAVING count(*)>5













 --2. Wy�wietl klient�w dla kt�rych w 1998 roku zrealizowano wi�cej ni� 8 zam�wie� (wyniki posortuj malej�co wg ��cznej kwoty za
--dostarczenie zam�wie� dla ka�dego z klient�w)

-- 2. Wy�wietl klient�w dla kt�rych w 1998 roku zrealizowano wi�cej
 -- ni� 8 zam�wie� (wyniki posortuj malej�co wg ��cznej kwoty za
 -- dostarczenie zam�wie� dla ka�dego z klient�w)



select customerid from orders where year(orderdate) = 1998 group by customerid having count(*) > 8 order by sum(freight) DESC



















