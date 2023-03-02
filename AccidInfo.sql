begin transaction;
DROP SCHEMA IF EXISTS AccidInfo CASCADE;
create schema AccidInfo;
set search_path to AccidInfo;

create table Personne (
  codePers serial,
  nom text not null,  
  prenom text not null,   
  adress text not null, 
  age integer CHECK(age>=18),
  primary key (codePers),
  unique(nom)
);

create table Vehicule (
  codeVeh integer,
  marque text not null,   
  typeV text, 
  primary key (codeVeh)
);

create table Conducteur (
  codePers serial,
  codeVeh integer,   
  nbacc integer,
  primary key (codePers, codeVeh)
);

create table Accident (
  codeAcc integer,
  date timestamp,   
  dept text not null CHECK(CAST (dept AS integer) BETWEEN 1 AND 80 ), 
  primary key (codeAcc)
);

create table VEHPART (
  codeAcc integer,
  codeVeh integer,   
  nCond integer,
  primary key (codeAcc, codeVeh)
);

create table Blesse (
  codeAcc integer,
  codePers serial,
  codeVeh integer,
  gravite text,
  primary key (codeAcc, codePers)
);

commit;

