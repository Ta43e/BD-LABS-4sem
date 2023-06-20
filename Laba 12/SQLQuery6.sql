set nocount on
	if  exists (select * from  SYS.OBJECTS        -- таблица X есть?
	            where OBJECT_ID= object_id(N'DBO.X') )	            
	drop table X;           
	declare @c int, @flag char = 'c';           -- commit или rollback?
	SET IMPLICIT_TRANSACTIONS  ON   -- включ. режим неявной транзакции
	CREATE table X(K int );                         -- начало транзакции 
		INSERT X values (1),(2),(3);
		set @c = (select count(*) from X);
		print 'количество строк в таблице X: ' + cast( @c as varchar(2));
		if @flag = 'c'  commit;                   -- завершение транзакции: фиксация 
	          else   rollback;                                 -- завершение транзакции: откат  
      SET IMPLICIT_TRANSACTIONS  OFF   -- выключ. режим неявной транзакции
	
	if  exists (select * from  SYS.OBJECTS       -- таблица X есть?
	            where OBJECT_ID= object_id(N'DBO.X') )
	print 'таблица X есть';  
      else print 'таблицы X нет'
-- в случае если в try заполнение не получится, код перейдет в catch, выдаст ошибку и выполнится откат через rollback
-- доказали что работает свво атомарности

USE UNIVER
DECLARE @trcount int
BEGIN TRY -- начало блока try
  BEGIN TRAN -- Переключение в режим явной транзакции
    DELETE AUDITORIUM_TYPE WHERE AUDITORIUM_TYPENAME = 'Новая лекционная';
    --DELETE AUDITORIUM_TYPE WHERE AUDITORIUM_TYPENAME = 'Самая новая лекционная';
    INSERT AUDITORIUM_TYPE VALUES ('ЛК-Н', 'Новая лекционная');
    INSERT AUDITORIUM_TYPE VALUES ('ЛК-Н', 'Новая лекционная');
    INSERT AUDITORIUM_TYPE VALUES ('ЛК-С', 'Самая новая лекционная');
    COMMIT TRAN;
  END TRY
BEGIN CATCH 
    PRINT 'Ошибка: ' + case -- PATINDEX определяет в строке позицию первого символа под-строки, заданную шаблоном
              WHEN error_number() = 2627 and patindex('%AUDITORIUM_TYPE_PK%', error_message()) > 0 -- 2627 - Ошибка дубл поля
                THEN 'дублирование типа аудитории'
               else 'неизвестная ошибка: ' + cast(error_number() as varchar(5)) + error_message()
               end;
  SET @trcount = @@TRANCOUNT  -- возвращает уровень вложенности транзакции (если больше 0 то тран не закончена)
  PRINT @trcount
  IF @@TRANCOUNT > 0 ROLLBACK TRAN;
END CATCH;


-- в итоге получится что так как тран не заверш (@trancount будет = 1), то произойдет откат и изменен insert не вступят в силу
-- также мы не примере показали работу св-ва атомарности: опер-ы изм-я включе в тран-ю либо все выполня-я, либо нет.

--3. Разработать сценарий, демонстрирующий применение оператора SAVE TRAN на примере базы данных UNIVER. 
--В блоке CATCH предусмотреть выдачу соответствующих сообщений об ошибках. 
--Опробовать работу сценария при использовании различных контрольных точек и различных операторов модификации таблиц.
	select * 
	into #tmp
	from AUDITORIUM

	--DROP TABLE #tmp
DECLARE @point VARCHAR(32), @i INT = 0;
BEGIN TRY
	BEGIN TRAN
		DELETE #tmp where AUDITORIUM_CAPACITY = 1;
		SET @point = 'P1'; SAVE TRAN @POINT;
		--set @i = @i / 0;
		INSERT #tmp values ('123-3', 'ЛК-К', 123, '123-3');
		set @point = 'p2'; save tran @point;
		insert #tmp values ('123-3', 'ЛК-К', 123, '123-3');
		commit tran;
	end try
	begin catch
		print 'ошибка' + case when error_number() = 2627
								and patindex('%PK_tmp', error_message()) > 0
							then 'дублирование аудитории'
							else 'неизвестная ошибка:' + cast(error_number() as varchar(5))
								+ error_message()
							end;
	if @@TRANCOUNT > 0
		begin 
			print 'контрольная точка: ' + @point;
			rollback tran @point;
			commit tran;
		end;
	end catch;

	select * from #tmp

--4. Разработать два сценария A и B на примере базы дан-ных UNIVER. 
--Сценарий A представляет собой явную транзакцию с уровнем изолированности
--READ UNCOMMITED, сценарий B – явную транзакцию с уровнем изолированности READ COMMITED (по умолчанию). 
--Сценарий A должен демонстрировать, что уровень READ UNCOMMITED допускает
--неподтвержденное, неповторяющееся и фантомное чтение. 

	-- A ---
	--DROP table ##tmp
	select * 
	into ##tmp
	from AUDITORIUM

	set transaction isolation level READ UNCOMMITTED 
	begin transaction 
	-------------------------- t1 ------------------
	select @@SPID, 'insert AUDITORIUM' 'результат', * from ##tmp;
	select @@SPID, 'update AUDITORIUM_TYPE'  'результат',  AUDITORIUM_TYPE, 
                      AUDITORIUM_TYPENAME from AUDITORIUM_TYPE;
	commit; 
	-------------------------- t2 -----------------
	--- B --	
	begin transaction 
	select @@SPID
	insert ##tmp values ('33-3', 'ЛК-К', 76, '87-3'); 
	update AUDITORIUM_TYPE set AUDITORIUM_TYPE  =  'ЛБ-К' 
                           where AUDITORIUM_TYPE = 'ЛБ-Х' 
	-------------------------- t1 --------------------
	-------------------------- t2 --------------------
	rollback;
		SELECT  * FROM ##tmp

--	5. Разработать два сценария A и B на примере базы дан-ных UNIVER. 
--Сценарии A и В представляют собой явные транзакции с уровнем изолированности READ COMMITED. 
--Сценарий A должен демонстрировать, что уровень READ COMMITED не допускает неподтвержденного чтения,
--но при этом возможно неповторяющееся и фантомное чтение. 
	select * 
	into ##Ex5
	from AUDITORIUM
	DROP TABLE ##Ex5

--	6. Разработать два сценария A и B на примере базы данных UNIVER. 
--Сценарий A представляет собой явную транзакцию с уровнем изолированности REPEATABLE READ.
--Сценарий B – явную транзакцию с уровнем изолированности READ COMMITED. 
--Сценарий A должен демонстрировать, что уровень REAPETABLE READ не допускает
--неподтвержденного чтения и неповторяющегося чтения, но при этом возможно фантомное чтение. 
	select * 
	into ##Ex6
	from AUDITORIUM
	DROP TABLE ##Ex6
--	7. Разработать два сценария A и B на примере базы данных UNIVER. 
--Сценарий A представляет собой явную транзакцию с уровнем изолированности SERIALIZABLE. 
--Сценарий B – явную транзакцию с уровнем изолированности READ COMMITED.
--Сценарий A должен демонстрировать отсутствие фан-томного, неподтвержденного и неповторяющегося чтения.
	select * 
	into ##Ex7
	from AUDITORIUM
	DROP TABLE ##Ex7
--8. Разработать сценарий, демонстрирующий свойства
--вложенных транзакций, на примере базы данных UNIVER.

begin tran
	insert AUDITORIUM_TYPE values ('TE--T', 'Спец. компьютерный класс')
	begin tran
		INSERT AUDITORIUM VALUES ('33', 'ЛК', 12, '985')
		commit
	if @@TRANCOUNT > 0
commit

select (select count(*) from AUDITORIUM where AUDITORIUM_TYPE = 'ЛБ-К') AUDITORIUM,
	   (select count(*) from AUDITORIUM_TYPE where AUDITORIUM_TYPE = 'TE--T') AUDITORIUM_TYPE;


