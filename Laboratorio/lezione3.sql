--Ottieni in ordine alfabetico i nomi dei registi dei film che hanno ricevuto
-- una valutazione media in tutti i loro film >= 3
select director, avg(stars) as media 
from movie natural join rating 
where director is not null 
group by director 
having media > 3
order by director;

