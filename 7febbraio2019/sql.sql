SELECT A.codiceAttore AS attore
from ATTORE as A
where not exists
    (select *
        from INTERPRETAZIONE as I1,INTERPRETAZIONE as I2,INTERPRETAZIONE as I3
        where 
            I1.attore = I2.attore = I3.attore = A.codiceAttore
            and I1.film <> I2.film and I2.film <> I3.film and I1.film <> I3.film
            and
                I1.film in(select film.codiceFilm from film where film.regista="Allen")
            and
                I2.film in(select film.codiceFilm from film where film.regista="Allen")
            and
                I3.film in(select film.codiceFilm from film where film.regista="Allen")  
    );




SELECT A.codiceAttore AS attore
from ATTORE as A
where not exists
    (select *
        from    INTERPRETAZIONE as i1 join film as f1 on i1.film = f1.codiceFilm,
                INTERPRETAZIONE as i2 join film as f2 on i2.film = f2.codiceFilm,
                INTERPRETAZIONE as i3 join film as f3 on i1.film = f3.codiceFilm
                where 
                    I1.attore = I2.attore = I3.attore = A.codiceAttore
                    and I1.film <> I2.film and I2.film <> I3.film and I1.film <> I3.film
                    and f1.regista = f2.regista = f3.regista = "allen"     
    );


SELECT A.codiceAttore AS attore
from ATTORE as A
where not exists(
    select *
    from 
        INTERPRETAZIONE as i1 join film as f1 on i1.film = f1.codiceFilm,
        INTERPRETAZIONE as i2 join film as f2 on i2.film = f2.codiceFilm,
        INTERPRETAZIONE as i3 join film as f3 on i3.film = f3.codiceFilm
    where 
        f1.regista = f2.regista and f2.regista = f3.regista and f1.regista = "allen"
        and i1.attore = i2.attore and i2.attore = i3.attore and i1.attore = A.codiceAttore
        and i1.film != i2.film and i2.film != i3.film and i3.film != i1.film
    );



SELECT distinct a1.nome, a2.nome 
from attore as a1, attore as a2 
WHERE
    a1.codiceAttore < a2.codiceAttore 
    AND
    EXISTS(
        SELECT * 
        from interpretazione as i1
        where i1.attore=a1.codiceAttore
            AND NOT EXISTS(
                SELECT * from interpretazione as i2
                where i2.film=i1.film and i2.attore=a2.codiceAttore 
            )
    )
    AND 
    EXISTS(
        SELECT * from interpretazione as i2
        WHERE i2.attore=a2.codiceAttore
        AND NOT EXISTS(
                SELECT * from interpretazione as i1
                where i1.film=i2.film and i1.attore=a1.codiceAttore 
            )
    )


    