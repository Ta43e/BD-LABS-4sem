use univer

--���� ����������� 10 � �������� ������ ��������� ������� 


create table TR_AUDIT
(
	ID int identity,
	STMT VARCHAR(20)
		CHECK (STMT IN ('INS','DEL','UPD')),
	TRNAME VARCHAR(50),
	CC VARCHAR(300)
)

CREATE TRIGGER TR_TEACHER_INS 
				ON TEACHER AFTER INSERT 
AS DECLARE @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
print '�������� �������';
set @a1 = (select [TEACHER] from inserted);
set @a2 = (select [TEACHER_NAME] from inserted);
set @a3 = (select [GENDER] from inserted);
set @a4 = (select [PULPIT] from inserted);
set @in = @a1 + ' ' + @a2 + ' ' + @a3 + ' ' + @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) VALUES ('INS', 'TR_TEACHER_INS', @in);
return;


DROP TRIGGER TR_TEACHER_INS 

insert INTO TEACHER(TEACHER, TEACHER_NAME, GENDER, PULPIT) VALUES ('5T', 'kOZAK Olef', '�', '����')

select * from TR_AUDIT

--������� AFTER-������� � ������ TR_TEACHER_DEL ��� ������� TEA-CHER, ����������� �� ������� DELETE. ������� ������ ���������� ������
--������ � ������� TR_AUDIT ��� ������ ��������� ������. � ������� �� ���������� �������� ������� TEACHER ��������� ������. 
alter TRIGGER TR_TEACHER_DEL 
							ON TEACHER AFTER DELETE
AS DECLARE @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
print '�������� ��������';
set @a1 = (select [TEACHER] from deleted);
set @a2 = (select [TEACHER_NAME] from deleted);
set @a3 = (select [GENDER] from deleted);
set @a4 = (select [PULPIT] from deleted);
set @in = @a1 + ' ' + @a2 + ' ' + @a3 + ' ' + @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) VALUES ('DEL', 'TR_TEACHER_INS', @in);
return;

 

insert INTO TEACHER(TEACHER, TEACHER_NAME, GENDER, PULPIT) VALUES ('SS', 'kOZAK Olef', '�', '����');
 DELETE FROM TEACHER WHERE TEACHER = 'SS'
 select * from TR_AUDIT
 --������� AFTER-������� � ������ TR_TEACHER_UPD ��� ������� TEA-CHER, ����������� �� ������� 
 --UPDATE. ������� ������ ���������� ������ ������ � ������� TR_AUDIT ��� ������ ���������� ������.
 --� ������� �� ���������� �������� �������� ���������� ������ �� � ����� ��-�������.
 CREATE TRIGGER TR_TEACHER_UPD 
							ON TEACHER AFTER UPDATE
AS DECLARE @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
print '�������� ����������';
set @a1 = (select [TEACHER] from inserted);
set @a2 = (select [TEACHER_NAME] from inserted);
set @a3 = (select [GENDER] from inserted);
set @a4 = (select [PULPIT] from inserted);
set @in = @a1 + ' ' + @a2 + ' ' + @a3 + ' ' + @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) VALUES ('UPD', 'TR_TEACHER_UPD', @in);
return;

DROP TRIGGER TR_TEACHER_UPD 

 UPDATE TEACHER SET TEACHER_NAME = 'oLEGnEW' WHERE TEACHER = 'WW'
 select * from TR_AUDIT
-- 4. ������� AFTER-������� � ������ TR_TEACHER ��� ������� TEACHER, ����������� �� ������� INSERT, DE-LETE, UPDATE. 
--������� ������ ���������� ������ ������ � ������� TR_AUDIT ��� ������ �������-��� ������. � ���� �������� ���������� ��-�����, ���������������� ������� � ����-����� � ������� �� ��������������� ����-��� ����������. 
--����������� ��������, ��������������� ����������������� ��������. 
create trigger TR_TEACHER on TEACHER after INSERT, DELETE, UPDATE
AS DECLARE @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
DECLARE @INS INT = (SELECT COUNT(*) FROM inserted),	
		@DEL INT = (SELECT COUNT(*) FROM deleted);
IF @INS > 0 AND @DEL = 0 
BEGIN 
	print '�������� �������';
set @a1 = (select [TEACHER] from inserted);
set @a2 = (select [TEACHER_NAME] from inserted);
set @a3 = (select [GENDER] from inserted);
set @a4 = (select [PULPIT] from inserted);
set @in = @a1 + ' ' + @a2 + ' ' + @a3 + ' ' + @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) VALUES ('INS', 'TR_TEACHER', @in);
END;
ELSE IF @INS = 0 AND @DEL > 0
	BEGIN 
		print '�������� ��������';
		set @a1 = (select [TEACHER] from inserted);
		set @a2 = (select [TEACHER_NAME] from inserted);
		set @a3 = (select [GENDER] from inserted);
		set @a4 = (select [PULPIT] from inserted);
		set @in = @a1 + ' ' + @a2 + ' ' + @a3 + ' ' + @a4;
		insert into TR_AUDIT(STMT, TRNAME, CC) VALUES ('DEL', 'TR_TEACHER', @in);
	END
ELSE if @ins > 0 and @del > 0
	begin
		print '�������� ����������';
		set @a1 = (select [TEACHER] from inserted);
		set @a2 = (select [TEACHER_NAME] from inserted);
		set @a3 = (select [GENDER] from inserted);
		set @a4 = (select [PULPIT] from inserted);
		set @in = @a1 + ' ' + @a2 + ' ' + @a3 + ' ' + @a4;
		insert into TR_AUDIT(STMT, TRNAME, CC) VALUES ('UPD', 'TR_TEACHER', @in);
	end;
return;

DROP trigger TR_TEACHER

insert INTO TEACHER(TEACHER, TEACHER_NAME, GENDER, PULPIT) VALUES ('oiu', 'kOZAK Olef', '�', '����')
DELETE FROM TEACHER WHERE TEACHER = 'oiu'
UPDATE TEACHER SET TEACHER_NAME = 'TEST' WHERE TEACHER = 'oiu'
SELECT * FROM TR_AUDIT
--5. ����������� ��������, ������� �����-�������� �� ������� ���� ������ UNIVER, ��� �������� ����������� ����������� ��-��������� �� ������������ AFTER-��������	
 update TEACHER set TEACHER = 'ER';
 SELECT * FROM TR_AUDIT
 --------6--------- 
 CREATE TRIGGER TR_TEACHER_DEL1
							ON TEACHER AFTER DELETE
AS DECLARE @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
print '�������� �������� DEL1';
set @a1 = (select [TEACHER] from inserted);
set @a2 = (select [TEACHER_NAME] from inserted);
set @a3 = (select [GENDER] from inserted);
set @a4 = (select [PULPIT] from inserted);
set @in = @a1 + ' ' + @a2 + ' ' + @a3 + ' ' + @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) VALUES ('DEL', 'TR_TEACHER_INS', @in);
return;

CREATE TRIGGER TR_TEACHER_DEL2 
							ON TEACHER AFTER DELETE
AS DECLARE @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
print '�������� �������� DEL2';
set @a1 = (select [TEACHER] from inserted);
set @a2 = (select [TEACHER_NAME] from inserted);
set @a3 = (select [GENDER] from inserted);
set @a4 = (select [PULPIT] from inserted);
set @in = @a1 + ' ' + @a2 + ' ' + @a3 + ' ' + @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) VALUES ('DEL', 'TR_TEACHER_INS', @in);
return;

CREATE TRIGGER TR_TEACHER_DEL3 
							ON TEACHER AFTER DELETE
AS DECLARE @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
print '�������� �������� DEL3';
set @a1 = (select [TEACHER] from inserted);
set @a2 = (select [TEACHER_NAME] from inserted);
set @a3 = (select [GENDER] from inserted);
set @a4 = (select [PULPIT] from inserted);
set @in = @a1 + ' ' + @a2 + ' ' + @a3 + ' ' + @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) VALUES ('DEL', 'TR_TEACHER_INS', @in);
return;

exec  SP_SETTRIGGERORDER @triggername  = 'TR_TEACHER_DEL3',
	 @order = 'First', @stmttype ='DELETE';

exec  SP_SETTRIGGERORDER @triggername  = 'TR_TEACHER_DEL2',
	@ORDER = 'Last', @stmttype = 'DELETE';

SELECT t.name, e.type_desc
	from sys.triggers t join sys.trigger_events e
		on t.object_id = e.object_id
			where OBJECT_NAME(t.parent_id) = 'TEACHER' and 
											e.type_desc = 'DELETE';

insert INTO TEACHER(TEACHER, TEACHER_NAME, GENDER, PULPIT) VALUES ('oiu', 'kOZAK Olef', '�', '����')
DELETE FROM TEACHER WHERE TEACHER = 'oiu'
 SELECT * FROM TR_AUDIT
---7---
CREATE TRIGGER EX7
	ON AUDITORIUM AFTER INSERT, DELETE, UPDATE
		AS DECLARE @C INT =(select AUDITORIUM_CAPACITY from inserted);
			IF @C > 100 
				BEGIN 
					PRINT '������� ������� ���������������';
					rollback;
				END;
	RETURN;

UPDATE AUDITORIUM SET AUDITORIUM_CAPACITY = 1000 WHERE AUDITORIUM = '299-2'
 SELECT * FROM TR_AUDIT
--8--
CREATE TRIGGER NO_DELETE_AUDIT
	ON AUDITORIUM INSTEAD OF DELETE 
		AS RaISERROR ('������� ������!', 10, 1);
	return;

DELETE FROM AUDITORIUM WHERE AUDITORIUM = '299-2'

 SELECT * FROM TR_AUDIT
 --9--
DROP TRIGGER DDL_Trigger
CREATE TRIGGER DDL_Trigger 
ON DATABASE 
FOR CREATE_TABLE, DROP_TABLE 
AS 
BEGIN 
    DECLARE @event_type varchar(50), 
            @object_name varchar(50), 
            @object_type varchar(50) 

    SELECT @event_type = EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'varchar(50)'), 
           @object_name = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(50)'), 
           @object_type = EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'varchar(50)') 

    IF @event_type = 'CREATE_TABLE' 
    BEGIN 
        RAISERROR('�������� ����� ������ ���������. ��� �������: %s, ��� �������: %s, ��� �������: %s', 16, 1, @event_type, @object_name, @object_type) 
        ROLLBACK TRANSACTION 
    END 
    ELSE IF @event_type = 'DROP_TABLE' 
    BEGIN 
        RAISERROR('�������� ������������ ������ ���������. ��� �������: %s, ��� �������: %s, ��� �������: %s', 16, 1, @event_type, @object_name, @object_type) 
        ROLLBACK TRANSACTION 
    END 
END 




  CREATE TABLE TestTable (ID INT)
   

select @@servername






CREATE TRIGGER OZENKA ON PROGRESS
INSTEAD OF INSERT
AS
BEGIN
  INSERT INTO PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
  SELECT SUBJECT, IDSTUDENT, PDATE, NOTE
  FROM inserted
  WHERE NOTE <> 10;

  UPDATE PROGRESS
  SET NOTE = 1
  WHERE NOTE = 10;
END;


INSERT into PROGRESS(SUBJECT, IDSTUDENT, PDATE, NOTE) VALUES ('��', 1000, GETDATE(), 10);
select * from PROGRESS



ALTER TRIGGER OZENKA ON PROGRESS
INSTEAD OF INSERT
AS
BEGIN
  INSERT INTO PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
  SELECT SUBJECT, IDSTUDENT, PDATE, 2
  FROM inserted
  WHERE NOTE = 10;

 INSERT INTO PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
  SELECT SUBJECT, IDSTUDENT, PDATE, NOTE
  FROM inserted
  WHERE NOTE != 10;
END;



INSERT into PROGRESS(SUBJECT, IDSTUDENT, PDATE, NOTE) VALUES ('��', 1000, GETDATE(), 9);
select * from PROGRESS