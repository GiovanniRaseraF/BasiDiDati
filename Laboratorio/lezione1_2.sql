--Transazioni
    -- tante operazioni in sequenza viste come un operazione atomica
    -- vincoli ACID
    -- devo rispettare i vincoli che ho specificato

--esempio

start transaction;
    update ContoCorrente set saldo = saldo - 1000
        where numero = 9876;
    update ContoCorrente set saldo = saldo + 1000
        where numero = 9999;
commit;

--commit mi dice che è andata a buon fine 
--roolback non è andata a buon fine

--Durante la transazione posso differire i vincoli di integrità
--Molto importante per i vincoli circolari

create table T(
    x int primary key,
    y int references U deferrable initially immediate,
    z int references U deferrable initially deferred
);

create table S(
    x int primary key,
    y char references r deferrable initially immediate
); 

start transaction ;
set constraint all deferred;
insert into S values (3, 'a');
insert into R values ('a', null);
commit;

start transaction;
insert into S(x, y) values (5, 'b');
--non andrà a buon fine siccome non ho messo set constraint all deferred;

-- ricreo R con la keyword per non scrivere set constraint all deferred;
create table S(
    x int primary key,
    y char references r deferrable initially deferred
); 


start transaction;
insert into S(x, y) values (5, 'b');
insert into R values ('b', null);
commit;


-- Se voglio popolare il database lo devo fare in modo atomico
/*All'inizio di tutto non specifico le chiavi esterne e poi
usando una tranzazione posso settare ciò che mi serve

Posso anche farlo mettendo la chiave esterna deferrable
e poi tramite una transazione metto apposto le cose
*/



