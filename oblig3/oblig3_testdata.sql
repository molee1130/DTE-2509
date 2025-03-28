-- test data
INSERT INTO Bruker (Bruker_id, Fornavn, Etternavn, Tlf, Mail) VALUES
(1, 'Ola', 'Nordmann', '12345678', 'ola@example.com'),
(2, 'Kari', 'Nordmann', '87654321', 'kari@example.com');

INSERT INTO Postnummer (Postnummer, Poststed) VALUES
('1234', 'Oslo'),
('5678', 'Bergen');

INSERT INTO Adresse (Adresse_id, Bruker_id, Adresse_type, Gate, Gatenummer, Postnummer) VALUES
(1, 1, 'Hjemme', 'Osloveien', '1', '1234'),
(2, 2, 'Hjemme', 'Bergensgaten', '2', '5678');

INSERT INTO Bil (Reg_nr, Bruker_id, Merke, Modell, Årsmodell, Effekt, Hjuldrift, Kjøretøy_type, Kjæledyr_tillatt, Røyking_tillatt, Pris_per_døgn, Drivlinje) VALUES
('AB12345', 1, 'Toyota', 'Corolla', 2020, 150, 'FWD', 'Sedan', 1, 0, 500, 'Bensin'),
('CD67890', 2, 'Volvo', 'XC60', 2021, 200, 'AWD', 'SUV', 1, 0, 700, 'Diesel');

INSERT INTO Booking (Booking_id, Reg_nr, Utleier, Leietaker, Dato_fra, Dato_til, Henteadresse, Innleveringsadresse, Karakter_utleier, Karakter_leietaker, Kilometerstand_før, Kilometerstand_etter, Kommentar) VALUES
(1, 'AB12345', 1, 2, '2023-10-01', '2023-10-05', 1, 2, 5, 4, 250, 10000, "test"),
(2, 'CD67890', 2, 1, '2023-10-10', '2023-10-15', 2, 1, 4, 5, 100, 1000, "hei"),
(3, 'AB12345', 1, 2, '2023-11-01', '2023-11-05', 1, 2, NULL, NULL, 3354, 234, "hei på deg");