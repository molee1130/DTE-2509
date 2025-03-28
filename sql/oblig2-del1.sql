-- Oblig 2 Del 1
-- Morten Leegaard

-- oppgave 1 
select ename, sal, comm 
from emp 
where comm > (0.25*sal); 

-- oppgave 2 
select ename, (comm/sal), comm, sal 
from emp 
where comm is not null
order by comm/sal desc; 

-- oppgave 3 
select ename, sal, comm, 12*(sal+comm)
from emp 
where lower(job) = 'salesman'; 

-- oppgave 4 
select avg(sal)
from emp
where lower(job) = 'clerk' ; 

-- oppgave 5
select sum(sal), sum(comm)
from emp 
where lower(job) = 'salesman';

-- oppgave 6

select count(comm)
from emp 
where comm > 0; 

-- oppgave 7
select count(distinct job)
from emp 
where deptno = 3; 

-- oppgave 8 
select count(*) 
from emp 
where deptno = 3; 

-- oppgave 9 
select deptno, round(avg(sal)) as AverageSalary  
from emp 
group by deptno; 

-- oppgave 10 
select concat(dname, ' - ', loc) as Departements 
from dept; 

-- oppgave 11 
select ename, job, 
case 
	when lower(job) = 'clerk' then 1
    when lower(job) = 'salesman' then 2
    when lower(job) = 'manager' then 3 
    when lower(job) = 'analyst' then 4 
    when lower(job) = 'president' then 5 
    end as job_class
from emp; 

-- oppgave 12
select substring(ename, 2) 
from emp; 

-- oppgave 13
select curdate(); 