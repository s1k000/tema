--Napiši ukaze, ki:
--Dodajo tri nove stranke: Erik, Fani in Gala
INSERT INTO stranka
(id, ime)
VALUES (5, 'Erik'),
       (6, 'Fani'),
       (7, 'Gala');
--Popravijo status naročila z id 3 na na poti.
UPDATE narocilo
SET status = 'na poti'
WHERE narocilo.id = 3;
--Dodajo novo naročilo, ki ga je ustvarila Gala za 200 enot izdelka. Id stranke za vstavljanje naročila pridobi avtomatsko. 
--Status naročila naj bo v obdelavi.
INSERT INTO narocilo
(kolicina, stranka , status)
VALUES (200,(SELECT id FROM stranka WHERE ime = 'Gala'),'v obdelavi');
--Izbrišejo Alenko in vsa njena naročila.
DELETE FROM narocilo
WHERE stranka = 1;
DELETE FROM stranka
WHERE ime = 'Alenka';
--Ustvarijo novo naročilo za vse stranke, ki še niso oddale naročila. Količina naj bo stokratnik id stranke. 
--Status naročila naj bo nastavljen na privzeto vrednost (oddano).
INSERT INTO narocilo(kolicina, stranka)

SELECT 100 * id, id FROM stranka WHERE id NOT IN (

SELECT DISTINCT stranka FROM narocilo);
--Zaključim vsa naročila, ki so na poti.
UPDATE narocilo
SET status = 'zaključeno'
WHERE status = 'na poti'