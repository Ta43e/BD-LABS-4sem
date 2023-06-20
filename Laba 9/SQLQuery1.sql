-- объявление переменных
DECLARE @charVariable char(10) = 'Hello';
DECLARE @varcharVariable varchar(20) = 'World';
DECLARE @datetimeVariable datetime;
DECLARE @timeVariable time;
DECLARE @intVariable int;
DECLARE @smallintVariable smallint;
DECLARE @tinyintVariable tinyint;
DECLARE @numericVariable numeric(12,5);

-- присвоение произвольных значений переменным
SET @datetimeVariable = GETDATE();
SET @timeVariable = CONVERT(time, '12:34:56');
SET @intVariable = 123456;
SET @smallintVariable = 123;
SET @tinyintVariable = 1;
SET @numericVariable = 12345.67890;

-- вывод значений переменных с помощью оператора SELECT
SELECT @charVariable 'Char', @varcharVariable 'VarChar', @datetimeVariable 'dateTime', 
       @timeVariable 'Time', @intVariable 'Int', @smallintVariable 'smallint', 
       @tinyintVariable 'tunyInt', @numericVariable 'numeric';

-- вывод значений переменных с помощью оператора PRINT
PRINT 'charVariable = ' + @charVariable;
PRINT 'varcharVariable = ' + @varcharVariable;
PRINT 'datetimeVariable = ' + CONVERT(varchar, @datetimeVariable);
PRINT 'timeVariable = ' + CONVERT(varchar, @timeVariable);
PRINT 'intVariable = ' + CONVERT(varchar, @intVariable);
PRINT 'smallintVariable = ' + CONVERT(varchar, @smallintVariable);
PRINT 'tinyintVariable = ' + CONVERT(varchar, @tinyintVariable);
PRINT 'numericVariable = ' + CONVERT(varchar, @numericVariable);


----------------------
---- Разработать скрипт, в котором опре-деляется общая вместимость аудито-рий.
----Если общая вместимость превышает 200, то вывести количество аудиторий, среднюю вместимость аудиторий, ко-личество аудиторий,
----вместимость ко-торых меньше средней, и процент та-ких аудиторий. 
----Если общая вместимость аудиторий меньше 200, то вывести сообщение о размере общей вместимости.

DECLARE @sumMesta int = (select CAST(sum(AUDITORIUM_CAPACITY) AS int) from AUDITORIUM);
IF @sumMesta > 200
	BEGIN 
	DECLARE @ColAuditorium int, @avgCapacity numeric(12,5), @ColAuditoriumNew int, @prozent numeric(12,5);
		SELECT @ColAuditorium = (select COUNT(*) from AUDITORIUM);
		SELECT @avgCapacity = (select avg(AUDITORIUM_CAPACITY) FROM AUDITORIUM);
		SELECT @ColAuditoriumNew = (select COUNT(*) from AUDITORIUM where AUDITORIUM_CAPACITY < @ColAuditorium);
		SELECT @prozent = (cast ((@ColAuditoriumNew * 100)/@ColAuditorium as numeric(10,2)));
		SELECT @ColAuditorium [Кол-во аудиторий], @avgCapacity [средняя вместимость],  @ColAuditoriumNew [Аудитории, чья вместимость меньше средней вместительности], @prozent [Процент]

	END
ELSE
	BEGIN
		SELECT @sumMesta [Кол-во челов];
	END
----------------------------
----3.	Разработать T-SQL-скрипт, ко-торый выводит на печать глобальные переменные: 
--- @@ROWCOUNT (число обрабо-танных строк); 
--- @@VERSION (версия SQL Server);
---@@SPID (возвращает системный идентификатор процесса, назначен-ный сервером текущему подключе-нию); 
---@@ERROR (код последней ошиб-ки); 
--- @@SERVERNAME (имя сервера); 
--- @@TRANCOUNT (возвращает уровень вложенности транзакции); 
--- @@FETCH_STATUS (проверка результата считывания строк ре-зультирующего набора); 
--- @@NESTLEVEL (уровень вло-женности текущей процедуры).
---Проанализировать результат.

----
----
print 'Число обработанных строк: ' + cast(@@ROWCOUNT as varchar);
print 'версия SQL Server: ' + cast(@@VERSION as varchar);
print 'Cистемный идентификатор процесса: ' + cast(@@SPID as varchar);
print 'Код последней ошибки: ' + cast(@@ERROR as varchar);
print 'Имя сервера: ' + cast(@@SERVERNAME as varchar);
print 'уровень вложенности транзакции: ' + cast(@@TRANCOUNT as varchar);
print 'результат считывания строк результирующего набора: ' + cast(@@FETCH_STATUS as varchar);
print 'уровень вложенности текущей процедуры: ' + cast(@@NESTLEVEL as varchar);
--------------------------------------------------------
DECLARE @z real, @t real, @x real;
SELECT @t = '2', @x = '10';
IF @t > @x 
	BEGIN 
		SET @z = SIN(@t)* SIN(@t)
		PRINT '@Z = ' + CONVERT(varchar, @z);
	END
ELSE IF @t < @x
	BEGIN 
		SET @z = 4 * (@t + @x);
		PRINT '@Z = ' + CONVERT(varchar, @z);
	END
ELSE 
	BEGIN
		SET @z = 1 - EXP(@x - 2);
		PRINT '@Z = ' + CONVERT(varchar, @z);
	END
	--------------------------------------------------------
	DECLARE @full_name NVARCHAR(100) = 'Макейчик Татьяна Леонидовна'

SELECT 
    CONCAT_WS(' ', 
        LEFT(@full_name, CHARINDEX(' ', @full_name) - 1), 
        LEFT(SUBSTRING(@full_name, CHARINDEX(' ', @full_name) + 1, 1), 1) + '.', 
        LEFT(SUBSTRING(@full_name, CHARINDEX(' ', @full_name, CHARINDEX(' ', @full_name) + 1) + 1, 1), 1) + '.') AS short_name 
	--------------------------------------------------------
	SELECT 
    STUDENT.NAME,
    DATEDIFF(YEAR, STUDENT.BDAY, GETDATE()) AS age
FROM 
    STUDENT
WHERE 
    MONTH(STUDENT.BDAY) = MONTH(DATEADD(MONTH, 1, GETDATE())) 
--------------------------------------------------------
SELECT DATENAME(DW, PROGRESS.PDATE) AS weekday
FROM 
     STUDENT JOIN PROGRESS
	 ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
	 WHERE IDGROUP = 7 AND SUBJECT = 'БД'
GROUP BY   
    DATENAME(DW, PROGRESS.PDATE)
--------------------------------------------------------
DECLARE @A real, @B real;
SELECT @A = '50', @B = (SELECT SUM(AUDITORIUM.AUDITORIUM_CAPACITY) FROM AUDITORIUM);
IF @A > @B
	BEGIN
		PRINT '@A = ' + CONVERT(varchar, @A);
	END
ELSE 
	BEGIN
		PRINT '@B = ' + CONVERT(varchar, @B);
	END
--------------------------------------------------------
SELECT CASE
	   WHEN PROGRESS.NOTE BETWEEN 1 AND 4 THEN 'Не сдал'
	   WHEN PROGRESS.NOTE BETWEEN 4 AND 7 THEN 'Сдал'
	   WHEN PROGRESS.NOTE BETWEEN 7 AND 10 THEN 'Сдал хорошо!'
	   else 'Неопределенный результат'
	   END AS [Результат экзамена],
	   STUDENT.NAME, PROGRESS.SUBJECT, PROGRESS.NOTE
FROM PROGRESS JOIN STUDENT
ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
JOIN GROUPS
ON GROUPS.IDGROUP = STUDENT.IDGROUP
WHERE GROUPS.FACULTY = 'ИТ' AND PROGRESS.SUBJECT = 'КГ'

------------------
---7. Создать временную локальную таблицу из трех столбцов и 10 строк, заполнить 
---ее и вывести содержимое. Использовать оператор WHILE.----
CREATE TABLE #MyTable
( NAME varchar(100),
  LAST_NAME varchar(100),
  AGE int
  );
  INSERT #MyTable 
	VALUES ('OLEG', 'ABOBA', 19),
	 ('Anton', 'ABOBA', 17),
	 ('Chel', 'ABOBA', 12),
	 ('Hleb', 'ABOBA', 21),
	 ('Andrey', 'ABOBA', 18),
	 ('Yan', 'ABOBA', 20),
	 ('Nikita', 'ABOBA', 39),
	('Vlad', 'ABOBA', 29);
DECLARE @Age int
SELECT @Age = 20
SELECT #MyTable.NAME, #MyTable.AGE
	FROM #MyTable
	WHERE #MyTable.AGE > @Age
-------------------------------
--8. Разработать скрипт, демонстриру-ющий 
--использование оператора RETURN
DECLARE @Test int = 0;
WHILE @Test<100
	begin 
		if @Test = 21
			begin
				print 'Конец операции'
				return;
			end	
		print @Test
		SET @Test = @Test + 1;
	end;
----9. Разработать сценарий с ошибками, в котором используются для обработки ошибок блоки TRY и CATCH. 
----Применить функции ER-ROR_NUMBER (код последней ошиб-ки), ERROR_MESSAGE (сообщение об ошибке), ERROR_LINE (номер строки с ошибкой), ERROR_PROCEDURE
----(имя процедуры или NULL), ER-ROR_SEVERITY (уровень серьезности ошибки), ERROR_STATE (метка ошиб-ки). Проанализировать результат.
BEGIN TRY
	DECLARE @Err int;
	SELECT @Err = 1 / 0;
END TRY
BEGIN CATCH
	PRINT ERROR_NUMBER()
	PRINT ERROR_MESSAGE()
	PRINT ERROR_LINE()
	PRINT ERROR_PROCEDURE()
	PRINT ERROR_SEVERITY()
	PRINT ERROR_STATE()
END CATCH
------------------------------