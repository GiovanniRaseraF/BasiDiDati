--Anomalie
    --Perdita di aggiornamento
    --Lettura sporca
    --Aggiornamento fantasma
    --Letture inconsistenti
    --Inserimento fantasma

--Domanda vecchio esame
--Esistono schedule seriali non serializzabili
    --No tutti sono serializzabili


--Livelli di isolamento nello standard sql:
                                                --agg. fant
--Livello di isolamento     |   Letture sporche | Letture inco  | Ins fantasma
--1read uncommitted              possibile           possibile       possibile
--2read committed             non-possibile          possibile       possibile
--3repeatable read            non-possibile       non-possibile      possibile
--4serializable               non-possibile       non-possibile   non-possibile


--Nel livello 1, nessun vincolo sui lock
--Nel livello 2, lock condivisi in lettura(no 2 fasi) 2pl sulla scrittura
--Nel livello 3, 2pl stretto
--Nel livello 4, 2pl stretto + lock_di_predicato


--Livelli di isolamento nello standard sql:
                                                --agg. fant
--Livello di isolamento     |   Letture sporche | Letture inco  | Ins fantasma
--1read uncommitted              possibile           possibile       possibile
--2read committed             non-possibile          possibile       possibile
--3repeatable read            non-possibile       non-possibile   non-possibile
--4serializable               non-possibile       non-possibile   non-possibile

--Perchè non è presente la perdita di aggiornamento ?
    --secondo lo std sql questa anomalia è sempre evitata

--Postgres differisce dalla standard:
    --la perdita di aggiornamento non è sempre evitata
        --evitata solo da repeatable read in sù
    --il livello repeatable read è più restrittivo dello standard
        --esempio gli inserimenti fantasma non sono possibili nel repeatable read
    

--Postgres: il livello di isolamento
start transaction;
set transaction isolation level
    {serializable | repeatable read | read committed | repeatable read};


--Default : read committed

--Provare le letture inconsistenti

--Commento sull'anomalia dell'aggiornamento fantasma
-- risolta dal livello repeatable read tramite snapshot isolation

--Uno schedule è seriale: se ogni transazione è eseguita una dopo l'altra
--Uno schedule serializzabile: è uno schedule che è uguale in qualche modo ad 
    -- ad uno schedule seriale