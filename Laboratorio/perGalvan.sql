--Esercizio per Galvan
drop schema if exists films cascade;
create schema if not exists films;
set search_path to films;
create domain nomi as varchar(20);

--Tabella film
create table film(
    codicefilm      serial,
    titolo          nomi,
    regista         nomi,
    anno            int,
    --vincoli di integrità
    primary key(codicefilm)
);

--Tabella degli attori
create table attore(
    codiceattore    serial,
    cognome         nomi,
    nome            nomi,
    sesso           char,
    datanascita     date,
    nazionalita     nomi,
    --vincoli di integrità
    primary key(codiceattore) 
);

--Tabella delle interpretazioni
create table interpretazione(
    film_fk         serial,
    attore_fk       serial,
    personaggio     nomi,
    --vincoli di integrità
    primary key(film_fk, attore_fk),
    foreign key(attore_fk) references attore
    on update cascade on delete no action,
    foreign key(film_fk)   references film
    on update cascade on delete no action
);


--Popolamento del database
insert into attore(codiceattore, cognome, nome, sesso) values
(default, 'bianchi', 'federico', 'm'),
(default, 'rasera', 'giovanni', 'f'),
(default, 'da re', 'davide', 'f'),
(default, 'bellotto', 'chiara', 'f'),
(default, 'galvan', 'matteo', 'f'),
(default, 'bello', 'ganilio', 'm'),
(default, '', 'M', 'm'),
(default, '', 'C', 'm'),
(default, '', 'S', 'm');

insert into film(codicefilm, titolo, regista) values
(default, 'Olocausto', 'antonioni'),
(default, 'Pannotti', 'antonioni'),
(default, 'Sedimento', 'antonioni'),
(default, 'Oracolo Blu', 'kronaker'),
(default, 'Selamina artale', 'kronaker'),
(default, 'Collopio bell', 'selloppo');


insert into attore(codiceattore, cognome, nome, sesso) values
(default, '', 'M', 'm'),
(default, '', 'C', 'm'),
(default, '', 'S', 'm');

insert into interpretazione(attore_fk, film_fk) values 
(7, 1),
(7, 2),
(7, 3),
(8, 1),
(8, 2),
(8, 3),
(8, 6),
(9, 1),
(9, 2),
(9, 4),
(9, 5),
(9, 6);




