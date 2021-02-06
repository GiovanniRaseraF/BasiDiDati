--Ottieni in ordine alfabetico i nomi dei registi dei film che hanno ricevuto
-- una valutazione media in tutti i loro film >= 3
select director, avg(stars) as media 
from movie natural join rating 
where director is not null 
group by director 
having media > 3
order by director;

--Ottieni per ciascun critico il numero di film da costui recensiti e ordina
-- il risultato in ordine alfabetico
select name, count(distinct mid) as numerorecensioni
from reviewer natural join rating 
group by name, rid
order by name asc;

--Ripeti l'interrogazione precedente ma solo i cirtici che hanno ricensito solo un
-- film
select name, count(distinct mid) as numero 
from reviewer natural join rating 
group by name, rid 
having numero = 1
order by name asc;

--ANNIDAMENTO

--Tra i film che sono stati recensiti almeno una volta trova i titoli di quelli
-- che hanno ricevuto soltato recensioni >= 4
--aggregate
select title 
from movie natural join rating 
group by mid, title 
having min(stars) >= 4;

--no aggregazione
select distinct title 
from movie natural join rating 
where not exists(
    select *
    from rating 
    where 
        stars < 4
        and
        rating.mid = movie.mid 
)
order by title;


















