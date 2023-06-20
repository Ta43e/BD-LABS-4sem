--5--

set transaction isolation level READ COMMITTED 
-- A ---
begin transaction 
select count(*) from AUDITORIUM where AUDITORIUM_CAPACITY = 30
-------------------------- t1 ------------------ 
-------------------------- t2 -----------------
select 'update' AUDITORIUM, count(AUDITORIUM_CAPACITY) from AUDITORIUM where AUDITORIUM_CAPACITY = 30;
commit

     