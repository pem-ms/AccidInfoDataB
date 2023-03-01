WITH r0 as (with r1 as (WITH r2 as( SELECT * FROM vehicule NATURAL JOIN blesse) 
SELECT * FROM r2 WHERE marque = 'BMW' and gravite='Fatale') 
SELECT * FROM accident NATURAL JOIN r1 WHERE dept = '75' ) 
SELECT nom, prenom, date FROM personne NATURAL JOIN r0;
