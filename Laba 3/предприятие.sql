USE K_MyBASE;
CREATE TABLE �����������
(	��������_����������� nchar(20) primary key,
	����������_��������� nchar(10) not null,
	������� int not null,
	����������_���� nchar(20) not null,
	������� int not null,
	������������� int not null,
	������� nvarchar(50) not null,
	FOREIGN KEY (�������) REFERENCES �������(��������_��������)
);