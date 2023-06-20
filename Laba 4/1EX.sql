-------------------------1-----------------------------
---На основе таблиц AUDITORIUM_ TYPE и AUDITORIUM сформировать перечень кодов аудиторий и соответствующих им наименований типов аудиторий. 
-------------------------------------------------------
USE  UNIVER;
SELECT AUDITORIUM.AUDITORIUM,AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
	FROM AUDITORIUM_TYPE INNER JOIN AUDITORIUM
	ON AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE
-------------------------2-----------------------------
SELECT AUDITORIUM.AUDITORIUM,AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
	FROM AUDITORIUM_TYPE INNER JOIN AUDITORIUM
	ON AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE AND AUDITORIUM_TYPE.AUDITORIUM_TYPENAME LIKE '%компьютер%'
------------------------3--------------------------------
SELECT STUDENT.NAME, FACULTY.FACULTY, PULPIT.PULPIT, PROFESSION.PROFESSION_NAME, SUBJECT.SUBJECT_NAME,
	CASE 
		WHEN (PROGRESS.NOTE = 6) THEN 'шесть'
		WHEN (PROGRESS.NOTE = 7) THEN 'семь'
		WHEN (PROGRESS.NOTE = 8) THEN 'восемь'
		END [Оценка]
from PROGRESS
          join STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
          join SUBJECT on SUBJECT.SUBJECT = PROGRESS.SUBJECT
          join GROUPS on GROUPS.IDGROUP = STUDENT.IDGROUP
          join PROFESSION on PROFESSION.PROFESSION = GROUPS.PROFESSION
          join PULPIT on PULPIT.PULPIT = SUBJECT.PULPIT
          join FACULTY on FACULTY.FACULTY = PULPIT.FACULTY
where PROGRESS.NOTE BETWEEN 6 AND 8
order by PROGRESS.NOTE DESC
------------------------4--------------------------------
--Результирующий набор должен содержать два столбца: Кафедра и Преподаватель. Если на кафедре нет преподавателей, то в столбце Преподаватель должна быть выве-дена строка ***. 
SELECT  PULPIT.PULPIT_NAME, ISNULL(TEACHER.TEACHER_NAME,'***')[TEACHER_NAME]
	FROM PULPIT LEFT OUTER JOIN TEACHER
	ON PULPIT.PULPIT =TEACHER.PULPIT
------------------------5--------------------------------
--Создать три новых запроса:
-- запрос, результат которого содержит данные левой (в операции FULL OUTER JOIN) таблицы и не содержит данные правой; 
-- запрос, результат которого содержит данные правой таблицы и не содержащие данные левой; 
-- запрос, результат которого содержит данные правой таблицы и левой таблиц;



SELECT PULPIT.PULPIT, TEACHER.TEACHER_NAME
FROM PULPIT FULL OUTER JOIN TEACHER
	ON PULPIT.PULPIT =TEACHER.PULPIT
	WHERE TEACHER.TEACHER IS NOT NULL

SELECT PULPIT.PULPIT, TEACHER.TEACHER_NAME
	FROM PULPIT FULL OUTER JOIN TEACHER
	ON PULPIT.PULPIT =TEACHER.PULPIT
	WHERE TEACHER.TEACHER IS NULL
	
SELECT * FROM 
	PULPIT FULL OUTER JOIN TEACHER
	ON PULPIT.PULPIT =TEACHER.PULPIT
----------------------6---------------------------------
--Разработать SELECT-запрос на основе CROSS JOIN-соединения таблиц AUDITO-RIUM_TYPE и AUDITORIUM, формиру-ющего результат, аналогичный результату запроса в задании 1.
USE  UNIVER;
SELECT AUDITORIUM.AUDITORIUM,AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
	FROM AUDITORIUM_TYPE CROSS JOIN AUDITORIUM
	WHERE AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE
----------------------7---------------------------------
USE Kozak_MyBASE
SELECT ПРЕДПРИЯТИЕ.название_предприятия, ЗНАЧЕНИЕ_ПОКАЗАТЕЛЯ.название_показателя
FROM ПРЕДПРИЯТИЕ FULL OUTER JOIN ЗНАЧЕНИЕ_ПОКАЗАТЕЛЯ
ON ПРЕДПРИЯТИЕ.название_предприятия = ЗНАЧЕНИЕ_ПОКАЗАТЕЛЯ.название_предприятия
WHERE ЗНАЧЕНИЕ_ПОКАЗАТЕЛЯ.название_показателя > '1000'