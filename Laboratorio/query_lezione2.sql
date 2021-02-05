--Esecuzione delle query
/*
SELECT attributi ritornati
FROM   relazioni coinvolte
WHERE  clausole che le righe devono rispettare
*/

--Uso il database dei libri
drop schema if not exists biblioteca;
create schema biblioteca;

set search_path to biblioteca;

create table socio(
    ci character varying(10) NOT NULL,
    nome varchar(50) not null,
    sesso character(1),
    constraint socio_pkey primary key(ci),
    constraint socio_sesso_check check(sesso in ('M', 'F'))
);

create table genere(
    nome varchar(50) not null,
    sala character(1) not null,
    constraint genere_pkey primary key(nome)
);

create table libro(
    isbn varchar(13) not null,
    titolo varchar(250),
    autore varchar(50),
    genere varchar(50),
    constraint libro_pkey primary key(isbn),
    constraint fk_libro_genere foreign key(genere) references genere(nome)
    on update cascade on delete restrict
);

create table ha_letto(
    ci varchar(10) not null,
    isbn varchar(13) not null,
    constraint pk_ha_letto primary key (ci, isbn),
    constraint fk_ha_letto_libro foreign key(isbn)
    references libro(isbn)
    on update cascade on delete cascade,
    constraint fk_ha_letto_socio foreign key(ci)
    references socio(ci)
    on update cascade on delete cascade
);

\dt 

\i biblioteca_istanza.sql 

--Esempio:
--I nomi dei soci di sesso femminile che hanno letto qualche libro
--Ho bisogno dei soci e di ha_letto
select distinct nome, ci 
from socio join ha_letto on socio.ci = ha_letto.ci 
where sesso = 'F';

--I titoli dei libri nella sala A
select titolo 
from libro join genere on libro.genere = genere.nome 
where genere.sala = 'A';

--Gli autori e il genere dei libri letti da soci maschi 
select distinct autore, genere 
from socio natural join ha_letto natural join libro 
where sesso = 'M';

--
