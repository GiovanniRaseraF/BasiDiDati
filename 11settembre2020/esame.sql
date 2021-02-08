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
    primario    serial,
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
    reparto     nomi,
    cittaresidenza      nomi,
    --Vincoli
    primary key(medicoid)
);

alter table reparto
add constraint fk_primario foreign key(primario) 
references medico 
on update cascade on delete set null;

alter table medico
add constraint fk_reparto foreign key(reparto) 
references reparto 
on update cascade on delete set null;



--Inserimento di medici
insert into medico (medicoid, nome, genere, cittaresidenza) values 
(default, 'giovanni', 'm', 'Trieste'),
(default, 'federico', 'm', 'Udine'),
(default, 'maria', 'f', 'Trieste'),
(default, 'elia', 'm', 'Malta'),
(default, 'mauro', 'm', 'Varano'),
(default, 'fabio', 'm', 'Udine'),
(default, 'mara', 'f', 'Sarmede'),
(default, 'vale', 'f', 'Malta');


insert into reparto(nome, piano, primario) values
('cardiologico', 1, null),
('pneumologia', 2, null),
('cervellogia', 7, null);
--Da aggiungere il fatto che un medico non può essere il primario di più di un reparto
-- serve quindi un trigger


