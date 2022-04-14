SELECT e.emp_no, e.first_name, e.last_name
FROM employees as e;

SELECT t.title, t.from_date, t.to_date
FROM titles as t;

SELECT e.emp_no, 
		e.first_name, 
		e.last_name,
		t.title, 
		t.from_date, 
		t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;


-- Use Distinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles as rt
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

--Number of employees retiring by job title
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count desc;

--Number of employees eligible for mentorship
SELECT DISTINCT ON(e.emp_no) e.emp_no,
		e.first_name,
		e.last_name, 
		e.birth_date,
		de.from_date, 
		de.to_date,
		t.title
		--DISTINCT on emp_no
--INTO Mentorship
FROM employees as e
	INNER JOIN dept_emp AS de
		ON (e.emp_no = de.emp_no)
	INNER JOIN titles AS t
		ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01') 
ORDER BY e.emp_no, t.title asc;


