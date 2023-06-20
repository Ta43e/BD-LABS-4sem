-- ���������� ����������
DECLARE @charVariable char(10) = 'Hello';
DECLARE @varcharVariable varchar(20) = 'World';
DECLARE @datetimeVariable datetime;
DECLARE @timeVariable time;
DECLARE @intVariable int;
DECLARE @smallintVariable smallint;
DECLARE @tinyintVariable tinyint;
DECLARE @numericVariable numeric(12,5);

-- ���������� ������������ �������� ����������
SET @datetimeVariable = GETDATE();
SET @timeVariable = CONVERT(time, '12:34:56');
SET @intVariable = 123456;
SET @smallintVariable = 123;
SET @tinyintVariable = 1;
SET @numericVariable = 12345.67890;

-- ����� �������� ���������� � ������� ��������� SELECT
SELECT @charVariable 'Char', @varcharVariable 'VarChar', @datetimeVariable 'dateTime', 
       @timeVariable 'Time', @intVariable 'Int', @smallintVariable 'smallint', 
       @tinyintVariable 'tunyInt', @numericVariable 'numeric';

-- ����� �������� ���������� � ������� ��������� PRINT
PRINT 'charVariable = ' + @charVariable;
PRINT 'varcharVariable = ' + @varcharVariable;
PRINT 'datetimeVariable = ' + CONVERT(varchar, @datetimeVariable);
PRINT 'timeVariable = ' + CONVERT(varchar, @timeVariable);
PRINT 'intVariable = ' + CONVERT(varchar, @intVariable);
PRINT 'smallintVariable = ' + CONVERT(varchar, @smallintVariable);
PRINT 'tinyintVariable = ' + CONVERT(varchar, @tinyintVariable);
PRINT 'numericVariable = ' + CONVERT(varchar, @numericVariable);


----------------------
---- ����������� ������, � ������� ����-�������� ����� ����������� ������-���.
----���� ����� ����������� ��������� 200, �� ������� ���������� ���������, ������� ����������� ���������, ��-�������� ���������,
----����������� ��-����� ������ �������, � ������� ��-��� ���������. 
----���� ����� ����������� ��������� ������ 200, �� ������� ��������� � ������� ����� �����������.

DECLARE @sumMesta int = (select CAST(sum(AUDITORIUM_CAPACITY) AS int) from AUDITORIUM);
IF @sumMesta > 200
	BEGIN 
	DECLARE @ColAuditorium int, @avgCapacity numeric(12,5), @ColAuditoriumNew int, @prozent numeric(12,5);
		SELECT @ColAuditorium = (select COUNT(*) from AUDITORIUM);
		SELECT @avgCapacity = (select avg(AUDITORIUM_CAPACITY) FROM AUDITORIUM);
		SELECT @ColAuditoriumNew = (select COUNT(*) from AUDITORIUM where AUDITORIUM_CAPACITY < @ColAuditorium);
		SELECT @prozent = (cast ((@ColAuditoriumNew * 100)/@ColAuditorium as numeric(10,2)));
		SELECT @ColAuditorium [���-�� ���������], @avgCapacity [������� �����������],  @ColAuditoriumNew [���������, ��� ����������� ������ ������� ���������������], @prozent [�������]

	END
ELSE
	BEGIN
		SELECT @sumMesta [���-�� �����];
	END
----------------------------
----3.	����������� T-SQL-������, ��-����� ������� �� ������ ���������� ����������: 
--- @@ROWCOUNT (����� ������-������ �����); 
--- @@VERSION (������ SQL Server);
---@@SPID (���������� ��������� ������������� ��������, ��������-��� �������� �������� ��������-���); 
---@@ERROR (��� ��������� ����-��); 
--- @@SERVERNAME (��� �������); 
--- @@TRANCOUNT (���������� ������� ����������� ����������); 
--- @@FETCH_STATUS (�������� ���������� ���������� ����� ��-������������� ������); 
--- @@NESTLEVEL (������� ���-�������� ������� ���������).
---���������������� ���������.

----
----
print '����� ������������ �����: ' + cast(@@ROWCOUNT as varchar);
print '������ SQL Server: ' + cast(@@VERSION as varchar);
print 'C�������� ������������� ��������: ' + cast(@@SPID as varchar);
print '��� ��������� ������: ' + cast(@@ERROR as varchar);
print '��� �������: ' + cast(@@SERVERNAME as varchar);
print '������� ����������� ����������: ' + cast(@@TRANCOUNT as varchar);
print '��������� ���������� ����� ��������������� ������: ' + cast(@@FETCH_STATUS as varchar);
print '������� ����������� ������� ���������: ' + cast(@@NESTLEVEL as varchar);
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
	DECLARE @full_name NVARCHAR(100) = '�������� ������� ����������'

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
	 WHERE IDGROUP = 7 AND SUBJECT = '��'
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
	   WHEN PROGRESS.NOTE BETWEEN 1 AND 4 THEN '�� ����'
	   WHEN PROGRESS.NOTE BETWEEN 4 AND 7 THEN '����'
	   WHEN PROGRESS.NOTE BETWEEN 7 AND 10 THEN '���� ������!'
	   else '�������������� ���������'
	   END AS [��������� ��������],
	   STUDENT.NAME, PROGRESS.SUBJECT, PROGRESS.NOTE
FROM PROGRESS JOIN STUDENT
ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
JOIN GROUPS
ON GROUPS.IDGROUP = STUDENT.IDGROUP
WHERE GROUPS.FACULTY = '��' AND PROGRESS.SUBJECT = '��'

------------------
---7. ������� ��������� ��������� ������� �� ���� �������� � 10 �����, ��������� 
---�� � ������� ����������. ������������ �������� WHILE.----
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
--8. ����������� ������, �����������-���� 
--������������� ��������� RETURN
DECLARE @Test int = 0;
WHILE @Test<100
	begin 
		if @Test = 21
			begin
				print '����� ��������'
				return;
			end	
		print @Test
		SET @Test = @Test + 1;
	end;
----9. ����������� �������� � ��������, � ������� ������������ ��� ��������� ������ ����� TRY � CATCH. 
----��������� ������� ER-ROR_NUMBER (��� ��������� ����-��), ERROR_MESSAGE (��������� �� ������), ERROR_LINE (����� ������ � �������), ERROR_PROCEDURE
----(��� ��������� ��� NULL), ER-ROR_SEVERITY (������� ����������� ������), ERROR_STATE (����� ����-��). ���������������� ���������.
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