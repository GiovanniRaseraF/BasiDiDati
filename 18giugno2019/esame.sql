--Creazione tabelle
create table autore(
    cf varchar(20) primary key,
    nome varchar(20),
    cognome varchar(20)
);

create table libro(
    cisbn varchar(20) primary key,
    titolo varchar(20),
    anno date
);

create table ha_scritto(
    cf  varchar(20),
    cisbn varchar(20),
    primary key(cf, cisbn)
);

alter table ha_scritto 
add constraint fk_autore foreign key(cf) 
references autore
on update cascade on delete cascade,
add constraint fk_libro foreign key(cisbn)
references libro 
on update cascade on delete cascade;

create or replace function ha_scritto_max_5()
returns trigger language plpgsql as
$$
    declare 
        numero integer;
    begin
        select count(*) into numero
        from ha_scritto 
        where new.cf = ha_scritto.cf;

        if numero < 5 
        then 
            return new;
        else 
            return null;
        end if;
    end;
$$;

create trigger controlla_numero_libri
before insert or update on ha_scritto 
for each row 
execute procedure ha_scritto_max_5();