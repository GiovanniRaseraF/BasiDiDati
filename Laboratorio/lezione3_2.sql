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

--