	--6--
	--A--
set transaction isolation level REPEATABLE READ
	begin transaction
		select AUDITORIUM_CAPACITY from ##Ex6 where AUDITORIUM = '123-3'
			------
		select case
			   when AUDITORIUM_CAPACITY = 50 then 'insert'  else ' ' 
		end 'результат', AUDITORIUM from ##Ex6 where AUDITORIUM = '123-3'
commit
