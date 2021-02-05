/*Ho diversi tipi di dati*/
integer
real
double precision
numeric(prec, scale)
decimal(prec, scale)

timestamp(prec)
date
interval(prec)

/*Domini definiti dall'utente**/
create domain dom_euro as numeric;
create domain dom_provincia as char(2);
create domain dom_pagato as boolean;

create domain dom_voto as integer
constraint c_voto_valido
check(value between 18 and 30);

/*Creazione del database*/
\l  --lista dei database

create database basididati2020;

--mi connetto
\c basididati2020

--lista tabelle
\dt 

--i database sono indipendenti
--gli schemi dividono lo stesso database

--CREAZIONE DELLE TABELLE
CREATE TABLE R(
    a CHAR(4) PRIMARY KEY,
    b char references S,
    c boolean not null,
    d integer unique,
    e real check(e > 5.5)
);

create table R(
    a char(4),

    primary key(a), foreign key(b)
)

--es
create table Esame(
    matr integer check (matr > 0),
    corso varchar(256),
    data date not null,
    voto integer check(voto between 18 and 30),
    lode boolean,
    --Vincoli di tabella
    primary key(matr, corso),
    constraint lode_valida
    check(not lode or voto = 30)
);

--creo la tabella r, s
create table R(
    a char primary key,
    b int
);
select * from R;

create table S(
    x int primary key,
    y char references r
);
select * from S;

--modifico delle tabella
alter table Conto rename to Fattura;

alter table Prodotto
add column colore varchar(30);

alter table Prodotto
rename column colore to tinta;

alter table Prodotto 
drop column tinta cascade;

--Avvolte la modifica è necessaria
--Ad esempio per aggiungere dei vincoli

alter table Prodotto
add constraint nobianco
check (colore <> 'bianco');

alter table Prodotto 
add constraint colore_unico
unique (modello, colore);

alter table Prodotto
add constraint fk_fornitore
foreign key(fornitore) references fornitore
on update cascade on delete no action;

--inserimento
insert into R(A,b) values ('a',3), ('b',null);

insert into R values ('c'); -- di default ha il null

update R set a='b', b=null where B<5;
--aggiorna i valori che rispettano il where

delete from R where b is null;

--Provo a inserire delle chiavi esterne
delete from R;

insert into R values ('f', 7), ('m', 5);

insert into S values (123, m), (456, null);


--Difficile da fare dei delete se qualcuno è riferito da una chiave esterna
--devo reagire all'update e al delete

--non pormetto di fare l'azione
no action;
--eseguo l'operazione in cascata
cascade;
--pongo a null il valore coinvolto
set null;
--metto a default
set default;

--uso
on delete on update;

--Esempio
create table R(
    a int primary key
);

create table S(
    b character primary key,
    c int,
    
    --vincoli
    add constraint fk_R 
    foreign key(c) references R 
    on update no action on delete set null

);

create table T (
    d character primary key,
    e int,
    
    -- Vincoli
    add constraint fk_s 
    foreign key(e) references s.c  
    on update cascade on delete no action
)

--Cosa succede se faccio eseguire le seguenti righe?
delete from R where A = 20;             -- viene messa a null la seconda riga di S e le righe di T
delete from S where B = 'a';            -- non viene permessa l'operazione
update S set c = 40 where B = 'c';      -- ciene fatto siccome nessuno si riferisce a 40 nella tabella di T
delete from R;                          -- viene fatto e tutto viene messo a null
drop table R;                           -- non ha successo perche altre tabelle devono
                                        -- riferirla, devo fare anche drop cascade


--devo chiedermi
--posso avere null ?
--posso avere un default
--sono unico ?


