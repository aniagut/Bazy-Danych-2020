CREATE TABLE stawki (
 dzien DATE NOT NULL,
 stawka DECIMAL NULL,
 PRIMARY KEY(dzien)
);
CREATE TABLE naleznosci (
 id INTEGER NOT NULL,
 kwota DECIMAL NULL,
 termin DATE NULL,
 PRIMARY KEY(id)
)
CREATE TABLE wplaty (
 id INTEGER NOT NULL,
 naleznosci_id INTEGER NOT NULL,
 kwota DECIMAL NULL,
 data_wplaty DATE NULL,
 PRIMARY KEY(id),
 FOREIGN KEY(naleznosci_id)
 REFERENCES naleznosci(id)
)