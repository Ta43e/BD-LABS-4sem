USE K_MyBASE;
CREATE TABLE ��������_����������
(	��������_����������� nchar(20) not null, 
	��������_���������� nvarchar(20) not null,
	��������_���������� decimal(18,3),
	FOREIGN KEY (��������_����������) REFERENCES ����������(����������),
	FOREIGN KEY (��������_�����������) REFERENCES �����������(��������_�����������)
);