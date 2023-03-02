begin transaction;
DROP SCHEMA IF EXISTS AccidInfo CASCADE;
create schema AccidInfo;
set search_path to AccidInfo;

create table Personne (
  codePers text,
  nom text not null,  
  prenom text not null,   
  adress text, 
  age integer CHECK(age>=18),
  primary key (codePers),
  unique(nom)
);

create table Vehicule (
  codeVeh text,
  marque text not null,   
  typeV text, 
  primary key (codeVeh)
);

create table Conducteur (
  codePers text,
  codeVeh text,   
  nbacc integer, 
  primary key (codePers, codeVeh),
  foreign key (codePers) references Personne(codePers) ,
  foreign key (codeVeh) references Vehicule(codeVeh)
);

create table Accident (
  codeAcc text,
  date timestamp,   
  dept text not null CHECK(CAST (dept AS integer) BETWEEN 1 AND 80 ), 
  primary key (codeAcc)
);

create table VEHPART (
  codeAcc text,
  codeVeh text,   
  nCond integer, 
  primary key (codeAcc, codeVeh),
  foreign key (codeAcc) references Accident(codeAcc) ,
  foreign key (codeVeh) references Vehicule(codeVeh)
);

create table Blesse (
  codeAcc text,
  codePers text,
  codeVeh text,
  gravite text, 
  primary key (codeAcc, codePers),
  CONSTRAINT codeAccident foreign key (codeAcc) references Accident(codeAcc) ,
  foreign key (codePers) references Personne(codePers) ,	
  foreign key (codeVeh) references Vehicule(codeVeh)
);

ALTER TABLE Blesse DROP CONSTRAINT codeAccident; -- pour supprimer la clé étrangere

INSERT INTO Personne VALUES ('00001','Darius','Rochebin','Montreal, QC',45);
INSERT INTO Personne VALUES ('00002','Alexandre','Melnik',NULL,55);
INSERT INTO Personne VALUES ('00003','Jan','Emeryk','Montreal, QC',30);
INSERT INTO Personne VALUES ('00004','Marine','Dupont','Quebec, QC',19);
INSERT INTO Personne VALUES ('00005','Nathalie','Chrin',NULL,23);
INSERT INTO Personne VALUES ('00006','Salim','Dadan','Montreal, QC',21);
INSERT INTO Personne VALUES ('00007','Vladyslav','Vinkovski','Montreal, QC',25);
INSERT INTO Personne VALUES ('00008','Ines','Aimée','Chateauguay, QC',22);

INSERT INTO Vehicule VALUES ('13012080','Volkswagen','Classe 1');
INSERT INTO Vehicule VALUES ('13012081','Volkswagen','Classe 1');
INSERT INTO Vehicule VALUES ('13012082','Volkswagen','Classe 1');
INSERT INTO Vehicule VALUES ('13012083','Volkswagen','Classe 1');
INSERT INTO Vehicule VALUES ('13012091','BMW','Classe 1');
INSERT INTO Vehicule VALUES ('13012092','BMW','Classe 1');
INSERT INTO Vehicule VALUES ('13012093','BMW','Classe 1');
INSERT INTO Vehicule VALUES ('13012094','BMW','Classe 1');
INSERT INTO Vehicule VALUES ('13012071','Chevrolet','Classe 2');
INSERT INTO Vehicule VALUES ('13012072','Chevrolet','Classe 1');
INSERT INTO Vehicule VALUES ('13012073','Chevrolet','Classe 2');
INSERT INTO Vehicule VALUES ('13012074','Chevrolet','Classe 1');
INSERT INTO Vehicule VALUES ('13012075','Chevrolet','Classe 2');

INSERT INTO Conducteur VALUES ('00001','13012081',2);
INSERT INTO Conducteur VALUES ('00004','13012094',3);
INSERT INTO Conducteur VALUES ('00005','13012094',0);
INSERT INTO Conducteur VALUES ('00007','13012071',5);
INSERT INTO Conducteur VALUES ('00008','13012075',10);
INSERT INTO Conducteur VALUES ('00006','13012073',1);
INSERT INTO Conducteur VALUES ('00001','13012092',1);
INSERT INTO Conducteur VALUES ('00008','13012093',1);

INSERT INTO Accident VALUES ('159753250','2023-02-14','02');
INSERT INTO Accident VALUES ('159753251','2023-02-10','01');
INSERT INTO Accident VALUES ('159753252','2023-01-18','20');
INSERT INTO Accident VALUES ('159753253','2023-01-13','01');
INSERT INTO Accident VALUES ('159753254','2022-12-31','02');
INSERT INTO Accident VALUES ('159753255','2023-02-14','50');
INSERT INTO Accident VALUES ('159753256','2022-12-31','75');
INSERT INTO Accident VALUES ('159753257','2022-12-31','75');
INSERT INTO Accident VALUES ('159753258','2022-12-31','80');
INSERT INTO Accident VALUES ('159753259','2022-12-31','08');

INSERT INTO VEHPART VALUES ('159753251','13012081','00001');
INSERT INTO VEHPART VALUES ('159753252','13012075','00008');
INSERT INTO VEHPART VALUES ('159753253','13012071','00007');
INSERT INTO VEHPART VALUES ('159753254','13012094','00004');
INSERT INTO VEHPART VALUES ('159753255','13012094','00005');
INSERT INTO VEHPART VALUES ('159753256','13012073','00006');

INSERT INTO Blesse VALUES ('159753251', '00001', '13012081','Fatale');
INSERT INTO Blesse VALUES ('159753252', '00008', '13012075','Grave');
INSERT INTO Blesse VALUES ('159753253', '00007', '13012071','Légère');
INSERT INTO Blesse VALUES ('159753254', '00004', '13012094','Bénigne');
INSERT INTO Blesse VALUES ('159753255', '00005', '13012094','Fatale');
INSERT INTO Blesse VALUES ('159753260', '00006', '13012073','Fatale');

-- L’enregistrement qui cause le problème est la suivante :
--INSERT INTO Blesse VALUES ('159753260', '00006', '13012073','Fatale')
--Car '159753260' correspond à une clé à la fois étrangère et primaire N°ACC
--de la table Blessé. Or N°ACC est à la base une clé primaire de la table Accident
--et cette clé ne figure pas dans ses enregistrements, donc '159753260' ne peut pas
--être une clé étrangère de la table Blessé si elle n’est pas parmi les clés primaires d’Accident.

delete from Blesse where codeAcc = '159753260';
-- remise de la contrainte de la clé étrangère
ALTER TABLE Blesse ADD CONSTRAINT codeAccident foreign key (codeAcc) references Accident(codeAcc);

commit;
