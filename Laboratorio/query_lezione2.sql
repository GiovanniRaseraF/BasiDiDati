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

--Trovare i titoli dei libri gialli letti da ElladePedon
select titolo 
from socio natural join ha_letto natural join libro 
where socio.nome = 'ElladePedon' and libro.genere = 'giallo';

--I titoli dei libri e la sala in cui sono collocati
select titolo, sala 
from libro join genere on genere = nome 

--I titoli dei libri e la sala in cui sono collocati inclusi i libri 
-- di cui non è possibili trovare la collocazione
select titolo, sala 
from libro left outer join genere on libro.genere = genere.nome;

--I numeri di carta di identità delle coppie di soci che hanno letto
-- uno stesso libro
select s1.ci, s2.ci 
from ha_letto as s1 join ha_letto s2 on s1.isbn = s2.isbn
where s1.ci < s2.ci

--Numeri di ci di chi ha letto libri di cui non è specificato il genere
select distinct s.ci 
from ha_letto natural join libro 
where genere is null;

--I numeri di ci dei soci che hanno letto almeno un libro situato nella sala A
select distinct ci
from ha_letto natural join libro join genere on libro.genere = genere.nome 
where sala = 'A';

--INTERROGAZIONI RAGGRUPPATE
--Esercizi:
--Ragionamento su schema movie ratings

--Ottenere i film diretti da steven spilberg in ordine alfaberico
select title
from movie 
where director = "Ste Spe"
order by title;

--Ottenere in ordine cresciente gli anni distinti in cui sono stati prodotti film
-- che hanno ricevuto una valutazione >= 4
select distinct year
from movie natural join rating 
where stars >= 4
order by year asc;

--Ottenere i nomi dei critici e i titoli dei film con la valutazione e la data
-- ordinati come segue (nomeCritico alfa, titoloFilm alfa, valutazione desc)
select name, title, stars, ratingDate
from movie natural join rating natural join reviewer 
order by name asc, title asc, stars desc;

--RAGGRUPPAMENTO
--Quanti film nella base di dati sono stati prodotti tra il 1977 e il 1975
select count(*) as numero
from movie
where year >= '1977' and year <= '1986';

--Valutazione media dei film di james cameroon
select avg(stars) as media_voti
from movie natural join rating 
where director = 'James Cameroon';

--La data della critica più recente a un film di victor flaming
select max(ratingDate) 
from movie natural join rating 
where director = 'Victor Fleming';

--Ottieni il titolo e la valutazione massima per ogni film che è stato 
-- valutato almeno una volta in ordine descresciente rispetto al voto
select title, max(stars) as beststars
from movie natural join rating 
group by title
order by beststars desc;

--Ottenere il titolo e la differenza tra voto massimo e voto minimo
-- per ogni film che abbia ricevuto almeno due valutazioni e ordina 
-- il risultato rispetto al titolo
select title, max(stars) - min(stars)
from movie natural join rating 
group by title, mid 
having count(*) >= 2
order by title;












