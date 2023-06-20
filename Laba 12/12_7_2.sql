begin transaction 	  
	delete AUDITORIUM where AUDITORIUM_NAME = '1234'; 
    insert AUDITORIUM values ('1234', 'ËÊ-Ê', 10, '1234')
    update AUDITORIUM set AUDITORIUM_NAME = '1234' where AUDITORIUM = '1234'
    select AUDITORIUM from AUDITORIUM  where AUDITORIUM = '1234'
	-------------------------- t1 --------------------
commit

select AUDITORIUM from AUDITORIUM  where AUDITORIUM = '1234'
-------------------------- t2 -------------------