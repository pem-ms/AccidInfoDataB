--1
WITH r0 as (with r1 as (WITH r2 as( SELECT * FROM vehicule NATURAL JOIN blesse) 
SELECT * FROM r2 WHERE marque = 'BMW' and gravite='Fatale') 
SELECT * FROM accident NATURAL JOIN r1 WHERE dept = '75' ) 
SELECT nom, prenom, date FROM personne NATURAL JOIN r0;
--2
WITH r0 as (with r1 as( SELECT codeAcc FROM AccidInfo.VehPart)
SELECT * FROM AccidInfo.Blesse NATURAL JOIN r1)
SELECT * FROM AccidInfo.personne NATURAL JOIN r0;
--3
WITH r1 as (WITH r2 as( SELECT * FROM blesse NATURAL JOIN accident) 
SELECT * FROM r2 WHERE date = '2023-02-14' and gravite='Grave') 
SELECT nom, prenom, age from personne NATURAL JOIN r1;
--4
