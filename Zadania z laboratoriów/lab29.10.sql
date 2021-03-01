--1. Wybierz nazwy i adresy wszystkich klientów maj¹cych siedziby w Londynie
SELECT companyname, address, city, region, postalcode, country FROM Customers
WHERE city = 'London'











--2. Wybierz nazwy i adresy wszystkich klientów maj¹cych siedziby we Francji lub w Hiszpanii
SELECT companyname, address, city, region, postalcode, country FROM Customers
WHERE country = 'France' OR country='Spain'












--3. Wybierz nazwy i ceny produktów o cenie jednostkowej pomiêdzy 20.00 a 30.00
SELECT productname, unitprice FROM Products WHERE UnitPrice BETWEEN 20.00 AND 30.00











--4. Wybierz nazwy i ceny produktów z kategorii ‘meat’
SELECT productname, unitprice FROM products WHERE categoryid=(SELECT categoryid
FROM Categories WHERE Categoryname='meat/poultry')










--5. Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów dostarczanych
--przez firmê ‘Tokyo Traders’
SELECT productname, unitsinstock FROM products WHERE supplierid=(SELECT supplierid
FROM Suppliers WHERE companyname='Tokyo Traders')










--6. Wybierz nazwy produktów których nie ma w magazynie
SELECT productname FROM products WHERE unitsinstock='0'












--1. Szukamy informacji o produktach sprzedawanych w butelkach (‘bottle’)
SELECT * FROM products WHERE quantityperunit LIKE '%bottle%'











--2. Wyszukaj informacje o stanowisku pracowników, których nazwiska zaczynaj¹ siê na literê z zakresu od B do L

SELECT lastname, title FROM Employees WHERE lastname LIKE '[B-L]%'











--3. Wyszukaj informacje o stanowisku pracowników, których nazwiska zaczynaj¹ siê na literê B lub L

SELECT lastname, title FROM Employees WHERE lastname LIKE '[BL]%'











--4. ZnajdŸ nazwy kategorii, które w opisie zawieraj¹ przecinek
SELECT categoryname, description FROM Categories WHERE description LIKE '%,%'











--5. ZnajdŸ klientów, którzy w swojej nazwie maj¹ w którymœ miejscu s³owo ‘Store'
SELECT companyname FROM customers WHERE companyname LIKE '%Store%'









--1. Szukamy informacji o produktach o cenach mniejszych ni¿ 10 lub wiêkszych ni¿ 20
SELECT *
FROM products
WHERE unitprice<10 OR unitprice>20









--2. Wybierz nazwy i ceny produktów o cenie jednostkowej pomiêdzy 20.00 a 30.00
SELECT productname, unitprice
FROM products
WHERE unitprice BETWEEN 20.00 AND 30.00








--1. Wybierz nazwy i kraje wszystkich klientów maj¹cych siedziby w Japonii (Japan) lub we W³oszech (Italy)
SELECT companyname, country
FROM customers
WHERE country IN ('Japan' , 'Italy')













--Napisz instrukcjê select tak aby wybraæ numer zlecenia, datê zamówienia, numer klienta
--dla wszystkich niezrealizowanych jeszcze zleceñ, dla których krajem odbiorcy jest Argentyna


SELECT orderid, orderdate, customerid
FROM orders
WHERE shippeddate IS NULL AND shipcountry='Argentina'









--1. Wybierz nazwy i kraje wszystkich klientów, wyniki posortuj wed³ug kraju,
--w ramach danego kraju nazwy firm posortuj alfabetycznie
SELECT companyname, country
FROM customers
ORDER BY country,companyname











--2. Wybierz informacjê o produktach (grupa, nazwa, cena), produkty
--posortuj wg grup a w grupach malej¹co wg ceny
SELECT categoryid, productname, unitprice
FROM products
ORDER BY categoryid, unitprice DESC













--3. Wybierz nazwy i kraje wszystkich klientów maj¹cych siedziby w
--Japonii (Japan) lub we W³oszech (Italy), wyniki posortuj tak jak w pkt 1
SELECT companyname, country
FROM customers
WHERE country IN ('Japan', 'Italy')
ORDER BY country, companyname












--Napisz polecenie, które oblicza wartoœæ ka¿dej pozycji zamówienia o numerze 10250
SELECT unitprice, productname
FROM products
WHERE productid IN (select productid FROM "Order Details" WHERE orderid=10250)








--Napisz polecenie które dla ka¿dego dostawcy (supplier) poka¿e
--pojedyncz¹ kolumnê zawieraj¹c¹ nr telefonu i nr faksu w formacie
--(numer telefonu i faksu maj¹ byæ oddzielone przecinkiem)

SELECT companyname, phone+', '+ fax
FROM suppliers



--11 pol select






--Napisz polecenie select, za pomoc¹ którego uzyskasz 
--tytu³ i numer ksi¹¿ki
SELECT title, title_no
FROM title










--Napisz polecenie, które wybiera tytu³ o numerze 10

SELECT title
FROM title
WHERE title_no=10









--Napisz polecenie, które wybiera numer czytelnika, isbn,
--numer ksi¹¿ki (egzemplarza) i naliczon¹ karê dla wierszy
--dla których
--naliczone kary s¹ pomiêdzy $8.00 a $9.00

SELECT member_no,isbn,title_no,fine_assessed
FROM loanhist
WHERE fine_assessed BETWEEN 8.00 AND 9.00















--Napisz polecenie select, za pomoc¹ którego uzyskasz numer
--ksi¹¿ki (nr tyu³u) i autora z tablicy title dla wszystkich ksi¹¿ek,
--których autorem jest Charles Dickens lub Jane Austen

SELECT title_no,author
FROM title
WHERE author IN ('Jane Austen','Charles Dickens')








--Napisz polecenie, które wybiera numer tytu³u i tytu³ 
--dla wszystkich rekordów zawieraj¹cych s³owo 
--„adventures” gdzieœ w tytule.

SELECT title_no, title
FROM title
WHERE title LIKE '%adventures%'











--Napisz polecenie, które wybiera numer czytelnika,
--oraz zap³acon¹ karê
SELECT member_no, fine_paid
FROM loanhist
WHERE fine_paid is not NULL









--Napisz polecenie, które wybiera wszystkie unikalne
--pary miast i stanów z tablicy adult.

SELECT DISTINCT city, state
FROM adult











--Napisz polecenie, które wybiera wszystkie tytu³y
--z tablicy title i
--wyœwietla je w porz¹dku alfabetycznym.

SELECT title
FROM title
ORDER BY title







--Napisz polecenie, które:
--wybiera numer cz³onka biblioteki (member_no), isbn 
--ksi¹¿ki (isbn) i watroœæ naliczonej kary (fine_assessed)
--z tablicy loanhist dla wszystkich wypo¿yczeñ dla 
--których naliczono karê (wartoœæ nie NULL
--w kolumnie fine_assessed)
SELECT member_no,isbn,fine_assessed
FROM loanhist
WHERE fine_assessed  IS NOT NULL






--stwórz kolumnê wyliczeniow¹ zawieraj¹c¹ podwojon¹
--wartoœæ kolumny fine_assessed
SELECT 2*fine_assessed
FROM loanhist
WHERE fine_assessed IS NOT NULL AND fine_assessed>0
ORDER BY fine_assessed






--stwórz alias ‘double fine’ dla tej kolumny

SELECT 2*fine_assessed AS 'double fine'
FROM loanhist
WHERE fine_assessed IS NOT NULL AND fine_assessed>0
ORDER BY [double fine]













--Napisz polecenie, które
--generuje pojedyncz¹ kolumnê, która zawiera kolumny:
--firstname (imiê cz³onka biblioteki), middleinitial (inicja³
--drugiego imienia) i lastname (nazwisko) z tablicy member dla
--wszystkich cz³onków biblioteki, którzy nazywaj¹ siê
--Anderson
SELECT firstname+' '+middleinitial+' '+lastname
FROM member
WHERE lastname='Anderson'










--nazwij tak powsta³¹ kolumnê email_name (u¿yj aliasu
--email_name dla kolumny)
SELECT firstname+' '+middleinitial+' '+lastname AS 'email_name'
FROM member
WHERE lastname='Anderson'









--zmodyfikuj polecenie, tak by zwróci³o „listê proponowanych
--loginów e-mail” utworzonych przez po³¹czenie imienia
--cz³onka biblioteki, z inicja³em drugiego imienia i pierwszymi
--dwoma literami nazwiska (wszystko ma³ymi ma³ymi literami).
--Wykorzystaj funkcjê SUBSTRING do uzyskania czêœci kolumny
--znakowej oraz LOWER do zwrócenia wyniku ma³ymi literami.
--Wykorzystaj operator (+) do po³¹czenia stringów.
SELECT LOWER(firstname+middleinitial+SUBSTRING(lastname,1,2))
AS 'email_name'
FROM member
WHERE lastname='Anderson'










--Napisz polecenie, które wybiera title i title_no z tablicy title.
--Wynikiem powinna byæ pojedyncza kolumna o formacie jak w
--przyk³adzie poni¿ej:
--The title is: Poems, title number 7
--Czyli zapytanie powinno zwracaæ pojedyncz¹ kolumnê w
--oparciu o wyra¿enie, które ³¹czy 4 elementy:
--sta³a znakowa ‘The title is:’
--wartoœæ kolumny title
--sta³a znakowa ‘title number’
--wartoœæ kolumny title_no

SELECT 'The title is: '+title+', title number '+CONVERT(varchar(10), title_no)
FROM title








--grupowanie 20


--1. Podaj liczbê produktów o cenach mniejszych ni¿ 10$ lub wiêkszych ni¿ 20$
SELECT COUNT(*)
FROM products
WHERE unitprice<10 OR unitprice>20


SELECT COUNT(*)
FROM products
WHERE unitprice NOT BETWEEN 10.00 AND 20.00










--2. Podaj maksymaln¹ cenê produktu dla produktów o cenach
--poni¿ej 20$
SELECT MAX(unitprice)
FROM products
WHERE unitprice<20











--Podaj maksymaln¹ i minimaln¹ i œredni¹ cenê produktu dla
--produktów o produktach sprzedawanych w butelkach
--(‘bottle’)
SELECT MAX(unitprice) AS 'maximum',MIN(unitprice) AS 'minimum',AVG(unitprice) AS 'average'
FROM products
WHERE QuantityPerUnit LIKE '%bottle%'













--4. Wypisz informacjê o wszystkich produktach o cenie powy¿ej œredniej
SELECT *
FROM products
WHERE unitprice>(SELECT AVG(unitprice) FROM products)











--5. Podaj sumê/wartoœæ zamówienia o numerze 10250
SELECT SUM(unitprice)
FROM [Order Details]
WHERE orderid=10250










-- Napisz polecenie, które zwraca informacje o zamówieniach z tablicy order details. 
--Zapytanie ma grupowaæ i wyœwietlaæ identyfikator ka¿dego produktu a nastêpnie obliczaæ ogóln¹ 
--zamówion¹ iloœæ. Ogólna iloœæ jest sumowana funkcj¹ agreguj¹c¹ SUM i wyœwietlana jako jedna wartoœæ dla
--ka¿dego produktu.

SELECT orderid,SUM(quantity)
FROM [order details]
GROUP BY orderid










--1. Podaj maksymaln¹ cenê zamawianego produktu dla ka¿dego zamówienia
SELECT orderid,MAX(unitprice)
FROM [Order Details]
GROUP BY orderid











--2. Posortuj zamówienia wg maksymalnej ceny produktu

SELECT orderid,MAX(unitprice) AS maximum
FROM [Order Details]
GROUP BY orderid
ORDER BY maximum














--3. Podaj maksymaln¹ i minimaln¹ cenê zamawianego produktu dla ka¿dego zamówienia
SELECT orderid,MAX(unitprice) AS maxprice ,MIN(unitprice) AS minprice
FROM [Order Details]
GROUP BY orderid















--4. Podaj liczbê zamówieñ dostarczanych przez poszczególnych spedytorów (przewoŸników)
SELECT supplierid, COUNT(productid)
FROM products
GROUP BY supplierid














--5. Który z spedytorów by³ najaktywniejszy w 1997 roku
 SELECT TOP 1 supplierid, count (*) AS ilosc_zamowien
 FROM products
 WHERE productid in (SELECT productid FROM [order details] WHERE orderid in (SELECT orderid
 FROM orders WHERE orderdate LIKE '%1997%'))
 GROUP BY supplierid
 ORDER BY ilosc_zamowien DESC

 select Top 1 ShipVia from Orders where YEAR(OrderDate) = 1997 group by ShipVia order by count(OrderDate) desc














 --1. Wyœwietl zamówienia dla których liczba pozycji zamówienia jest wiêksza ni¿ 5
 SELECT orderid, count(*) AS ilosc_pozycji
 FROM [order details]
 GROUP BY orderid
 HAVING count(*)>5













 --2. Wyœwietl klientów dla których w 1998 roku zrealizowano wiêcej ni¿ 8 zamówieñ (wyniki posortuj malej¹co wg ³¹cznej kwoty za
--dostarczenie zamówieñ dla ka¿dego z klientów)

-- 2. Wyœwietl klientów dla których w 1998 roku zrealizowano wiêcej
 -- ni¿ 8 zamówieñ (wyniki posortuj malej¹co wg ³¹cznej kwoty za
 -- dostarczenie zamówieñ dla ka¿dego z klientów)



select customerid from orders where year(orderdate) = 1998 group by customerid having count(*) > 8 order by sum(freight) DESC



















