--------
-------Разработать представление с именем Препода-ватель. Представление должно быть построено на основе 
------ SELECT-запроса к таблице TEACH-ER и содержать следующие столбцы: код, имя преподавателя, пол, код кафедры. 
go
CREATE OR ALTER VIEW [Преподаватель]
as select TEACHER [Код],
		  TEACHER_NAME [имя преподавателя],
		  GENDER [Пол],
		  PULPIT [код кафедры] FROM TEACHER
go										

SELECT * FROM [Преподаватель]
DROP VIEW [Преподаватель]
---------------------------------Разработать и создать представление с именем Количество кафедр. Представление должно быть построено на основе SELECT-запроса к таблицам FACULTY и PULPIT.
---------------------Представление должно содержать следую-щие столбцы: факультет, количество кафедр (вычисляется на основе строк таблицы PULPIT). 
go	
CREATE OR ALTER VIEW [Количество кафедр]
	AS SELECT f.FACULTY_NAME,
	(select count(*) from PULPIT as p
	where p.FACULTY = f.FACULTY)[кол-во аудиторий]
	from FACULTY as f
go	
SELECT * FROM [Количество кафедр]
DROP VIEW [Количество кафедр]
-----------------------------------------------------Разработать и создать представление с именем Аудитории. Представление должно быть по-строено на основе таблицы AUDITORIUM и содержать столбцы: код, наименование ауди-тории. 
-----------Представление должно отображать только лекционные аудитории (в столбце AUDITO-RIUM_ TYPE строка, начинающаяся с симво-ла ЛК) и допускать выполнение оператора IN-SERT, UPDATE и DELETE.
go	
CREATE OR ALTER VIEW [Аудитории]
	AS SELECT AUDITORIUM.AUDITORIUM [Код],
			  AUDITORIUM.AUDITORIUM_NAME [Имя аудитории],
			  AUDITORIUM.AUDITORIUM_TYPE [тип]
from AUDITORIUM
WHERE  AUDITORIUM.AUDITORIUM_TYPE LIKE 'ЛК%' WITH CHECK OPTION

INSERT Аудитории VALUES('789-2', '789-2', 'ЛК')
INSERT Аудитории VALUES('765-2', '765-2', 'ЛБ-К')

UPDATE [Аудитории] 
SET [Имя аудитории] = 'Ввыфпыа'
WHERE [Код] = '789-2'  ;

DELETE [Аудитории] WHERE [Имя аудитории] = 'Ввыфпыа'
go	
SELECT * FROM [Аудитории]
DROP VIEW [Аудитории]
-------------------------Разработать и создать представление с именем Лекционные_аудитории. 
--Представление должно быть построено на основе SELECT-запроса к таблице AUDITO-RIUM и содержать следующие столбцы: код, наименование аудитории. 
---Представление должно отображать только лекционные аудитории (в столбце AUDITO-RIUM_TYPE строка, начинающаяся с симво-лов ЛК). 
go	
CREATE OR ALTER VIEW [Лекционные_аудитории]
		AS SELECT  AUDITORIUM.AUDITORIUM [Код],
			  AUDITORIUM.AUDITORIUM_NAME [Имя аудитории],
			  AUDITORIUM.AUDITORIUM_TYPE [тип]
from AUDITORIUM
WHERE  AUDITORIUM.AUDITORIUM_TYPE LIKE 'ЛК%' 
go	
SELECT * FROM [Лекционные_аудитории]
------------------------Разработать представление с именем Дисци-плины. Представление должно быть построено на основе SELECT-запроса
----к таблице SUB-JECT, отображать все дисциплины в алфавит-ном порядке и содержать следующие столбцы: код, наименование дисциплины и код ка-федры. 
---Использовать TOP и ORDER BY.
go	
CREATE OR ALTER VIEW [Дисциплины]
	AS SELECT TOP 100 SUBJECT.SUBJECT [код],
	   SUBJECT.SUBJECT_NAME [наименование дисциплины],
	   SUBJECT.PULPIT [код кафедры]
FROM SUBJECT
ORDER BY SUBJECT
go	
SELECT * FROM [Дисциплины]
-------------------------Изменить представление Количество_кафедр, созданное в задании 2 так, чтобы оно было привязано к базовым таблицам.
---Продемонстрировать свойство привязанно-сти представления к базовым таблицам. 
---Использовать опцию SCHEMABINDING. 

ALTER VIEW [Количество кафедр] WITH SCHEMABINDING
	AS SELECT f.FACULTY_NAME,
	(select count(*) from dbo.PULPIT as p
	where p.FACULTY = f.FACULTY )[кол-во аудиторий]
	from dbo.FACULTY as f

	SELECT * FROM [Количество кафедр]

