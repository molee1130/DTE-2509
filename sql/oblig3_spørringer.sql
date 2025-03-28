-- 1. ledige biler innenfor et datointervall
select *
from bil 
where reg_nr not in (
    select reg_nr
    from booking
    where dato_fra <= '2023-10-09' and dato_til >= '2023-10-06'
);

-- 2. inntjening for en bestemt utleier for en gitt periode.
-- inntjening for bruker_id=1 i oktober 2023
select sum(b.pris_per_døgn * (datediff(bk.dato_til, bk.dato_fra) + 1)) as inntjening
from booking bk
inner join bil b on bk.reg_nr = b.reg_nr
where bk.utleier = 1
  and bk.dato_fra >= '2023-10-01'
  and bk.dato_til <= '2023-10-31';

-- 3. utgifter for en bestemt bruker/utleier for en gitt periode.
-- utgifter for bruker_id=2 i oktober 2023
select sum(b.pris_per_døgn * (datediff(bk.dato_til, bk.dato_fra) + 1)) as utgifter
from booking bk
inner join bil b on bk.reg_nr = b.reg_nr
where bk.leietaker = 2
  and bk.dato_fra >= '2023-10-01'
  and bk.dato_til <= '2023-10-31';

-- 4. alle fullførte bookinger
select *
from booking
where dato_til < curdate();

-- 5. sortert liste over utleiere basert på karakter
select utleier, avg(karakter_utleier) as gjennomsnittlig_karakter
from booking
where karakter_utleier is not null
group by utleier
order by gjennomsnittlig_karakter desc;
