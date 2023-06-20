SELECT FACULTY.FACULTY, GROUPS.PROFESSION, 2014 - GROUPS.YEAR_FIRST [����], PROGRESS.SUBJECT,
	ROUND(AVG(CAST(NOTE AS FLOAT(4))), 2)[������� ������]
	FROM FACULTY JOIN GROUPS
	 ON FACULTY.FACULTY = GROUPS.FACULTY
	  JOIN STUDENT 
		ON STUDENT.IDGROUP = GROUPS.IDGROUP
			JOIN PROGRESS
				ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
	WHERE FACULTY.FACULTY = '��'
	GROUP BY ROLLUP ( GROUPS.PROFESSION, FACULTY.FACULTY, GROUPS.YEAR_FIRST, PROGRESS.SUBJECT) 
---------------------------------------------------------------------------------------------------------
SELECT FACULTY.FACULTY, GROUPS.PROFESSION, 2014 - GROUPS.YEAR_FIRST [����], PROGRESS.SUBJECT,
	ROUND(AVG(CAST(NOTE AS FLOAT(4))), 2)[������� ������]
	FROM FACULTY JOIN GROUPS
	 ON FACULTY.FACULTY = GROUPS.FACULTY
	  JOIN STUDENT 
		ON STUDENT.IDGROUP = GROUPS.IDGROUP
			JOIN PROGRESS
				ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
	WHERE FACULTY.FACULTY = '��'
	GROUP BY CUBE ( GROUPS.PROFESSION, FACULTY.FACULTY, GROUPS.YEAR_FIRST, PROGRESS.SUBJECT) 
	---------------------------------------------------------------------------------------------------------
SELECT FACULTY.FACULTY, GROUPS.PROFESSION, 2014 - GROUPS.YEAR_FIRST [����], PROGRESS.SUBJECT,
	ROUND(AVG(CAST(NOTE AS FLOAT(4))), 2)[������� ������]
	FROM FACULTY JOIN GROUPS
	 ON FACULTY.FACULTY = GROUPS.FACULTY
	  JOIN STUDENT 
		ON STUDENT.IDGROUP = GROUPS.IDGROUP
			JOIN PROGRESS
				ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
	WHERE FACULTY.FACULTY = '��'
	GROUP BY GROUPS.PROFESSION, FACULTY.FACULTY, GROUPS.YEAR_FIRST, PROGRESS.SUBJECT
	UNION
SELECT FACULTY.FACULTY, GROUPS.PROFESSION, 2014 - GROUPS.YEAR_FIRST [����], PROGRESS.SUBJECT,
	ROUND(AVG(CAST(NOTE AS FLOAT(4))), 2)[������� ������]
	FROM FACULTY JOIN GROUPS
	 ON FACULTY.FACULTY = GROUPS.FACULTY
	  JOIN STUDENT 
		ON STUDENT.IDGROUP = GROUPS.IDGROUP
			JOIN PROGRESS
				ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
	WHERE FACULTY.FACULTY = '����'
	GROUP BY GROUPS.PROFESSION, FACULTY.FACULTY, GROUPS.YEAR_FIRST, PROGRESS.SUBJECT
	---------------------------------------------------------------------------------------------------------
	SELECT FACULTY.FACULTY, GROUPS.PROFESSION, 2014 - GROUPS.YEAR_FIRST [����], PROGRESS.SUBJECT,
	ROUND(AVG(CAST(NOTE AS FLOAT(4))), 2)[������� ������]
	FROM FACULTY JOIN GROUPS
	 ON FACULTY.FACULTY = GROUPS.FACULTY
	  JOIN STUDENT 
		ON STUDENT.IDGROUP = GROUPS.IDGROUP
			JOIN PROGRESS
				ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
	WHERE FACULTY.FACULTY = '��'
	GROUP BY GROUPS.PROFESSION, FACULTY.FACULTY, GROUPS.YEAR_FIRST, PROGRESS.SUBJECT
	UNION ALL
	SELECT FACULTY.FACULTY, GROUPS.PROFESSION, 2014 - GROUPS.YEAR_FIRST [����], PROGRESS.SUBJECT,
	ROUND(AVG(CAST(NOTE AS FLOAT(4))), 2)[������� ������]
	FROM FACULTY JOIN GROUPS
	 ON FACULTY.FACULTY = GROUPS.FACULTY
	  JOIN STUDENT 
		ON STUDENT.IDGROUP = GROUPS.IDGROUP
			JOIN PROGRESS
				ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
	WHERE FACULTY.FACULTY = '��'
	GROUP BY GROUPS.PROFESSION, FACULTY.FACULTY, GROUPS.YEAR_FIRST, PROGRESS.SUBJECT
	---------------------------------------------------------------------------------------------------------
	SELECT FACULTY.FACULTY, GROUPS.PROFESSION, 2014 - GROUPS.YEAR_FIRST [����], PROGRESS.SUBJECT,
	ROUND(AVG(CAST(NOTE AS FLOAT(4))), 2)[������� ������]
	FROM FACULTY JOIN GROUPS
	 ON FACULTY.FACULTY = GROUPS.FACULTY
	  JOIN STUDENT 
		ON STUDENT.IDGROUP = GROUPS.IDGROUP
			JOIN PROGRESS
				ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
	WHERE FACULTY.FACULTY = '��'
	GROUP BY GROUPS.PROFESSION, FACULTY.FACULTY, GROUPS.YEAR_FIRST, PROGRESS.SUBJECT
	INTERSECT
	SELECT FACULTY.FACULTY, GROUPS.PROFESSION, 2014 - GROUPS.YEAR_FIRST [����], PROGRESS.SUBJECT,
	ROUND(AVG(CAST(NOTE AS FLOAT(4))), 2)[������� ������]
	FROM FACULTY JOIN GROUPS
	 ON FACULTY.FACULTY = GROUPS.FACULTY
	  JOIN STUDENT 
		ON STUDENT.IDGROUP = GROUPS.IDGROUP
			JOIN PROGRESS
				ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
	WHERE FACULTY.FACULTY = '���'
	GROUP BY GROUPS.PROFESSION, FACULTY.FACULTY, GROUPS.YEAR_FIRST, PROGRESS.SUBJECT
		---------------------------------------------------------------------------------------------------------
	SELECT FACULTY.FACULTY, GROUPS.PROFESSION, 2014 - GROUPS.YEAR_FIRST [����], PROGRESS.SUBJECT,
	ROUND(AVG(CAST(NOTE AS FLOAT(4))), 2)[������� ������]
	FROM FACULTY JOIN GROUPS
	 ON FACULTY.FACULTY = GROUPS.FACULTY
	  JOIN STUDENT 
		ON STUDENT.IDGROUP = GROUPS.IDGROUP
			JOIN PROGRESS
				ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
	WHERE FACULTY.FACULTY = '��'
	GROUP BY GROUPS.PROFESSION, FACULTY.FACULTY, GROUPS.YEAR_FIRST, PROGRESS.SUBJECT
	EXCEPT 
	SELECT FACULTY.FACULTY, GROUPS.PROFESSION, 2014 - GROUPS.YEAR_FIRST [����], PROGRESS.SUBJECT,
	ROUND(AVG(CAST(NOTE AS FLOAT(4))), 2)[������� ������]
	FROM FACULTY JOIN GROUPS
	 ON FACULTY.FACULTY = GROUPS.FACULTY
	  JOIN STUDENT 
		ON STUDENT.IDGROUP = GROUPS.IDGROUP
			JOIN PROGRESS
				ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
	WHERE FACULTY.FACULTY = '���'
	GROUP BY GROUPS.PROFESSION, FACULTY.FACULTY, GROUPS.YEAR_FIRST, PROGRESS.SUBJECT
			---------------------------------------------------------------------------------------------------------