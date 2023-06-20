--------------------1. ���������� ��� �������, ��-����� ������� � �� UNIVER--
use UNIVER
EXEC sp_helpindex 'AUDITORIUM_TYPE'
EXEC sp_helpindex 'AUDITORIUM'
EXEC sp_helpindex 'FACULTY'
EXEC sp_helpindex 'GROUPS'
EXEC sp_helpindex 'PROFESSION'
EXEC sp_helpindex 'PULPIT'
EXEC sp_helpindex 'STUDENT'
EXEC sp_helpindex 'SUBJECT'
EXEC sp_helpindex 'TEACHER'


CREATE TABLE #myTempTable (
    id INT,
    name VARCHAR(50),
    age INT,
);
SET NOCOUNT ON
DECLARE @i INT = 1;
WHILE @i <= 1000
BEGIN
    INSERT INTO #myTempTable (id, name, age)
    VALUES (rand()*3000, CONCAT('Name', @i), ABS(CHECKSUM(NEWID()) % 100));
    SET @i = @i + 1;
END

SELECT #myTempTable.id
FROM #myTempTable
WHERE id between 1000 and 2000

CREATE  CLUSTERED INDEX #INDEXCLU_CL ON #myTempTable(id ASC);

SELECT #myTempTable.id
FROM #myTempTable
WHERE id between 1000 and 2000

DROP TABLE #myTempTable
---2. ������� ��������� ��������� �������. ��������� �� ������� (10000 ����� ��� ������). 
---����������� SELECT-������. �������� ���� ������� � ���������� ��� ���������. 
----������� ������������������ ������������ ��������� ������. 
----������� ��������� ������ ����������.
CREATE table #EX
(    TKEY int, 
      CC int identity(1, 1),
      TF varchar(100)
);

  set nocount on;           
  declare @U int = 0;
  while   @U < 20000       -- ���������� � ������� 20000 �����
  begin
       INSERT #EX(TKEY, TF) values(floor(30000*RAND()), replicate('������ ', 10));
        set @U = @U + 1; 
  end;

  SELECT * from  #EX where  TKEY > 1500 and  CC < 4500;  
  SELECT * from  #EX where  TKEY = 556 and  CC > 3
  SELECT * from  #EX order by  TKEY, CC

  CREATE INDEX #INDEX_DON ON #EX(TKEY, CC)

  SELECT * from  #EX where  TKEY > 1500 and  CC < 4500; 
  SELECT * from  #EX where  TKEY = 556 and  CC > 3
  SELECT * from  #EX order by  TKEY, CC

  DROP TABLE #EX
----3 ������� ��������� ��������� �������. ��������� �� ������� (�� ����� 10000 �����). 
----����������� SELECT-������. �������� ���� ������� � ������-���� ��� ���������. 
----������� ������������������ ������ ��������, ����������� ��������� SELECT-�������. 
CREATE table #EX_3
(    TKEY int, 
      CC int identity(1, 1),
      TF varchar(100)
);

  set nocount on;           
  declare @T int = 0;
  while   @T < 20000       -- ���������� � ������� 20000 �����
  begin
       INSERT #EX_3(TKEY, TF) values(floor(30000*RAND()), replicate('������ ', 10));
        set @T = @T + 1; 
  end;

  SELECT CC from #EX_3 where TKEY>15000 

  CREATE  index #INDEX_DODO on #EX_3(TKEY) INCLUDE (CC)

  SELECT CC FROM #EX_3 WHERE TKEY>15000
  DROP TABLE #EX_3

----4 ������� � ��������� ��������� ��������� �������. 
----����������� SELECT-������, �������� ���� ������� � ������-���� ��� ���������. 
----������� ������������������ ����������� ������, ��������-��� ��������� SELECT-�������.
CREATE table #EX_4
(    TKEY int, 
      CC int identity(1, 1),
      TF varchar(100)
);

  set nocount on;           
  declare @P int = 0;
  while   @P < 20000       -- ���������� � ������� 20000 �����
  begin
       INSERT #EX_4(TKEY, TF) values(floor(30000*RAND()), replicate('������ ', 10));
        set @P = @P + 1; 
  end;

SELECT TKEY from  #EX_4 where TKEY between 14000 and 19999; 
SELECT TKEY from  #EX_4 where TKEY>15000 and  TKEY < 20000  
SELECT TKEY from  #EX_4 where TKEY=17000

CREATE INDEX #INDEX_4EX ON #EX_4(TKEY) WHERE (TKEY >= 15000 AND TKEY <20000);

SELECT TKEY from  #EX_4 where TKEY between 14000 and 19999; 
SELECT TKEY from  #EX_4 where TKEY>15000 and  TKEY < 20000  
SELECT TKEY from  #EX_4 where TKEY=17000
drop table #EX_4
---5. ��������� ��������� ������-��� �������. 
---������� ������������������ ������. ������� ������� �������-����� �������. 
---����������� �������� �� T-SQL, ���������� �������� �������� � ������ ������������ ������� ���� 90%. 
---������� ������� ������������ �������. 

use tempdb;
CREATE table #EX_5
(
  TKEY int,
  CC int identity(1,1),
  TF varchar(100)
);
SET nocount on;
DECLARE @Q int = 0;
WHILE @Q < 20000
  begin
    INSERT #EX_5(TKEY, TF)
      values(floor(20000*RAND()),REPLICATE('text',3));
  SET @Q = @Q + 1;
  end;

--�������� FILLFACTOR ��������� ������� ���������� ��������� ������� ���-���� ������.
--CREATE index #INDEX_EX5 on #EX_5(TKEY);
CREATE INDEX #INDEX_EX5 ON #EX_5(TKEY)
							WITH (FILLFACTOR = 65)
INSERT top(10000) #EX_5(TKEY, TF) select TKEY, TF from #EX_5;

ALTER index #INDEX_EX5 on #EX_5 reorganize;
ALTER index #INDEX_EX5 on #EX_5 rebuild with (online = off);

SELECT name [������], avg_fragmentation_in_percent [������������ (%)]
       FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),    
       OBJECT_ID(N'#EX_5'), NULL, NULL, NULL) ss  JOIN sys.indexes ii 
                                     ON ss.object_id = ii.object_id and ss.index_id = ii.index_id  
                                                                                          WHERE name is not null;

drop index #INDEX_EX5 on #EX_5
drop table #EX_5






