select *
into ##Ex4
FROM AUDITORIUM
select *
into ##Ex6
FROM SUBJECT
-- 1. ����������� �������� ��������� ��� ����-������ �
--������ PSUBJECT.

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

----2. ����� ��������� PSUBJECT � ������� ������������
--�������� (Object Explorer) � ����� ����������� ���� �������
--�������� �� ��������� ���-������ ���������� ALTER.
----�������� ��������� PSUBJECT, ��������� � ������� 1,
--����� �������, ����� ��� ��������� ��� ��������� � ������� @p � @c.
--�������� @p �������� �������, ����� ��� varchar(20)
--� �������� �� ��������� NULL. �������� @� �������� ��-������, ����� ��� INT.
----��������� PSUBJECT ������ ����������� ��������������
--�����, ����������� ������, ��������������� �� ������� ����,
--�� ��� ���� ��������� ������, ��������������� ���� �������,
--��-������� ���������� @p. ����� ����, ��������� ������ �����������
--�������� ��������� ��������� @�, ������ ���������� ����� �
--�������������� ������, � ����� ���������� �������� � ����� ������,
--������ ������ ���������� ��������� (���������� ����� � ������� SUBJECT).\
GO
alter procedure PSUBJECT @p varchar(20), @c int output
as begin
	DECLARE @K INT = (SELECT COUNT(*) FROM SUBJECT);
	SELECT * FROM SUBJECT WHERE SUBJECT = @p
	SET @c = @@ROWCOUNT;
	RETURN @K;
	END;

DECLARE @s varchar(20) = '��', @l int = 0, @O int = 0;
exec @l = PSUBJECT @s, @c = @O output;
print '���-�� ����� ' + cast(@l as varchar(3));
print '���-�� ������������ ' + cast (@O as varchar(10))


SELECT * FROM TEACHER

GO 
CREATE procedure SUCHE @p varchar(20) 
AS BEGIN 
declare @K int = (SELECT COUNT(*) FROM TEACHER WHERE TEACHER LIKE '%' + @p + '%')
return @K
END;

--DROP procedure SUCHE

DECLARE @result INT
DECLARE @STR VARCHAR(20) = '�'
EXEC @result = SUCHE @p = @STR
SELECT @result
--3. ������� ��������� ��������� ������� � ���-��� #SUBJECT. ������������ � ��� ��������
--������� ������ ��������������� �������� ��������������� ������ ��������� PSUBJECT, ������������� � ������� 2. 
--�������� ��������� PSUBJECT ����� �������, ����� ��� �� ��������� ��������� ���������.
--�������� ����������� INSER EXECUTE � ���������������� ���������� PSUBJECT, �������� ������ � ������� #SUBJECT.
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

 INSERT #ex6 EXEC PSUBJECT @pVal = '��'
 INSERT #ex6 EXEC PSUBJECT @pVal = '��'

 SELECT * FROM #ex6
-- 4. ����������� ��������� � ������ PAUDITO-RIUM_INSERT.
--��������� ��������� ������ ������� ���������: @a, @n, @c � @t.
--�������� @a ����� ��� CHAR(20), �������� @n ����� ��� VARCHAR(50),
--�������� @c ����� ��� INT � ���-����� �� ��������� 0, �������� @t ����� ��� CHAR(10).
--��������� ��������� ������ � ������� AUDI-TORIUM. ��������
--�������� AUDITORIUM, AU-DITORIUM_NAME, AUDITORIUM_CAPACITY �
--AUDITORIUM_TYPE ����������� ������ ������-�� ��������������
--����������� @a, @n, @c � @t.
--��������� PAUDITORIUM_INSERT ������ ��������� �������� TRY/CATCH ���
--��������� ������. � ������ ������������� ������, �������-�� ������
--����������� ���������, ���������� ��� ������, ������� ����������� � 
--����� ��������� � ����������� �������� �����. 
--��������� ������ ���������� � ����� ������ �������� -1 �
--��� ������, ���� ��������� ������ � 1, ���� ���������� �������. 
--���������� ������ ��������� � ���������� ���������� �������� ������.
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
	print '����� ������: ' + cast(error_number()as varchar(6));
	print '���������: ' + error_message();
	print '����� ������: ' + cast(error_line() as varchar(8));
	if ERROR_PROCEDURE() is not null
	print '���������: ' + error_procedure();
	return -1;

end catch

DROP procedure Zadanie4

declare @rc int
exec @rc = Zadanie4 @Aud = '544-2', @Type = '��-�', @Capacity = 123, @Name = '544-2'
print '��� ������: ' + cast(@rc as varchar(3));
select * from ##Ex4
--5 ����������� ��������� � ������ SUB-JECT_REPORT, ����������� � �����������
--�������� ����� ����� �� ������� ��������� �� ���������� �������. � ����� ������
--���� ������-�� ������� �������� (���� SUBJECT) �� ������� SUBJECT � ���� ������
--����� ������� (��������-���� ���������� ������� RTRIM). ��������� ���-�� �������
--�������� � ������ @p ���� CHAR(10), ������� ������������ ��� �������� ���� �������.
--� ��� ������, ���� �� ��������� �������� @p ���������� ���������� ��� �������,
--��������� ������ ������������ ������ � ���������� ����-�� � ����������. 
--��������� SUBJECT_REPORT ������ ���-������� � ����� ������ ���������� ���������, ������������ � ������. 
go
create procedure SUBJECT_REPORT @p char(20)
as 
declare @r� int = 0;
begin try
	declare @Cafedra CHAR(20), @str CHAR(300) ='';
	declare SUBJECT_KURSOR CURSOR FOR
	SELECT SUBJECT_NAME FROM ##Ex6 where SUBJECT = @p;
	open SUBJECT_KURSOR;	  
	fetch  SUBJECT_KURSOR into @Cafedra;   
	print   '���� �� �������';   
	while @@fetch_status = 0                                     
		begin 
				set @str = rtrim(@Cafedra) + ',' + @str;  
				set @r� = @r� + 1;       
				fetch  ZkTov into @Cafedra; 

		end;   
print @str;
close SUBJECT_KURSOR;
return @r�;
end try
   begin catch              
        print '������ � ����������' 
        if error_procedure() is not null   
		print '��� ��������� : ' + error_procedure();
        return @r�;
   end catch; 

   --drop procedure SUBJECT_REPORT


   declare @r� int;
   exec @r� = SUBJECT_REPORT @p = '���';
   print '���������� ������� = ' + cast(@r� as varchar(3)); 
	
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
    print '����� ������  : ' + cast(error_number() as varchar(6));
    print '���������     : ' + error_message();
    print '�������       : ' + cast(error_severity()  as varchar(6));
    print '�����         : ' + cast(error_state()   as varchar(8));
    print '����� ������  : ' + cast(error_line()  as varchar(8));
    if error_procedure() is not  null   
                     print '��� ��������� : ' + error_procedure();
     if @@trancount > 0 rollback tran ; 
     return -1;	  
end catch;

declare @rc int;
exec @rc = PAUDITORIUM_INSERTX @Name = '123-3', @NameAud = '123-3', @Capacity = 123,  @t = '��_�',  @tn = '����������� ������ ��?';
print '��� ������=' + cast(@rc as varchar(3));  

select * from ##Ex8
select * from ##Ex8_2