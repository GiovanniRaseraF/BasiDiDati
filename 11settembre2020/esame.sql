--Esame
--Tabelle
drop schema if exists ospedale cascade;
create schema if not exists ospedale;
set search_path to ospedale;
create domain nomi as varchar(20);

--Reparto
create table reparto (
    nome        nomi,
    edificio    nomi,
    piano       int,
    primario    serial not null,
    --Vincoli
    primary key(nome)
);

create table medico (
    medicoid    serial,
    nome        nomi,
    cognome     nomi,
    specializzazione    nomi,
    genere      char,
    annonascita date,
    reparto     nomi not null,
    cittaresidenza      nomi,
    --Vincoli
    primary key(medicoid)
);

alter table reparto
add constraint fk_primario foreign key(primario) 
references medico deferrable initially immediate
on update cascade on delete set null;

alter table medico
add constraint fk_reparto foreign key(reparto) 
references reparto deferrable initially immediate
on update cascade on delete set null;
