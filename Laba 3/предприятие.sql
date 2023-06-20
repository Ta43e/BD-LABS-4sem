USE K_MyBASE;
CREATE TABLE ПРЕДПРИЯТИЕ
(	название_предприятия nchar(20) primary key,
	банковские_реквизиты nchar(10) not null,
	телефон int not null,
	контактное_лицо nchar(20) not null,
	прибыль int not null,
	себестоимость int not null,
	холдинг nvarchar(50) not null,
	FOREIGN KEY (холдинг) REFERENCES ХОЛДИНГ(название_холдинга)
);