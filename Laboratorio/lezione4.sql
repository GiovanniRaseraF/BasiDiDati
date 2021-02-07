--Transazioni
--update ... : 
--Ogni istruzione è una transazione fatta da una sola riga
--ACID
    -- Atomicità
    -- Consisitenza -> tutti i vincoli di integrità sono rispettati
                        --alcuni vincoli possono essere differibili durante la
                        --transazione
    -- Isolamento   -> l'esecuzione di ciascuna transazione deve essere indi
                        --pendente
                        --equivalenza rispetto ad uno schedule seriale
    -- Persistenza  -> dati registrati in modo permanente dei dati
    
--Fine transazione
    --commit: esito positivo
    --rollback: esito negati
        --esplicito
        --implicito
    
--Esecuzioni di transazioni in sql:
    --inizio di transazione
start transaction;

--esempio:
    --transazione che sposta 100 dollari dal conto 754 a 1234
accounts
acctnum | balance
-----------------
        |           

start transaction;
update accounts set balance = balance +100 where acctnum = 1234;
update accounts set balance = balance -100 where acctnum = 754;
commit;

--Ogni istruzione è una transazione unitaria
--Le transazioni non possono essere annidate.

--Come differire il controllo dei vincoli in sql:
r                       s 
x   |   y           w   |   z 
---------           ---------

Rk : x              pk: w 
fk:y -> s(w)        fk:z ->r(x)

--definizione dei dati : keyword "deferrable"
    --deferrable initially immediate 
    --deferrable initially deferred

--durante la transazione keyword set constraints all deferred

create table R(x int primary key, y int not null);
create table s(w int primary key, z int not null references r deferrable);
alter table r add foreign key (y) references s deferrable;

start transaction;
set constraints all deferred;
insert into r values (1, 10);
insert into s values (10, 1);
commit;