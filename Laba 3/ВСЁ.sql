use Kozak_MyBASE
go
alter database Kozak_MyBASE set single_user with rollback immediate
go 
use master
go
DROP DATABASE Kozak_MyBASE


create database Kozak_MyBASE on primary
( name = N'UNIVER_mdf', filename = N'D:\УНИК\Семестр 4\БД\Laba 3\NDF\UNIVER_mdf.mdf', 
   size = 10240Kb, maxsize=UNLIMITED, filegrowth=1024Kb),
( name = N'UNIVER_ndf', filename = N'D:\УНИК\Семестр 4\БД\Laba 3\NDF\UNIVER_mdf.ndf', 
   size = 10240KB, maxsize=1Gb, filegrowth=25%),
filegroup FG1
( name = N'UNIVER_fg1_1', filename = N'D:\УНИК\Семестр 4\БД\Laba 3\NDF\UNIVER_fg1_1.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
( name = N'UNIVER_fg1_2', filename = N'D:\УНИК\Семестр 4\БД\Laba 3\NDF\UNIVER_fg1_2.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%)
log on
( name = N'UNIVER_log', filename=N'D:\УНИК\Семестр 4\БД\Laba 3\NDF\UNIVER_log.ldf',       
   size=10240Kb,  maxsize=2048Gb, filegrowth=10%)
go 

USE Kozak_MyBASE;

CREATE TABLE ХОЛДИНГ 
(	название_холдинга nchar(20) primary key,
	id_холдинга int not null 
) on FG1;

CREATE TABLE ПОКАЗАТЕЛЬ
(	показатель nchar(20) PRIMARY KEY,
	важность_показателя nchar(10) not null,
	дата decimal (18,3) not null
) on FG1;

CREATE TABLE ПРЕДПРИЯТИЕ
(	название_предприятия nchar(20) primary key,
	банковские_реквизиты nchar(10) not null,
	телефон int not null,
	контактное_лицо nchar(20) not null,
	прибыль int not null,
	себестоимость int not null,
	холдинг nchar(20) not null,
	FOREIGN KEY (холдинг) REFERENCES ХОЛДИНГ(название_холдинга)
) on FG1;

CREATE TABLE ЗНАЧЕНИЕ_ПОКАЗАТЕЛЯ
(	название_предприятия nchar(20) not null, 
	название_показателя nchar(20) not null,
	значение_показателя decimal(18,3),
	FOREIGN KEY (название_показателя) REFERENCES ПОКАЗАТЕЛЬ(показатель),
	FOREIGN KEY (название_предприятия) REFERENCES ПРЕДПРИЯТИЕ(название_предприятия)
) on FG1;

INSERT INTO ХОЛДИНГ (название_холдинга, id_холдинга)
Values ('Pitanie', 1),
	('Eda', 2),
	('Kachalka', 3);

INSERT into ПРЕДПРИЯТИЕ(название_предприятия, банковские_реквизиты, телефон, контактное_лицо, прибыль, себестоимость, холдинг)
	Values ('Bufet', '133ert', 32322, 'Oleg', 150, 10000, 'Pitanie'),
	('Stolovaj', '844432e', 331, 'Andrey', 250, 15000, 'Eda'),
	('Gym', 'ka3321', 5325, 'Oleg', 550, 50000, 'Kachalka');

INSERT into ПОКАЗАТЕЛЬ(показатель, важность_показателя, дата)
	Values ('we', 12, 12),
	('rtt', 2, 32131),
	('tw', 12, 5325);

INSERT into ЗНАЧЕНИЕ_ПОКАЗАТЕЛЯ(название_предприятия, название_показателя, значение_показателя) 
Values ('Bufet', 'we', 111),
('Stolovaj', 'rtt', 1123 );

SELECT показатель, важность_показателя  From ПОКАЗАТЕЛЬ;

SELECT count(*) From ХОЛДИНГ;
---------------------------------------
SELECT важность_показателя From ПОКАЗАТЕЛЬ;

UPDATE ПОКАЗАТЕЛЬ set важность_показателя = важность_показателя+1 Where показатель = 'rtt';

SELECT важность_показателя From ПОКАЗАТЕЛЬ;
---------------------------------------