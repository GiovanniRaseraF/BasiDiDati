--Esempio di laboratorio
psql -U postgres

\l

\c basididati2020 

DROP SCHEMA IF EXISTS social_network CASCADE;

CREATE SCHEMA social_network;

set search_path to social_network;

--Creazione di tutte le tabella

CREATE TABLE   student(
    id integer NOT NULL,
    name VARCHAR(20) NOT NULL,
    age INTEGER NOT NULL,

    CONSTRAINT pk_student PRIMARY KEY(id)
);

CREATE TABLE friend(
    id1 integer,
    id2 integer,

    constraint pk_friend primary key(id1,id2)
    --commento è simmetrica 
);

comment on table friend is 'Questa tabella rappresenta gli amici';

create table likes(
    id1 integer,
    id2 integer,

    constraint pk_likes primary key(id1, id2)
);
-- likes non è simmetrica

alter table friend
add constraint fk_friend1_student foreign key (id1)
references student (id)
on delete cascade on update restrict;


alter table friend 
add constraint fk_friend2_student foreign key(id2)
references student (id)
on delete cascade on update no action;

alter table likes 
add constraint fk_likes1_student foreign key(id1)
references student(id)
on delete cascade on update restrict;

alter table likes 
add constraint fk_friend2_student foreign key(id2)
references student (id)
on delete cascade on update restrict;

--definire un vincolo di simmetria devo utilizzare i trigger

--Esempio:
    -- 1 - contare il numero di likes


        