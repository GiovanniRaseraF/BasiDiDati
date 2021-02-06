-- L'esempio seguente illustra come implementare una
-- specializzazione esclusiva mediante trigger.

create schema specializzazione_esclusiva_trigger;

set search_path to specializzazione_esclusiva_trigger;



create domain dom_cod_prodotto as integer
  check (value > 0);

create table Prodotto (
  id dom_cod_prodotto primary key,
  titolo varchar(40)
);

create table Libro (
  id dom_cod_prodotto primary key,
  pagine integer constraint num_pagine_valido check (pagine > 0),
  foreign key (id) references Prodotto(id)
    on update cascade on delete cascade
);

create table DVD (
  id dom_cod_prodotto primary key,
  durata integer constraint durata_valida check (durata > 0),
  foreign key (id) references Prodotto(id)
    on update cascade on delete cascade
);