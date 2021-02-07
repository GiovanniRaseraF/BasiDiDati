--Esercizio per Galvan
drop schema if exists films cascade;
create schema if not exists films;
set search_path to films;
create domain nomi as varchar(20);

--Tabella film
create table film(
    codicefilm      int,
    titolo          nomi,
    regista         nomi,
    anno            int,
    --vincoli di integrità
    primary key(codicefilm)
);

create table attore(
    codiceattore    int,
    cognome         nomi,
    nome            nomi,
    sesso           char,
    datanascita     date,
    nazionalita     nomi,
    --vincoli di integrità
    primary key(codiceattore) 
);

create table interpretazione(
    film_fk         int,
    attore_fk       int,
    personaggio     nomi,
    --vincoli di integrità
    primary key(film_fk, attore_fk),
    foreign key(attore_fk) references attore
    on update cascade on delete no action,
    foreign key(film_fk)   references film
    on update cascade on delete no action
);