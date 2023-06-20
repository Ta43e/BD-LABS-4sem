-------------------------1-----------------------------
---�� ������ ������ AUDITORIUM_ TYPE � AUDITORIUM ������������ �������� ����� ��������� � ��������������� �� ������������ ����� ���������. 
-------------------------------------------------------
USE  UNIVER;
SELECT AUDITORIUM.AUDITORIUM,AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
	FROM AUDITORIUM_TYPE INNER JOIN AUDITORIUM
	ON AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE
-------------------------2-----------------------------
SELECT AUDITORIUM.AUDITORIUM,AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
	FROM AUDITORIUM_TYPE INNER JOIN AUDITORIUM
	ON AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE AND AUDITORIUM_TYPE.AUDITORIUM_TYPENAME LIKE '%���������%'
------------------------3--------------------------------
SELECT STUDENT.NAME, FACULTY.FACULTY, PULPIT.PULPIT, PROFESSION.PROFESSION_NAME, SUBJECT.SUBJECT_NAME,
	CASE 
		WHEN (PROGRESS.NOTE = 6) THEN '�����'
		WHEN (PROGRESS.NOTE = 7) THEN '����'
		WHEN (PROGRESS.NOTE = 8) THEN '������'
		END [������]
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
--�������������� ����� ������ ��������� ��� �������: ������� � �������������. ���� �� ������� ��� ��������������, �� � ������� ������������� ������ ���� ����-���� ������ ***. 
SELECT  PULPIT.PULPIT_NAME, ISNULL(TEACHER.TEACHER_NAME,'***')[TEACHER_NAME]
	FROM PULPIT LEFT OUTER JOIN TEACHER
	ON PULPIT.PULPIT =TEACHER.PULPIT
------------------------5--------------------------------
--������� ��� ����� �������:
-- ������, ��������� �������� �������� ������ ����� (� �������� FULL OUTER JOIN) ������� � �� �������� ������ ������; 
-- ������, ��������� �������� �������� ������ ������ ������� � �� ���������� ������ �����; 
-- ������, ��������� �������� �������� ������ ������ ������� � ����� ������;



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
--����������� SELECT-������ �� ������ CROSS JOIN-���������� ������ AUDITO-RIUM_TYPE � AUDITORIUM, �������-����� ���������, ����������� ���������� ������� � ������� 1.
USE  UNIVER;
SELECT AUDITORIUM.AUDITORIUM,AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
	FROM AUDITORIUM_TYPE CROSS JOIN AUDITORIUM
	WHERE AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE
----------------------7---------------------------------
USE Kozak_MyBASE
SELECT �����������.��������_�����������, ��������_����������.��������_����������
FROM ����������� FULL OUTER JOIN ��������_����������
ON �����������.��������_����������� = ��������_����������.��������_�����������
WHERE ��������_����������.��������_���������� > '1000'