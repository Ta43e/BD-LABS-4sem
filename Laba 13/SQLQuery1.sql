select *
into ##Ex4
FROM AUDITORIUM
select *
into ##Ex6
FROM SUBJECT
-- 1. Разработать хранимую процедуру без пара-метров с
--именем PSUBJECT.

DROP PROCEDURE PSUBJECT

USE UNIVER
GO 
CREATE PROCEDURE PSUBJECT
AS
BEGIN
	DECLARE @K INT = (SELECT COUNT(*) FROM SUBJECT);
	SELECT * FROM SUBJECT;
	RETURN @K;
END;


DECLARE @Result INT;
EXEC @Result = PSUBJECT;
SELECT @Result;

----2. Найти процедуру PSUBJECT с помощью обозревателя
--объектов (Object Explorer) и через контекстное меню создать
--сценарий на изменение про-цедуры оператором ALTER.
----Изменить процедуру PSUBJECT, созданную в задании 1,
--таким образом, чтобы она принимала два параметра с именами @p и @c.
--Параметр @p является входным, имеет тип varchar(20)
--и значение по умолчанию NULL. Параметр @с является вы-ходным, имеет тип INT.
----Процедура PSUBJECT должна формировать результирующий
--набор, аналогичный набору, представленному на рисунке выше,
--но при этом содержать строки, соответствующие коду кафедры,
--за-данному параметром @p. Кроме того, процедура должна формировать
--значение выходного параметра @с, равное количеству строк в
--результирующем наборе, а также возвращать значение к точке вызова,
--равное общему количеству дисциплин (количеству строк в таблице SUBJECT).\
GO
alter procedure PSUBJECT @p varchar(20), @c int output
as begin
	DECLARE @K INT = (SELECT COUNT(*) FROM SUBJECT);
	SELECT * FROM SUBJECT WHERE SUBJECT = @p
	SET @c = @@ROWCOUNT;
	RETURN @K;
	END;

DECLARE @s varchar(20) = 'БД', @l int = 0, @O int = 0;
exec @l = PSUBJECT @s, @c = @O output;
print 'Кол-во всего ' + cast(@l as varchar(3));
print 'Кол-во определенных ' + cast (@O as varchar(10))


SELECT * FROM TEACHER

GO 
CREATE procedure SUCHE @p varchar(20) 
AS BEGIN 
declare @K int = (SELECT COUNT(*) FROM TEACHER WHERE TEACHER LIKE '%' + @p + '%')
return @K
END;

--DROP procedure SUCHE

DECLARE @result INT
DECLARE @STR VARCHAR(20) = 'Б'
EXEC @result = SUCHE @p = @STR
SELECT @result
--3. Создать временную локальную таблицу с име-нем #SUBJECT. Наименование и тип столбцов
--таблицы должны соответствовать столбцам результирующего набора процедуры PSUBJECT, разработанной в задании 2. 
--Изменить процедуру PSUBJECT таким образом, чтобы она не содержала выходного параметра.
--Применив конструкцию INSER EXECUTE с модифицированной процедурой PSUBJECT, добавить строки в таблицу #SUBJECT.
go
alter procedure PSUBJECT @pVal varchar(20)
as begin
declare @K int = (select count(*) from SUBJECT)
	SELECT * FROM SUBJECT WHERE SUBJECT = @pVal
	end;

	create table #ex6
	(
	SUBJECT CHAR(10) PRIMARY KEY,
	SUBJECT_NAME VARCHAR(100),
	PULOIT CHAR(20)
	)

 INSERT #ex6 EXEC PSUBJECT @pVal = 'БД'
 INSERT #ex6 EXEC PSUBJECT @pVal = 'МП'

 SELECT * FROM #ex6
-- 4. Разработать процедуру с именем PAUDITO-RIUM_INSERT.
--Процедура принимает четыре входных параметра: @a, @n, @c и @t.
--Параметр @a имеет тип CHAR(20), параметр @n имеет тип VARCHAR(50),
--параметр @c имеет тип INT и зна-чение по умолчанию 0, параметр @t имеет тип CHAR(10).
--Процедура добавляет строку в таблицу AUDI-TORIUM. Значения
--столбцов AUDITORIUM, AU-DITORIUM_NAME, AUDITORIUM_CAPACITY и
--AUDITORIUM_TYPE добавляемой строки задают-ся соответственно
--параметрами @a, @n, @c и @t.
--Процедура PAUDITORIUM_INSERT должна применять механизм TRY/CATCH для
--обработки ошибок. В случае возникновения ошибки, процеду-ра должна
--формировать сообщение, содержащее код ошибки, уровень серьезности и 
--текст сообщения в стандартный выходной поток. 
--Процедура должна возвращать к точке вызова значение -1 в
--том случае, если произошла ошибка и 1, если выполнение успешно. 
--Опробовать работу процедуры с различными значениями исходных данных.
go 

create procedure Zadanie4
	@Aud char(20), @Type char(20), @Name varchar(50), @Capacity INT = null 
	as declare @rc int = 1;
	begin try
	 insert into ##Ex4 (AUDITORIUM, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY, AUDITORIUM_NAME)
		VALUES (@Aud, @Type , @Name, @Capacity )
	return @rc;
	end try
begin catch
	print 'номер ошибки: ' + cast(error_number()as varchar(6));
	print 'Сообщение: ' + error_message();
	print 'номер строки: ' + cast(error_line() as varchar(8));
	if ERROR_PROCEDURE() is not null
	print 'Процедура: ' + error_procedure();
	return -1;

end catch

DROP procedure Zadanie4

declare @rc int
exec @rc = Zadanie4 @Aud = '544-2', @Type = 'ЛБ-К', @Capacity = 123, @Name = '544-2'
print 'код ошибки: ' + cast(@rc as varchar(3));
select * from ##Ex4
--5 Разработать процедуру с именем SUB-JECT_REPORT, формирующую в стандартный
--выходной поток отчет со списком дисциплин на конкретной кафедре. В отчет должны
--быть выведе-ны краткие названия (поле SUBJECT) из таблицы SUBJECT в одну строку
--через запятую (использо-вать встроенную функцию RTRIM). Процедура име-ет входной
--параметр с именем @p типа CHAR(10), который предназначен для указания кода кафедры.
--В том случае, если по заданному значению @p невозможно определить код кафедры,
--процедура должна генерировать ошибку с сообщением ошиб-ка в параметрах. 
--Процедура SUBJECT_REPORT должна воз-вращать к точке вызова количество дисциплин, отображенных в отчете. 
go
create procedure SUBJECT_REPORT @p char(20)
as 
declare @rС int = 0;
begin try
	declare @Cafedra CHAR(20), @str CHAR(300) ='';
	declare SUBJECT_KURSOR CURSOR FOR
	SELECT SUBJECT_NAME FROM ##Ex6 where SUBJECT = @p;
	open SUBJECT_KURSOR;	  
	fetch  SUBJECT_KURSOR into @Cafedra;   
	print   'Челы на кафедре';   
	while @@fetch_status = 0                                     
		begin 
				set @str = rtrim(@Cafedra) + ',' + @str;  
				set @rС = @rС + 1;       
				fetch  ZkTov into @Cafedra; 

		end;   
print @str;
close SUBJECT_KURSOR;
return @rС;
end try
   begin catch              
        print 'ошибка в параметрах' 
        if error_procedure() is not null   
		print 'имя процедуры : ' + error_procedure();
        return @rС;
   end catch; 

   --drop procedure SUBJECT_REPORT


   declare @rС int;
   exec @rС = SUBJECT_REPORT @p = 'ООП';
   print 'количество товаров = ' + cast(@rС as varchar(3)); 
	
	--6
	SELECT * 
	INTO ##Ex8 
	from AUDITORIUM

	SELECT * 
	INTO ##Ex8_2
	from AUDITORIUM_TYPE


	go
	create procedure PAUDITORIUM_INSERTX
	 @Name varchar(50), @NameAud char(20), @Capacity INT = null,  @tn varchar(50), @t varchar(50)
	 as declare @Result6 int = 1;
	 begin try
		set transaction  isolation level SERIALIZABLE;
		BEGIN TRAN;
		insert into ##Ex8_2 VALUES (@t, @tn);
		exec @Result6 = Zadanie4 @Name, @t, @Capacity, @NameAud;
		commit tran
	return @Result6;
	end try
begin catch 
    print 'номер ошибки  : ' + cast(error_number() as varchar(6));
    print 'сообщение     : ' + error_message();
    print 'уровень       : ' + cast(error_severity()  as varchar(6));
    print 'метка         : ' + cast(error_state()   as varchar(8));
    print 'номер строки  : ' + cast(error_line()  as varchar(8));
    if error_procedure() is not  null   
                     print 'имя процедуры : ' + error_procedure();
     if @@trancount > 0 rollback tran ; 
     return -1;	  
end catch;

declare @rc int;
exec @rc = PAUDITORIUM_INSERTX @Name = '123-3', @NameAud = '123-3', @Capacity = 123,  @t = 'ЛБ_К',  @tn = 'Лабаратория крутая мб?';
print 'код ошибки=' + cast(@rc as varchar(3));  

select * from ##Ex8
select * from ##Ex8_2