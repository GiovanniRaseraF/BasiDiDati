--Funzione attivata prima o dopo un ovento
--Un trigger esegue una UDF
create trigger <nome> {before | after} <evento> 
on <tabella>
for each {row | statement}
[when <condition>]
execute procedure <function>();

--specificazione
create or replace function nome_funzione()
return trigger 
language plpgsql as $$ 
    declare 
        <dichiarazioni di variabili>
    begin 
        <istruzioni>
    end;
$$;

--Esempio
--Nessun dipartimento può avere più di sei impiegati
create or replace function controlla_num_dip()
returns trigger language plpgsql as 
$$
    declare 
        n integer;
    begin 
        select count(*) into n from Impiegato I 
        where new.dip = I.dip;

        if n >= 6
            then 
            raise notice 'Numero massimo raggiunto per il dip';
            return null; -- Annulla l'operazione
        end if;
    
        return new;
    end;
$$;

--Poi lo metto
create trigger controlla_impiegato 
before insert or update on Impiegato 
for each row 
execute procedure controlla_num_dip();
