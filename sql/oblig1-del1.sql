# oppgave 1 

select * from dept; 

# oppgave 2 
select * from emp; 

# oppgave 3 
select job from emp;

# oppgave 4 
select distinct job from emp; 
 
# oppgave 5
select dname as Department from dept; 

# oppgave 6 
select * from emp 
where deptno = 3; 

# oppgave 7
select ename, empno, deptno from emp
where lower(job) = 'clerk'; 

# oppgave 8 
select dname, deptno from dept 
where deptno > 2; 

# oppgave 9
select ename, sal, comm from emp 
where comm > sal; 

# oppgave 10 
select ename, sal, deptno from emp
where deptno = 3 and sal >= 1500 and lower(job) = 'salesman'; 

# oppgave 11 
select ename, sal, job from emp
where sal > 3000 or lower(job) = 'manager'; 

# oppgave 12
select * from emp
where lower(job) = 'manager' or lower(job) = 'clerk' and deptno = 1; 

# oppgave 13 
select ename, job, deptno from emp
where deptno <> 3 and lower(job) = 'manager';  
