SELECT n.id AS 'Id naleznosci',s.dzien AS 'Od dnia',
(SELECT TOP 1 s1.dzien FROM stawki s1 WHERE s1.dzien>s.dzien ORDER BY s1.dzien ) AS 'Do dnia',
datediff(day,s.dzien,(SELECT TOP 1 s1.dzien FROM stawki s1 WHERE s1.dzien>s.dzien ORDER BY s1.dzien )) AS 'Liczba dni',
s.stawka AS 'Stawka',n.kwota-ISNULL(SUM(w.kwota),0) AS 'Kwota zad³u¿enia',
CAST((n.kwota-ISNULL(SUM(w.kwota),0))*s.stawka/365*datediff(day,s.dzien,(SELECT TOP 1 s1.dzien FROM stawki s1 WHERE s1.dzien>s.dzien ORDER BY s1.dzien )) AS DECIMAL(7,2)) AS 'Kwota odsetek'
FROM stawki s
INNER JOIN naleznosci n ON n.id=15
LEFT OUTER JOIN wplaty w ON w.data_wplaty<s.dzien AND w.naleznosci_id=n.id
GROUP BY n.id,s.dzien,s.stawka,n.kwota
HAVING (n.kwota-SUM(ISNULL(w.kwota,0)))>0
ORDER BY s.dzien
