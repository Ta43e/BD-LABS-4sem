set nocount on
	if  exists (select * from  SYS.OBJECTS        -- ������� X ����?
	            where OBJECT_ID= object_id(N'DBO.X') )	            
	drop table X;           
	declare @c int, @flag char = 'c';           -- commit ��� rollback?
	SET IMPLICIT_TRANSACTIONS  ON   -- �����. ����� ������� ����������
	CREATE table X(K int );                         -- ������ ���������� 
		INSERT X values (1),(2),(3);
		set @c = (select count(*) from X);
		print '���������� ����� � ������� X: ' + cast( @c as varchar(2));
		if @flag = 'c'  commit;                   -- ���������� ����������: �������� 
	          else   rollback;                                 -- ���������� ����������: �����  
      SET IMPLICIT_TRANSACTIONS  OFF   -- ������. ����� ������� ����������
	
	if  exists (select * from  SYS.OBJECTS       -- ������� X ����?
	            where OBJECT_ID= object_id(N'DBO.X') )
	print '������� X ����';  
      else print '������� X ���'
-- � ������ ���� � try ���������� �� ���������, ��� �������� � catch, ������ ������ � ���������� ����� ����� rollback
-- �������� ��� �������� ���� �����������

USE UNIVER
DECLARE @trcount int
BEGIN TRY -- ������ ����� try
  BEGIN TRAN -- ������������ � ����� ����� ����������
    DELETE AUDITORIUM_TYPE WHERE AUDITORIUM_TYPENAME = '����� ����������';
    --DELETE AUDITORIUM_TYPE WHERE AUDITORIUM_TYPENAME = '����� ����� ����������';
    INSERT AUDITORIUM_TYPE VALUES ('��-�', '����� ����������');
    INSERT AUDITORIUM_TYPE VALUES ('��-�', '����� ����������');
    INSERT AUDITORIUM_TYPE VALUES ('��-�', '����� ����� ����������');
    COMMIT TRAN;
  END TRY
BEGIN CATCH 
    PRINT '������: ' + case -- PATINDEX ���������� � ������ ������� ������� ������� ���-������, �������� ��������
              WHEN error_number() = 2627 and patindex('%AUDITORIUM_TYPE_PK%', error_message()) > 0 -- 2627 - ������ ���� ����
                THEN '������������ ���� ���������'
               else '����������� ������: ' + cast(error_number() as varchar(5)) + error_message()
               end;
  SET @trcount = @@TRANCOUNT  -- ���������� ������� ����������� ���������� (���� ������ 0 �� ���� �� ���������)
  PRINT @trcount
  IF @@TRANCOUNT > 0 ROLLBACK TRAN;
END CATCH;


-- � ����� ��������� ��� ��� ��� ���� �� ������ (@trancount ����� = 1), �� ���������� ����� � ������� insert �� ������� � ����
-- ����� �� �� ������� �������� ������ ��-�� �����������: ����-� ���-� ������ � ����-� ���� ��� �������-�, ���� ���.

--3. ����������� ��������, ��������������� ���������� ��������� SAVE TRAN �� ������� ���� ������ UNIVER. 
--� ����� CATCH ������������� ������ ��������������� ��������� �� �������. 
--���������� ������ �������� ��� ������������� ��������� ����������� ����� � ��������� ���������� ����������� ������.
	select * 
	into #tmp
	from AUDITORIUM

	--DROP TABLE #tmp
DECLARE @point VARCHAR(32), @i INT = 0;
BEGIN TRY
	BEGIN TRAN
		DELETE #tmp where AUDITORIUM_CAPACITY = 1;
		SET @point = 'P1'; SAVE TRAN @POINT;
		--set @i = @i / 0;
		INSERT #tmp values ('123-3', '��-�', 123, '123-3');
		set @point = 'p2'; save tran @point;
		insert #tmp values ('123-3', '��-�', 123, '123-3');
		commit tran;
	end try
	begin catch
		print '������' + case when error_number() = 2627
								and patindex('%PK_tmp', error_message()) > 0
							then '������������ ���������'
							else '����������� ������:' + cast(error_number() as varchar(5))
								+ error_message()
							end;
	if @@TRANCOUNT > 0
		begin 
			print '����������� �����: ' + @point;
			rollback tran @point;
			commit tran;
		end;
	end catch;

	select * from #tmp

--4. ����������� ��� �������� A � B �� ������� ���� ���-��� UNIVER. 
--�������� A ������������ ����� ����� ���������� � ������� ���������������
--READ UNCOMMITED, �������� B � ����� ���������� � ������� ��������������� READ COMMITED (�� ���������). 
--�������� A ������ ���������������, ��� ������� READ UNCOMMITED ���������
--����������������, ��������������� � ��������� ������. 

	-- A ---
	--DROP table ##tmp
	select * 
	into ##tmp
	from AUDITORIUM

	set transaction isolation level READ UNCOMMITTED 
	begin transaction 
	-------------------------- t1 ------------------
	select @@SPID, 'insert AUDITORIUM' '���������', * from ##tmp;
	select @@SPID, 'update AUDITORIUM_TYPE'  '���������',  AUDITORIUM_TYPE, 
                      AUDITORIUM_TYPENAME from AUDITORIUM_TYPE;
	commit; 
	-------------------------- t2 -----------------
	--- B --	
	begin transaction 
	select @@SPID
	insert ##tmp values ('33-3', '��-�', 76, '87-3'); 
	update AUDITORIUM_TYPE set AUDITORIUM_TYPE  =  '��-�' 
                           where AUDITORIUM_TYPE = '��-�' 
	-------------------------- t1 --------------------
	-------------------------- t2 --------------------
	rollback;
		SELECT  * FROM ##tmp

--	5. ����������� ��� �������� A � B �� ������� ���� ���-��� UNIVER. 
--�������� A � � ������������ ����� ����� ���������� � ������� ��������������� READ COMMITED. 
--�������� A ������ ���������������, ��� ������� READ COMMITED �� ��������� ����������������� ������,
--�� ��� ���� �������� ��������������� � ��������� ������. 
	select * 
	into ##Ex5
	from AUDITORIUM
	DROP TABLE ##Ex5

--	6. ����������� ��� �������� A � B �� ������� ���� ������ UNIVER. 
--�������� A ������������ ����� ����� ���������� � ������� ��������������� REPEATABLE READ.
--�������� B � ����� ���������� � ������� ��������������� READ COMMITED. 
--�������� A ������ ���������������, ��� ������� REAPETABLE READ �� ���������
--����������������� ������ � ���������������� ������, �� ��� ���� �������� ��������� ������. 
	select * 
	into ##Ex6
	from AUDITORIUM
	DROP TABLE ##Ex6
--	7. ����������� ��� �������� A � B �� ������� ���� ������ UNIVER. 
--�������� A ������������ ����� ����� ���������� � ������� ��������������� SERIALIZABLE. 
--�������� B � ����� ���������� � ������� ��������������� READ COMMITED.
--�������� A ������ ��������������� ���������� ���-�������, ����������������� � ���������������� ������.
	select * 
	into ##Ex7
	from AUDITORIUM
	DROP TABLE ##Ex7
--8. ����������� ��������, ��������������� ��������
--��������� ����������, �� ������� ���� ������ UNIVER.

begin tran
	insert AUDITORIUM_TYPE values ('TE--T', '����. ������������ �����')
	begin tran
		INSERT AUDITORIUM VALUES ('33', '��', 12, '985')
		commit
	if @@TRANCOUNT > 0
commit

select (select count(*) from AUDITORIUM where AUDITORIUM_TYPE = '��-�') AUDITORIUM,
	   (select count(*) from AUDITORIUM_TYPE where AUDITORIUM_TYPE = 'TE--T') AUDITORIUM_TYPE;


