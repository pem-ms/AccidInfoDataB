--1 Donnez le nom, le pr ́enom, la date de l’accident pour
--chaque personne bless ́ee fatalement dans un accident du d ́epartement 75 dans une voiture BMW.
WITH r0 as (with r1 as (WITH r2 as( SELECT * FROM Vehicule NATURAL JOIN Blesse) 
SELECT * FROM r2 WHERE marque = 'BMW' and gravite='Fatale') 
SELECT * FROM Accident NATURAL JOIN r1 WHERE dept = '75' ) 
SELECT nom, prenom, date FROM Personne NATURAL JOIN r0;

--2 Trouvez les personnes qui ont  ́et ́e bless ́ees dans tous les accidents ou` elles  ́etaient conductrices.
WITH r0 as (with r1 as(SELECT * FROM Blesse NATURAL JOIN VehPart)
SELECT codePers FROM r1)SELECT nom, prenom,adress,age FROM r0 NATURAL JOIN Personne;

--3 Trouvez le nom, le pr ́enom et l’aˆge des personnes qui ont eu un accident grave le 14 F ́evrier 2023.
WITH r1 as (WITH r2 as( SELECT * FROM Blesse NATURAL JOIN Accident) 
SELECT * FROM r2 WHERE date = '2023-02-14' and gravite='Grave') 
SELECT nom, prenom, age from Personne NATURAL JOIN r1;

--4 Donnez le nombre d’accidents fatales en 2022 des utilisateurs 
--de la voiture volkswagen dans chaque d ́epartement.
with r as ( with r0 as (with r1 as (  WITH r2 as( 
SELECT * FROM Blesse NATURAL JOIN Accident) 
SELECT * FROM r2 WHERE date::text LIKE '2022%' and gravite = 'Fatale') 
SELECT * FROM Vehicule NATURAL JOIN r1 WHERE marque = 'Volkswagen') 
SELECT * FROM Conducteur NATURAL JOIN r0) 
SELECT sum(nbacc) as nbaccident, dept FROM r GROUP BY dept;
