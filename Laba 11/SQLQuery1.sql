--1. Разработать сценарий, форми-рующий список дисциплин на кафед-ре ИСиТ.
--В отчет должны быть вы-ведены краткие названия дисциплин из таблицы SUBJECT в одну строку через запятую. 
--Использовать встроенную функцию RTRIM.
DECLARE @tv char(20), @t char(300)='';
DECLARE ZkTovar CURSOR
				FOR SELECT SUBJECT FROM SUBJECT
WHERE PULPIT='ИСиТ'
OPEN ZkTovar
FETCH ZkTovar into @tv;
print 'Дисциплины:'
	WHILE @@FETCH_STATUS=0
		BEGIN
			SET @t = RTRIM(@tv) + ',' + @t;
			FETCH ZkTovar into @tv;
		end;
	print @t;
close ZkTovar;
--2. Разработать сценарий, демонстрирующий отличие глобального курсора
--от локального на примере базы данных UNIVER.
DECLARE MyCursorLoc CURSOR  global -- local
	FOR SELECT PROFESSION, YEAR_FIRST FROM GROUPS;
DECLARE @EX2 CHAR(20), @MyDATA smallint;
	OPEN MyCursorLoc;
		FETCH MyCursorLoc INTO @EX2, @MyDATA;
		PRINT('1:' + @EX2 + cast(@MyDATA as varchar(12)));
		GO
DECLARE @EX2 CHAR(20), @MyDATA smallint;
	FETCH MyCursorLoc INTO @EX2, @MyDATA;
	PRINT ('2:' + @EX2 + cast(@MyDATA as varchar(12)));
	DEALLOCATE MyCursorLoc
	GO
close MyCursorLoc;
--3. Разработать сценарий, демон-стрирующий отличие статических курсоров
--от динамических на приме-ре базы данных UNIVER.\

	select * 
	into #tmp
	from AUDITORIUM

	select * from #tmp
	--DROP TABLE #tmp

DECLARE @AUD CHAR(20), @AUD_CAP INT, @AUD_NAME VARCHAR(50);
DECLARE Rezult CURSOR LOCAL 
	FOR SELECT AUDITORIUM, AUDITORIUM_CAPACITY, AUDITORIUM_NAME FROM #tmp
	WHERE AUDITORIUM_CAPACITY > 0
	OPEN Rezult;
	UPDATE #tmp SET AUDITORIUM_NAME = 'Кринж' WHERE AUDITORIUM_CAPACITY = 1;
	DELETE #tmp WHERE AUDITORIUM_CAPACITY = 13;
	PRINT 'Кол-во строк: ' + cast(@@CURSOR_ROWS AS VARCHAR(5));
	FETCH Rezult INTO @AUD, @AUD_CAP, @AUD_NAME;
	WHILE @@fetch_status = 0                                    
		begin 
			print @AUD+ ' ' + CAST(@AUD_CAP AS VARCHAR(10)) + ' ' +  @AUD_NAME;
			FETCH Rezult INTO  @AUD, @AUD_CAP, @AUD_NAME;
		end;
CLOSE Rezult;
--4. Разработать сценарий, демон-стрирующий свойства навигации в
--результирующем наборе курсора с атрибутом SCROLL на примере базы данных UNIVER.
--Использовать все известные ключевые слова в операторе FETCH.
	select * 
	into #tmp4
	from TEACHER



DECLARE  @tc int, @rn char(50);  
         DECLARE Ex5 cursor local dynamic SCROLL                               
               for SELECT row_number() over (order by Gender) N,
				TEACHER_NAME FROM dbo.#tmp4 
	OPEN Ex5;
	FETCH  Ex5 into  @tc, @rn;                 
	print 'следующая строка						: ' + cast(@tc as varchar(3))+ rtrim(@rn);      
		FETCH  LAST from  Ex5 into @tc, @rn;       
	print 'последняя строка						: ' +  cast(@tc as varchar(3))+ rtrim(@rn);
		FETCH  NEXT from  Ex5 into @tc, @rn;       
	print 'СЛЕДУЮЩАЯ строка						: ' +  cast(@tc as varchar(3))+ rtrim(@rn);  
		FETCH  PRIOR from  Ex5 into @tc, @rn;       
	print 'предыдущая строка						: ' +  cast(@tc as varchar(3))+ rtrim(@rn);  
		FETCH  ABSOLUTE 3 from  Ex5 into @tc, @rn;       
	print 'третья строка от начала					: ' +  cast(@tc as varchar(3))+ rtrim(@rn);  
		FETCH  ABSOLUTE -3 from  Ex5 into @tc, @rn;       
	print 'третья строка от конца),				: ' +  cast(@tc as varchar(3))+ rtrim(@rn);  
	FETCH RELATIVE  5 from  Ex5 into @tc, @rn;       
	print 'пятая строка вперед от текущей		    : ' +  cast(@tc as varchar(3))+ rtrim(@rn);  
	FETCH  RELATIVE  -5 from  Ex5 into @tc, @rn;       
	print 'пятая строка назад от текущей           : ' +  cast(@tc as varchar(3))+ rtrim(@rn);  

      CLOSE Ex5;

--5. Создать курсор, демонстрирующий применение конструкции 
--CURRENT OF в секции WHERE с использованием операторов UPDATE и DELETE.
 SELECT *
 INTO #ex5
 FROM TEACHER

--DROP TABLE #ex5

 DECLARE @TN CHAR(40);
 DECLARE EX5 CURSOR LOCAL DYNAMIC
	FOR SELECT TEACHER_NAME FROM #ex5 FOR UPDATE
	OPEN EX5;
	FETCH EX5 INTO @TN;
	DELETE #ex5 WHERE CURRENT OF EX5;
	fetch EX5 into @TN;

	print @TN;
		WHILE @@fetch_status = 0                                    
		begin 
			UPDATE #ex5 SET TEACHER_NAME = CONCAT(TEACHER_NAME, '_NEW')
									WHERE CURRENT OF EX5;
			FETCH EX5 INTO @TN;
			print @TN;

		end;
CLOSE EX5;
--6. Разработать SELECT-запрос, с помощью которого из таблицы PROGRESS удаляются строки,
--со-держащие информацию о студентах, получивших оценки ниже 4
--(исполь-зовать объединение таблиц PROGRESS, STUDENT, GROUPS).
--Разработать SELECT-запрос, с по-мощью которого в таблице PRO-GRESS для студента с конкретным номером
--IDSTUDENT корректирует-ся оценка (увеличивается на едини-цу).
 SELECT PROGRESS.IDSTUDENT AS ID, NAME, NOTE
 INTO #ex6
 FROM PROGRESS JOIN STUDENT
 ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
 JOIN GROUPS ON GROUPS.IDGROUP = STUDENT.IDGROUP
 
-- DROP TABLE #ex6

DECLARE @ID_STUD INT, @NAMESTUD NVARCHAR, @NOTE INT;
DECLARE student_cursor CURSOR FOR 
SELECT *
FROM #ex6 WHERE #ex6.NOTE < 4;

OPEN student_cursor;

FETCH FROM student_cursor INTO @ID_STUD, @NAMESTUD, @NOTE;

WHILE @@FETCH_STATUS = 0
	BEGIN
		DELETE FROM #ex6 WHERE #ex6.ID = @ID_STUD;
		FETCH FROM student_cursor INTO @ID_STUD, @NAMESTUD, @NOTE;
	END
CLOSE student_cursor;
DEALLOCATE student_cursor;

SELECT *
FROM #ex6






	