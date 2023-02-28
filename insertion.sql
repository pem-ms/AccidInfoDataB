begin transaction;

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

commit;

begin transaction;
DROP SCHEMA IF EXISTS Accidinfo CASCADE;
create schema Accidinfo;
set search_path to Accidinfo;

create table Personne (
  codePers serial not null,
  nom text not null,  
  prenom text not null,   
  adress text not null, 
  age integer not null,
  primary key (codePers)
);

create table Vehicule (
  codeVeh integer not null,
  marque text not null,   
  typeV text not null, 
  primary key (codeVeh)
);

create table Conducteur (
  codePers serial,
  codeVeh integer,   
  nbacc integer not null, 
  primary key (codePers),
  foreign key (codePers) references Personne(codePers) ,
  foreign key (codeVeh) references Vehicule(codeVeh)
);

create table Accident (
  codeAcc integer not null,
  date timestamp,   
  dept text not null, 
  primary key (codeAcc)
);

create table VEHPART (
  codeAcc integer,
  codeVeh integer,   
  nCond integer not null, 
  primary key (codeAcc, codeVeh),
  foreign key (codeAcc) references Accident(codeAcc) ,
  foreign key (codeVeh) references Vehicule(codeVeh)
);

create table Blesse (
  codeAcc integer,
  codePers serial,
  codeVeh integer,
  gravite text not null, 
  primary key (codeAcc, codePers),
  foreign key (codeAcc) references Accident(codeAcc) ,
  foreign key (codePers) references Personne(codePers) ,	
  foreign key (codeVeh) references Vehicule(codeVeh)
);


commit;











