use Kozak_MyBASE
go
alter database Kozak_MyBASE set single_user with rollback immediate
go 
use master
go
DROP DATABASE Kozak_MyBASE


create database Kozak_MyBASE on primary
( name = N'UNIVER_mdf', filename = N'D:\����\������� 4\��\Laba 3\NDF\UNIVER_mdf.mdf', 
   size = 10240Kb, maxsize=UNLIMITED, filegrowth=1024Kb),
( name = N'UNIVER_ndf', filename = N'D:\����\������� 4\��\Laba 3\NDF\UNIVER_mdf.ndf', 
   size = 10240KB, maxsize=1Gb, filegrowth=25%),
filegroup FG1
( name = N'UNIVER_fg1_1', filename = N'D:\����\������� 4\��\Laba 3\NDF\UNIVER_fg1_1.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
( name = N'UNIVER_fg1_2', filename = N'D:\����\������� 4\��\Laba 3\NDF\UNIVER_fg1_2.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%)
log on
( name = N'UNIVER_log', filename=N'D:\����\������� 4\��\Laba 3\NDF\UNIVER_log.ldf',       
   size=10240Kb,  maxsize=2048Gb, filegrowth=10%)
go 

USE Kozak_MyBASE;

CREATE TABLE ������� 
(	��������_�������� nchar(20) primary key,
	id_�������� int not null 
) on FG1;

CREATE TABLE ����������
(	���������� nchar(20) PRIMARY KEY,
	��������_���������� nchar(10) not null,
	���� decimal (18,3) not null
) on FG1;

CREATE TABLE �����������
(	��������_����������� nchar(20) primary key,
	����������_��������� nchar(10) not null,
	������� int not null,
	����������_���� nchar(20) not null,
	������� int not null,
	������������� int not null,
	������� nchar(20) not null,
	FOREIGN KEY (�������) REFERENCES �������(��������_��������)
) on FG1;

CREATE TABLE ��������_����������
(	��������_����������� nchar(20) not null, 
	��������_���������� nchar(20) not null,
	��������_���������� decimal(18,3),
	FOREIGN KEY (��������_����������) REFERENCES ����������(����������),
	FOREIGN KEY (��������_�����������) REFERENCES �����������(��������_�����������)
) on FG1;

INSERT INTO ������� (��������_��������, id_��������)
Values ('Pitanie', 1),
	('Eda', 2),
	('Kachalka', 3);

INSERT into �����������(��������_�����������, ����������_���������, �������, ����������_����, �������, �������������, �������)
	Values ('Bufet', '133ert', 32322, 'Oleg', 150, 10000, 'Pitanie'),
	('Stolovaj', '844432e', 331, 'Andrey', 250, 15000, 'Eda'),
	('Gym', 'ka3321', 5325, 'Oleg', 550, 50000, 'Kachalka');

INSERT into ����������(����������, ��������_����������, ����)
	Values ('we', 12, 12),
	('rtt', 2, 32131),
	('tw', 12, 5325);

INSERT into ��������_����������(��������_�����������, ��������_����������, ��������_����������) 
Values ('Bufet', 'we', 111),
('Stolovaj', 'rtt', 1123 );

SELECT ����������, ��������_����������  From ����������;

SELECT count(*) From �������;
---------------------------------------
SELECT ��������_���������� From ����������;

UPDATE ���������� set ��������_���������� = ��������_����������+1 Where ���������� = 'rtt';

SELECT ��������_���������� From ����������;
---------------------------------------