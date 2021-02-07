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
(default, 'bello', 'ganilio', 'm');