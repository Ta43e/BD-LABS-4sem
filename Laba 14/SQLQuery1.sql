use UNIVER
go 
create function COUNT_STUDENTS(@f varchar(30)) returns int 
as begin declare @rc int = 0;
set @rc = (select count(*) 
			FROM FACULTY fac join GROUPS gro
				ON fac.FACULTY = gro.FACULTY 
					JOIN STUDENT
						ON gro.IDGROUP = STUDENT.IDGROUP
							WHERE fac.FACULTY = @f);
return @RC;
END;
--DECLARE @RESULTAT1 INT = dbo.COUNT_STUDENTS('��');
--PRINT @RESULTAT1
--DROP function COUNT_STUDENTS

ALTER FUNCTION COUNT_STUDENTS(@f varchar(30) = NULL, @prof varchar(20) = NULL)
RETURNS int
AS begin declare @rc int = 0;
set @rc = (select count(*) 
			FROM FACULTY fac join GROUPS gro
				ON fac.FACULTY = gro.FACULTY 
					JOIN STUDENT
						ON gro.IDGROUP = STUDENT.IDGROUP
							WHERE fac.FACULTY = @f AND gro.PROFESSION = @prof);
return @RC;
END;
--drop function COUNT_STUDENTS

DECLARE @f int = dbo.COUNT_STUDENTS('��', '1-36 06 01');
print @f;

--2. ����������� ��������� ������� � ������ FSUB-JECTS, ����������� �������� @p ���� varchar(20), �������� �������� ������ ��� ������� (������� SUB-JECT.PULPIT). 
--������� ������ ���������� ������ ���� varchar(300) � �������� ��������� � ������. 

--������� � ��������� ��������, ������� ������� �����, ����������� ��������������� ����. 
--������������ ��������� ����������� ������ �� ������ SELECT-������� � ������� SUBJECT.
 create FUNCTION FSUBJECTS(@p varchar(20)) returns char (300)
 as 
 begin
 declare @kaf char(20);
 declare @str varchar(300) = '�������: ';
 declare MyKaf CURSOR LOCAL
 FOR SELECT SUBJECT.SUBJECT FROM PULPIT join SUBJECT on PULPIT.PULPIT = SUBJECT.PULPIT WHERE PULPIT.PULPIT = @p;
     open MyKaf;	  
     fetch  MyKaf into @kaf;   	 
     while @@fetch_status = 0                                     
		 begin 
			 set @str = @str + ', ' + rtrim(@kaf);         
			 FETCH  MyKaf into @kaf; 
     end;    
     return @str;
 end;  

 drop FUNCTION FSUBJECTS
--SELECT dbo.FSUBJECTS('����')
DECLARE @res varchar(300) = dbo.FSUBJECTS('����');
print @res;
--3. ����������� ��������� ������� FFACPUL, ���������� ������ ������� ������������������ �� ������� ����. 
--������� ��������� ��� ���������, �������� ��� ���������� (������� FACULTY.FACULTY) � ��� ������� (������� PULPIT.PULPIT).
--���������� SELECT-������ c ����� ������� ����������� ����� ��������� FACUL-TY � PULPIT. 
--���� ��� ��������� ������� ����� NULL, �� ��� ���������� ������ ���� ������ �� ���� �����������. 
--���� ����� ������ �������� (������ ����� NULL), ������� ���������� ������ ���� ������ ��������� �-��������. 
--���� ����� ������ �������� (������ ����� NULL), ������� ���������� �������������� �����, �������-��� ������, ��������������� �������� �������.
create function FFACPUL(@Facul varchar(50), @Kod varchar(50))
returns table
as return
select  PULPIT.FACULTY, PULPIT
	from FACULTY LEFT JOIN PULPIT
		ON FACULTY.FACULTY = PULPIT.FACULTY
		WHERE PULPIT.FACULTY = ISNULL(@Facul, PULPIT.FACULTY)
		and PULPIT.PULPIT = ISNULL(@Kod, PULPIT.PULPIT)

   select * from dbo.FFACPUL(NULL, NULL);
   select * from dbo.FFACPUL('��', NULL);
   select * from dbo.FFACPUL(NULL, '��');
   select * from dbo.FFACPUL('���', '����');



--4. �� ������� ���� ������� ��������, ��������������� ������ ��������� ������� FCTEACHER.
--������� ��������� ���� ��������, �������� ��� �������. ������� ���������� ����������
--�������������� �� �������� ���������� �������. ���� �������� ����� NULL,
--�� ������������ ����� ���������� ��������������. 
create function FCTEACHER(@KodKaf varchar(50)) returns int
as 
begin
	declare @rc int = (select COUNT(*) from TEACHER WHERE PULPIT = isnull(@KodKaf, PULPIT));
	return @rc;
end;

drop function FCTEACHER

select PULPIT, DBO.FCTEACHER(PULPIT)
		[���-�� ��������������] from PULPIT
select dbo.FCTEACHER(null) [����� �����]

--����������������
--���������������� ��������� ������� FACULTY_REPORT, �������������� ����:\
--.............--
	create function COLKAF(@F VARCHAR(30)) RETURNS INT
	as 
	begin
	declare @rc int = (select count(PULPIT) from PULPIT WHERE FACULTY = @F)
	RETURN @rc
	end;
--..............--
	create function COLGRUP(@F VARCHAR(30)) RETURNS INT
	as 
	begin
	declare @rc int = (select count(IDGROUP) from GROUPS WHERE FACULTY = @F)
	RETURN @rc
	end;
--..................--
	create function COLPROF(@F VARCHAR(30)) RETURNS INT
	as 
	begin
	declare @rc int = (select count(PROFESSION) from PROFESSION WHERE FACULTY = @F)
	RETURN @rc
	end;


	create function COUNT_STUDENTS_IN(@f varchar(30)) returns int 
	as begin declare @rc int = 0;
	set @rc = (select count(*) 
				FROM FACULTY fac join GROUPS gro
					ON fac.FACULTY = gro.FACULTY 
						JOIN STUDENT
							ON gro.IDGROUP = STUDENT.IDGROUP
								WHERE fac.FACULTY = @f);
	return @RC;
	END;
	--drop function dbo.COLKAF
	--	drop function dbo.COLGRUP
	--	drop function dbo.COLPROF
..................--
 create function FACULTY_REPORT(@c int) returns @fr table
	                        ( [���������] varchar(50), [���������� ������] int, [���������� �����]  int, 
	                                                                 [���������� ���������] int, [���������� ��������������] int )
	as begin 
		   declare cc CURSOR static for 
	       select FACULTY from FACULTY 
           where dbo.COUNT_STUDENTS_IN(FACULTY.FACULTY) > @c; 
	       declare @f varchar(30);
	       open cc;  
           fetch cc into @f;
	       while @@fetch_status = 0

	       begin
	            insert @fr values( @f,  dbo.COLKAF(@f),
	            dbo.COLGRUP(@f),
				dbo.COUNT_STUDENTS_IN(@f),
	            dbo.COLPROF(@f)); 
	            fetch cc into @f;  
	       end;   
        return; 
	end;


DECLARE @C INT = -1
SELECT * FROM dbo.FACULTY_REPORT(@C);

	--drop function FACULTY_REPORT


	--�������� ������� ��������� ������� ����� ������ ���� 6 � �������� � �� ������� (��������� ���������� �������)
	create function OCENKA(@ozenka int) returns  int

	as begin declare @resultO int = (select count(*) from STUDENT JOIN PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT WHERE PROGRESS.NOTE > 6);
	set @resultO = @resultO * cos(radians(@ozenka))
	return @resultO;
	end;


	
	DECLARE @resss int = dbo.OCENKA(100);
	print @resss;