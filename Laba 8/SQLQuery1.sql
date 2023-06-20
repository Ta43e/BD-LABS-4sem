--------
-------����������� ������������� � ������ �������-������. ������������� ������ ���� ��������� �� ������ 
------ SELECT-������� � ������� TEACH-ER � ��������� ��������� �������: ���, ��� �������������, ���, ��� �������. 
go
CREATE OR ALTER VIEW [�������������]
as select TEACHER [���],
		  TEACHER_NAME [��� �������������],
		  GENDER [���],
		  PULPIT [��� �������] FROM TEACHER
go										

SELECT * FROM [�������������]
DROP VIEW [�������������]
---------------------------------����������� � ������� ������������� � ������ ���������� ������. ������������� ������ ���� ��������� �� ������ SELECT-������� � �������� FACULTY � PULPIT.
---------------------������������� ������ ��������� ������-��� �������: ���������, ���������� ������ (����������� �� ������ ����� ������� PULPIT). 
go	
CREATE OR ALTER VIEW [���������� ������]
	AS SELECT f.FACULTY_NAME,
	(select count(*) from PULPIT as p
	where p.FACULTY = f.FACULTY)[���-�� ���������]
	from FACULTY as f
go	
SELECT * FROM [���������� ������]
DROP VIEW [���������� ������]
-----------------------------------------------------����������� � ������� ������������� � ������ ���������. ������������� ������ ���� ��-������� �� ������ ������� AUDITORIUM � ��������� �������: ���, ������������ ����-�����. 
-----------������������� ������ ���������� ������ ���������� ��������� (� ������� AUDITO-RIUM_ TYPE ������, ������������ � �����-�� ��) � ��������� ���������� ��������� IN-SERT, UPDATE � DELETE.
go	
CREATE OR ALTER VIEW [���������]
	AS SELECT AUDITORIUM.AUDITORIUM [���],
			  AUDITORIUM.AUDITORIUM_NAME [��� ���������],
			  AUDITORIUM.AUDITORIUM_TYPE [���]
from AUDITORIUM
WHERE  AUDITORIUM.AUDITORIUM_TYPE LIKE '��%' WITH CHECK OPTION

INSERT ��������� VALUES('789-2', '789-2', '��')
INSERT ��������� VALUES('765-2', '765-2', '��-�')

UPDATE [���������] 
SET [��� ���������] = '�������'
WHERE [���] = '789-2'  ;

DELETE [���������] WHERE [��� ���������] = '�������'
go	
SELECT * FROM [���������]
DROP VIEW [���������]
-------------------------����������� � ������� ������������� � ������ ����������_���������. 
--������������� ������ ���� ��������� �� ������ SELECT-������� � ������� AUDITO-RIUM � ��������� ��������� �������: ���, ������������ ���������. 
---������������� ������ ���������� ������ ���������� ��������� (� ������� AUDITO-RIUM_TYPE ������, ������������ � �����-��� ��). 
go	
CREATE OR ALTER VIEW [����������_���������]
		AS SELECT  AUDITORIUM.AUDITORIUM [���],
			  AUDITORIUM.AUDITORIUM_NAME [��� ���������],
			  AUDITORIUM.AUDITORIUM_TYPE [���]
from AUDITORIUM
WHERE  AUDITORIUM.AUDITORIUM_TYPE LIKE '��%' 
go	
SELECT * FROM [����������_���������]
------------------------����������� ������������� � ������ �����-�����. ������������� ������ ���� ��������� �� ������ SELECT-�������
----� ������� SUB-JECT, ���������� ��� ���������� � �������-��� ������� � ��������� ��������� �������: ���, ������������ ���������� � ��� ��-�����. 
---������������ TOP � ORDER BY.
go	
CREATE OR ALTER VIEW [����������]
	AS SELECT TOP 100 SUBJECT.SUBJECT [���],
	   SUBJECT.SUBJECT_NAME [������������ ����������],
	   SUBJECT.PULPIT [��� �������]
FROM SUBJECT
ORDER BY SUBJECT
go	
SELECT * FROM [����������]
-------------------------�������� ������������� ����������_������, ��������� � ������� 2 ���, ����� ��� ���� ��������� � ������� ��������.
---������������������ �������� ����������-��� ������������� � ������� ��������. 
---������������ ����� SCHEMABINDING. 

ALTER VIEW [���������� ������] WITH SCHEMABINDING
	AS SELECT f.FACULTY_NAME,
	(select count(*) from dbo.PULPIT as p
	where p.FACULTY = f.FACULTY )[���-�� ���������]
	from dbo.FACULTY as f

	SELECT * FROM [���������� ������]

