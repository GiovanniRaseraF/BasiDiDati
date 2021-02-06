--Trigger
--scrivere un trigger per implementare la specializzazione esclusiva
--o un libro o un dvd ma non entrambi
-- valuta libro, valuta dvd
-- Trigger su libro: voglio che vieti (before) inserimento o
-- aggiornamento (insert or update) su Libro tali che non 
-- rispettino la specializzazione esclusiva
-- Devo quindi vietare che nella tabella DVD una tupla con id = new.id

create or replace function valida_libro()
returns trigger language plpgsql as
$$
    declare 
        dummy dom_cod_prodotto;
    begin
        select id into dummy 
        from dvd 
        where id = new.id;

        if FOUND            --SE VIEN TROVATO QUALCOSA
        then
            raise exception 'Specializzazione non esclusiva!';
            return null;
        else
            return new;
        end if; 
    end;
$$;

create trigger libro_esclusivo before 
insert or update 
on LIBRO 
for each row
execute procedure valida_libro();

--Per dvd
create or replace function valida_dvd()
returns trigger language plpgsql as
$$
    begin
        perform * 
        from libro 
        where id = new.id;

        if FOUND            --SE VIEN TROVATO QUALCOSA
        then
            raise exception 'Specializzazione non esclusiva!';
            return null;
        else
            return new;
        end if; 
    end;
$$;