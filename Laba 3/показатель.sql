USE K_MyBASE;
CREATE TABLE ПОКАЗАТЕЛЬ
(	показатель nchar(20) PRIMARY KEY,
	важность_показателя nchar(10) not null,
	дата decimal (18,3) not null
);