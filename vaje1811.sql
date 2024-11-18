-- Vrnite tabelo imen in priimkov vseh oseb, ki jim je ime Matija
SELECT ime, priimek FROM osebe
WHERE ime = "Matija";
-- Vrnite tabelo imen in priimkov vseh oseb, urejeno po priimku
SELECT ime, priimek FROM osebe
ORDER BY priimek;
-- Vrnite imena vseh predmetov na praktični matematiki (smer: 1PrMa)
SELECT ime FROM predmeti
WHERE smer = "1PrMa";
-- Vrnite vse podatke o skupinah z manj kot eno uro
SELECT * FROM skupine
WHERE ure < 1;
-- Vrnite število vseh predmetov na posamezni smeri
SELECT smer, COUNT(smer) FROM predmeti
GROUP BY smer;
-- Vrnite imena tistih predmetov, ki se pojavljajo na več smereh
SELECT ime, COUNT(ime) FROM predmeti
GROUP BY ime
HAVING COUNT(ime) > 1;
-- Vrnite imena in vse pripadajoče smeri tistih predmetov, ki se pojavljajo na več smereh
SELECT ime, smer FROM predmeti
GROUP BY smer
HAVING COUNT(ime) > 1;
-- Vrnite skupno število ur vsake osebe
SELECT ime, priimek, SUM(ure)
FROM osebe JOIN skupine ON osebe.id = skupine.učitelj
GROUP BY priimek;
-- Vrnite imena in priimke vseh predavateljev,
-- torej tistih, ki imajo kakšno skupino tipa P
SELECT DISTINCT ime, priimek
FROM osebe JOIN skupine ON osebe.id = skupine.učitelj
WHERE skupine.tip = "P";
-- Vrnite imena in priimke vseh predavateljev,
-- ki izvajajo tako predavanja (tip P) kot vaje (tipa V ali L)
SELECT DISTINCT ime, priimek
FROM osebe JOIN skupine ON osebe.id = skupine.učitelj
WHERE skupine.tip = "P" AND skupine.tip = "V" OR skupine.tip = "L";
-- Vrnite imena in smeri vseh predmetov, ki imajo kakšen seminar
SELECT ime, smer
FROM skupine INNER JOIN dodelitve ON skupine.id = dodelitve.skupina
             INNER JOIN predmeti ON predmeti.id = dodelitve.predmet
WHERE skupine.tip = "S";
-- Vsem predmetom na smeri 2PeMa spremenite smer na PeMa
UPDATE predmeti
SET smer = "PeMa"
WHERE smer = "2PeMa";
-- Izbrišite vse predmete, ki niso dodeljeni nobeni skupini
DELETE FROM predmeti;
-- Za vsak predmet, ki se pojavi tako na prvi kot drugi stopnji
-- (smer se začne z 1 oz. 2), dodajte nov predmet z istim imenom
-- in smerjo 0Mate (stolpca id ne nastavljajte, ker se bo samodejno
-- določil)
INSERT INTO predmeti
(ime, smer)
VALUES ((SELECT DISTINCT ime FROM predmeti WHERE smer LIKE "1&" AND "2%"), "0Mate");
-- Za vsako smer izpišite število različnih oseb, ki na njej poučujejo
SELECT DISTINCT smer, učitelj
FROM predmeti INNER JOIN dodelitve ON predmeti.id = dodelitve.predmet
              INNER JOIN skupine ON dodelitve.skupina = skupine.id
-- Vrnite pare ID-jev tistih oseb, ki sodelujejo pri vsaj dveh
-- predmetih (ne glede na tip skupine), pri čemer naj bo prvi ID
-- v paru manjši od drugega, pari pa naj se ne ponavljajo

-- Za vsako osebo (izpišite jo z ID-jem, imenom in priimkom) vrnite
-- skupno število ur vaj (tako avditornih kot laboratorijskih),
-- pri čemer naj bo to enako 0, če oseba ne izvaja nobenih vaj

-- Vrnite ID-je, imena in smeri predmetov, za katere se izvaja
-- seminar, ne pa tudi avditorne ali laboratorijske vaje
