create table Dipartimento(
    id_dip          varchar(5) primary key,
    nome_dip        varchar(50),
    universita      varchar(50),
    direttore       varchar(50)
);

create table Ricercatore(
    nome            varchar(50) primary key,
    eta             integer,
    afferenza       varchar(5) foreign key references Dipartimento
        on update cascade on delete set null
);

alter table Dipartimento 
add constraint fk_direttore 
foreign key(direttore) references Ricercatore 
deferrable initially deferred;

start transaction;
insert into Dipartimento values 
('id111','CS','SU',  'DK'),
('id000','CS','CU',  'AT'),
('id222','CS','CIT', 'JM');

insert into Ricercatore values 
('AT', 41, 'id000'),
('DK', 82, 'id111'),
('JM', 84, 'id222'),
('RT', 72, 'id222');
commit; 


--Creo il trigger che controlla che un ricercatore che è direttore di un dipartimento
-- non possa cambiare afferenza
create or replace function aggiorna_ricercatore()
returns trigger language plpgsql as 
$$
    declare 
    begin
        perform *
        from    dipartimento 
        where   old.nome = direttore
                and 
                (new.nome != direttore or id_dip != new.afferenza);

        if found 
        then 
            return null;
        else 
            return new;
        end if;
    end
$$;

create trigger bella_merda 
before update on Ricercatore 
for each row 
execute procedure aggiorna_ricercatore()


--No non viola nessuno di questi vincoli
update Ricercatore set afferenza = 'id111' where nome = 'RT';






















