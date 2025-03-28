-- Oblig2-del2 
-- Morten Leegaard 

-- oppgave 1 
select now(); 

-- oppgave 2 
select ename, sal, comm, job 
from emp 
where comm is null or comm = 0; 

-- oppgave 3 
select ename, sal, comm, job 
from emp
where comm <> 500; 

-- oppgave 4 
select ename, job 
from emp 
where job = (
	select job 
    from emp 
    where ename = 'Jones'
    ); 
    
-- oppgave 5 
select ename, job
from emp 
where deptno = 1 and job in ( 
	select distinct job
    from emp
    where deptno = 3
    ); 
    
-- oppgave 6 
select ename, job 
from emp 
where deptno = 1 
	and job not in (
		select distinct job 
        from emp 
        where deptno = 3
        ); 

-- oppgave 7 
select ename, job, deptno, sal 
from emp 
where (job, sal) in (
	select job, sal 
    from emp 
    where lower(ename) = 'ford'); 

-- oppgave 8 
select ename, job, deptno, sal 
from emp 
where job = (
	select job 
    from emp 
    where lower(ename) = 'jones'
    ) 
    or 
    sal >= (
    select sal 
    from emp 
    where lower(ename) = 'ford'
    )
order by job, sal; 

-- oppgave 9 
select emp.ename, emp.job  
from emp 
where deptno = 1 
	and job in (
		select job
        from emp 
        inner join 
			dept 
            on dept.deptno = emp.deptno
        where dept.dname = 'Sales'); 
        
-- oppgave 10 
select ename, job, sal 
from emp
where sal in (
	select sal
    from emp
    where ename = 'Scott' 
    union 
    select sal 
    from emp 
    where ename = 'Ward'); 
    
-- oppgave 11
select ename, job 
from emp 
where job in (
	select job
    from emp
		inner join 
			dept 
            on dept.deptno = emp.deptno 
	where dept.loc = 'Chicago'
        )
order by job; 

-- oppgave 12 
select ename, sal as Salary, sal/tot_sal*100
from (select ename, sal, sum(sal) over() as tot_sal
	from emp)
    as sub
order by sal; 

-- Bruk av view
drop view if exists emp_with_total; 
create view emp_with_total as 
select ename, sal, (select sum(sal) from emp) as tot_sal
from emp; 

select ename, sal, sal/tot_sal*100 
from emp_with_total
order by sal; 