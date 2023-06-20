USE UNIVER
SELECT PULPIT.PULPIT_NAME
FROM PULPIT, FACULTY
WHERE PULPIT.FACULTY = FACULTY.FACULTY  AND
	FACULTY.FACULTY IN (SELECT DISTINCT PROFESSION.FACULTY
	FROM PROFESSION
	WHERE PROFESSION.PROFESSION_NAME Like '%технология%' OR PROFESSION.PROFESSION_NAME LIKE '%технологии%')
-------------------------------------------------------------------------------------------------------------------
SELECT PULPIT.PULPIT_NAME
FROM PULPIT INNER JOIN FACULTY
	ON PULPIT.FACULTY = FACULTY.FACULTY  AND
	FACULTY.FACULTY IN (SELECT DISTINCT PROFESSION.FACULTY
	FROM PROFESSION
	WHERE PROFESSION.PROFESSION_NAME Like '%технология%' OR PROFESSION.PROFESSION_NAME LIKE '%технологии%')
-------------------------------------------------------------------------------------------------------------------
SELECT DISTINCT PULPIT.PULPIT_NAME
FROM PULPIT JOIN FACULTY
	ON PULPIT.FACULTY = FACULTY.FACULTY 
	 JOIN PROFESSION 
		ON  PULPIT.FACULTY = PROFESSION.FACULTY
		 WHERE   PROFESSION.PROFESSION_NAME Like '%технология%' OR PROFESSION.PROFESSION_NAME LIKE '%технологии%'
-------------------------------------------------------------------------------------------------------------------
SELECT DISTINCT AUDITORIUM.AUDITORIUM, AUDITORIUM.AUDITORIUM_TYPE, AUDITORIUM.AUDITORIUM_CAPACITY
	FROM AUDITORIUM
	 WHERE AUDITORIUM.AUDITORIUM_CAPACITY = (SELECT TOP(1) AA.AUDITORIUM_CAPACITY FROM AUDITORIUM AA
		WHERE AA.AUDITORIUM_TYPE = AUDITORIUM.AUDITORIUM_TYPE ORDER BY AA.AUDITORIUM_CAPACITY DESC)

-------------------------------------------------------------------------------------------------------------------
SELECT FACULTY.FACULTY_NAME
	FROM  FACULTY
		WHERE NOT exists  (SELECT * FROM PULPIT WHERE PULPIT.FACULTY = FACULTY.FACULTY)
-------------------------------------------------------------------------------------------------------------------
SELECT TOP 1
	(SELECT AVG(NOTE) FROM PROGRESS
		WHERE SUBJECT LIKE 'ОАиП')[оаИп],
	(SELECT AVG(NOTE) FROM PROGRESS
		WHERE SUBJECT LIKE 'БД')[БД],
	(SELECT AVG(NOTE) FROM PROGRESS
	WHERE SUBJECT LIKE 'СУБД')[СУБД]
FROM PROGRESS
-------------------------------------------------------------------------------------------------------------------
SELECT AUDITORIUM, AUDITORIUM_CAPACITY, AUDITORIUM_TYPE FROM AUDITORIUM
	WHERE AUDITORIUM_CAPACITY >=ALL (SELECT AUDITORIUM_CAPACITY FROM AUDITORIUM WHERE AUDITORIUM_TYPE like '%ЛК%')
-------------------------------------------------------------------------------------------------------------------
SELECT AUDITORIUM, AUDITORIUM_CAPACITY, AUDITORIUM_TYPE FROM AUDITORIUM
	WHERE AUDITORIUM_CAPACITY >=ANY (SELECT AUDITORIUM_CAPACITY FROM AUDITORIUM WHERE AUDITORIUM_TYPE like '%ЛБ%')
-------------------------------------------------------------------------------------------------------------------
SELECT DISTINCT  A.NAME, B.NAME, A.BDAY, B.BDAY
	FROM STUDENT A, STUDENT B
	WHERE A.BDAY = B.BDAY AND A.IDSTUDENT != B.IDSTUDENT
-------------------------------------------------------------------------------------------------------------------