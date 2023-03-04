begin transaction;
DROP SCHEMA IF EXISTS AccidInfo CASCADE;
create schema AccidInfo;
set search_path to AccidInfo;

create table Personne (
  codePers serial not null,
  nom text not null,  
  prenom text not null,   
  adress text not null, 
  age integer CHECK(age>=18),
  primary key (codePers)
);

create table Vehicule (
  codeVeh integer not null,
  marque text not null,   
  typeV text, 
  primary key (codeVeh)
);

create table Conducteur (
  codePers serial not null,
  codeVeh integer not null,   
  nbacc integer,
  primary key (codePers, codeVeh)
);

create table Accident (
  codeAcc integer not null,
  date timestamp,   
  dept text not null CHECK(CAST (dept AS integer) BETWEEN 1 AND 80 ), 
  primary key (codeAcc)
);

create table VEHPART (
  codeAcc integer not null,
  codeVeh integer not null,   
  nCond integer,
  primary key (codeAcc, codeVeh)
);

create table Blesse (
  codeAcc integer not null,
  codePers serial not null,
  codeVeh integer not null,
  gravite text,
  primary key (codeAcc, codePers)
);

commit;

