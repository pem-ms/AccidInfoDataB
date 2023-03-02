--1
WITH r0 as (with r1 as (WITH r2 as( SELECT * FROM vehicule NATURAL JOIN blesse) 
SELECT * FROM r2 WHERE marque = 'BMW' and gravite='Fatale') 
SELECT * FROM accident NATURAL JOIN r1 WHERE dept = '75' ) 
SELECT nom, prenom, date FROM personne NATURAL JOIN r0;
--2
WITH r0 as (with r1 as(SELECT * FROM Blesse NATURAL JOIN VehPart)
SELECT codePers FROM r1)SELECT nom, prenom,adress,age FROM r0 NATURAL JOIN Personne;
--3
WITH r1 as (WITH r2 as( SELECT * FROM blesse NATURAL JOIN accident) 
SELECT * FROM r2 WHERE date = '2023-02-14' and gravite='Grave') 
SELECT nom, prenom, age from personne NATURAL JOIN r1;
--4
with r0 as (with r1 as (  WITH r2 as( 
  SELECT * FROM blesse NATURAL JOIN accident) 
  SELECT * FROM r2 WHERE date::text LIKE '2022%' AND gravite='Fatale') 
  SELECT * FROM vehicule NATURAL JOIN r1 WHERE marque = 'Volkswagen') 
  SELECT COUNT(dept) AS nbofaccident FROM r0 GROUP BY dept;
