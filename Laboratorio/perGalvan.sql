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
    film            int,
    attore          int,
    personaggio     nomi,
    --vincoli di integrità
    primary key(film, attore),
    add constraint fk_attore foreign key(attore) references attore.codiceattore
    on update cascade on delete no action,
    add constraint fk_film   foreign key(film)   references film.codicefilm
    on update cascade on delete no action
);