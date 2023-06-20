--5--
--B--
begin transaction 	  
-------------------------- t1 --------------------
update AUDITORIUM set AUDITORIUM_CAPACITY = 30 where AUDITORIUM_CAPACITY = 13
commit
-------------------------- t2 --------------------