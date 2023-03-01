begin transaction;
DROP SCHEMA IF EXISTS AccidInfo CASCADE;
create schema AccidInfo;
set search_path to AccidInfo;

create table Personne (
  codePers serial not null,
  nom text not null,  
  prenom text not null,   
  adress text, 
  age integer not null CHECK(age>=18),
  primary key (codePers),
  unique(nom)
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
  --primary key (codePers),
  foreign key (codePers) references Personne(codePers) ,
  foreign key (codeVeh) references Vehicule(codeVeh)
);

create table Accident (
  codeAcc integer not null,
  date timestamp,   
  dept text not null CHECK(CAST (dept AS integer) BETWEEN 1 AND 80 ), 
  primary key (codeAcc)
);

create table VEHPART (
  codeAcc integer,
  codeVeh integer,   
  nCond integer not null, 
  --primary key (codeAcc, codeVeh),
  foreign key (codeAcc) references Accident(codeAcc) ,
  foreign key (codeVeh) references Vehicule(codeVeh)
);

create table Blesse (
  codeAcc integer,
  codePers serial,
  codeVeh integer,
  gravite text not null, 
  --primary key (codeAcc, codePers),
  foreign key (codeAcc) references Accident(codeAcc) ,
  foreign key (codePers) references Personne(codePers) ,	
  foreign key (codeVeh) references Vehicule(codeVeh)
);

commit;


