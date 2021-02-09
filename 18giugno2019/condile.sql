--Creazione delle tabell
--Autore
create domain nomi as varchar(20);

create table autore(
    cf      nomi primary key,
    nome    nomi,
    cognome nomi
);
--Libro
create table libro(
    isbn   nomi primary key,
    titolo  nomi,
    anno    date
);
--Ha Letto
create table ha_scritto(
    cf      nomi, 
    isbn   nomi,
    primary key(cf, isbn),
    foreign key(cf) references autore 
        on update cascade on delete cascade,
    foreign key(isbn) references libro
        on update cascade on delete cascade
);

--la vuolazione può avvenire tramite inserimento o aggiornamento

--Vincolo 1: Ciascun autore può scrivere al massimo 2 libro
--Controllo che un autore abbia al massimo 2 libri
create or replace function max_2_libri()
returns trigger language plpgsql as
$$
    declare
        numero_libri_scritti integer;
    begin
        select count(*) into numero_libri_scritti 
        from ha_scritto 
        where new.cf = ha_scritto.cf;

        if numero_libri_scritti < 2
        then 
            return new;     --Inseriscila
        else 
            return null;    --Non inserirla
    end;
$$;

create trigger inserimento_in_ha_scritto 
before update or insert on ha_scritto 
for each row
execute procedure max_2_libri();

--Vincolo 2: due libri possono avere lo stesso titolo se sono stati scritti da autori diversi
create or replace function stesso_titolo_aut_div() 
returns trigger language plpgsql as 
$$
    declare
        numero_con_stesso_nome  integer;
        new_titolo              nomi;
        new_isbn                nomi;
    begin
        --Ho trovato il titolo
        select titolo into new_titolo, isbn into new_isbn
        from new join libro on new.isbn = libro.isbn;
        --Ora cerco se c'è un titolo uguale con isbn diverso e scritto da new.cf
        perform *
        from ha_scritto, libro
        where new.cf = ha_scritto.cf 
            and 
            libro.isbn != new.isbn 
            and
            new_titolo = libro.titolo;

        if found 
        then 
            return null;
        else 
            return new;
        end if;
    end;
$$;

create trigger solo_un_titolo_a_autore()
before insert or update on ha_scritto 
for each row
execute procedure stesso_titolo_aut_div(); 







