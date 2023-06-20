USE K_MyBASE;
CREATE TABLE ЗНАЧЕНИЕ_ПОКАЗАТЕЛЯ
(	название_предприятия nchar(20) not null, 
	название_показателя nvarchar(20) not null,
	значение_показателя decimal(18,3),
	FOREIGN KEY (название_показателя) REFERENCES ПОКАЗАТЕЛЬ(показатель),
	FOREIGN KEY (название_предприятия) REFERENCES ПРЕДПРИЯТИЕ(название_предприятия)
);