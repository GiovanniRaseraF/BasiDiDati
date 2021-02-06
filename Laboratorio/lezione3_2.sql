--Definizione delle funzioni
create or replace function <nome> (<parametri>)
return <tipo>
language plpgsql as $$
    declare 
        <dichiarazione di variabili>
    begin
        <istruzioni>
    end;
$$;

--Funzione che mi conta gli impiegati in un dipartimento
create or replace function dip_count(nome_dip nomi_dipartimento)
returns integer 
language plpgsql as $$
    declare 
        d_count integer;
    begin 
        select count(*) into d_count 
        from Dipartimento D, Impiegato I 
        where I.dip = D.dnumero 
            and D.dnome = nome_dip;

        return d_count;
    end;
$$;

--Esempio di invocazione
select dnome, dip_count(dnome) from Dipartimento;

--Ritorna la somma e il prodotto
create or replace function somma_prodotto(x int, y int, out somma in, out prod int)
language plpgsql as $$
    begin 
        somma := x + y;
        prod := x * y;
    end;
$$;

select somma_prodotto(3, 4);

select * from somma_prodotto(3, 4);

--Posso create dei tipi di ritorno
create type somma_prod as (somma int, prod int);

create or replace function somma_prodotto(x int, y int)
returns somma_prod 
language plpgsql as $$
    declare 
        risultato record;
    begin 
        risultato := (x+y, x*y);
        return risultato;
    end;
$$;

--Valore di ritorno come tabella
create or replace function donne_dip(nome_dip varchar(20)) 
returns table (
    cognome nomi_persona,
    iniziale iniziali_persona,
    nome nomi_persona
)
language plpgsql as $$
    begin 
        return query 
        select I.cognome, I.iniziale, I.nome 
        from Dipartimento D, Impiegato I 
        where I.dip = D.dnumero 
            and D.dnome = nome_dip 
            and I.sesso = 'F';
    end;
$$;

select * from donne_dip('Dipartimento 1');

--Un impiegato e il suo supervisore devono afferire allo stesso
-- dipartimento
--    verrà chiamata ogni volta che faccio un inserimento nella
--    tabella
create or replace function 
controlla_supervisore(imp cf_persona)
returns boolean language plpgsql as
$$
    declare 
        ok boolean; 
    begin 
        raise notice 'Controllo supervisore di %', imp;
        
        select I.dip = S.dip into ok 
        from Impiegato I join Impiegato S on I.cf = imp 
        where I.supervisore = S.cf;

        return ok;
    end;
$$;
--controllo il vincolo ogni volta che aggiungo una riga
alter table Impiegato add constraint supervisione 
check (controlla_supervisore(cf));

--Esercizio

--Si definisca una funzione che, ricevuto in input un mid,
-- restituisca il suo ratings medio
create or replace function rating_medio(mid int)
returns number 
language plpgsql as 
$$ 
    declare 
        r_medio number;
    begin 
        select avg(stars) to r_medio 
        from rating 
        where rating.mid = mid;

        return r_medio;
    end;
$$;