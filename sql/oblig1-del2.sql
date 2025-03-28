# oppgave 14
select * from emp 
where deptno = 1 and lower(job) not in ('manager', 'clerk'); 

# oppgave 15
select * from emp 
where sal between 1200 and 1300; 

# oppgave 16 
select ename, job, deptno from emp
where lower(job) in ('clerk', 'analyst', 'salesman');

# oppgave 17 
select ename, job, sal from emp 
where sal not between 1200 and 1400; 

# oppgave 18
select ename, job, deptno from emp
where lower(job) not in ('clerk', 'salesman', 'analyst');

# oppgave 19 
select ename, job, deptno from emp
where lower(ename) like 'm%'; 

# oppgave 20 
select ename, job, deptno from emp
where lower(ename) like 'al__n'; 

# oppgave 21 
select sal, ename, deptno from emp
where deptno = 3
order by sal; 

# oppgave 22 
select sal, ename, deptno from emp 
where deptno = 3  
order by sal desc; 

# oppgave 23 
select ename, job, sal from emp 
order by job, sal desc; 

# oppgave 24 
select e.ename, d.loc
from emp as e, dept as d
where e.deptno = d.deptno
and e.ename = 'Allen'; 

# alt løsning oppg 24
select e.ename, d.loc 
from emp as e inner join dept as d
on d.deptno = e.deptno
where e.ename = 'Allen'; 

# oppgave 25 
select d.deptno, d.dname, e.job, e.ename 
from dept as d left outer join emp as e 
on d.deptno = e.deptno 
where d.deptno between 3 and 4; 

# oppgave 26
select d.deptno, d.dname, loc 
from emp as e right outer join dept as d 
on d.deptno = e.deptno
group by d.deptno
having count(e.deptno) < 1; 



 