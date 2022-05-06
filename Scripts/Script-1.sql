select * from (
select
	employees.first_name,
	salaries.salary,
	employees.emp_no,
	LAG(salaries.salary) over(order by employees.emp_no) as previous_salary,
	departments.dept_name,
	dense_rank() over(partition by departments.dept_no order by salaries.salary desc) as salary_rank
from
	dept_emp
inner join departments on
	(departments.dept_no = dept_emp.dept_no)
inner join employees on
	(employees.emp_no = dept_emp.emp_no)
inner join salaries on
	(salaries.emp_no = employees.emp_no)
	) it
	where it.salary_rank = 3;


select
employees.emp_no,
employees.first_name,
salaries.salary as es,
departments.dept_name,
case when employees.emp_no in (select emp_no from dept_manager) then 'Yes' else 'No' end as is_manager
from employees
left join salaries on employees.emp_no = salaries.emp_no 
left join dept_manager on dept_manager.emp_no = employees.emp_no 
left join departments on departments.dept_no = dept_manager.dept_no 
left join salaries ms on employees.emp_no = ms.emp_no 
where salaries.to_date = '9999-01-01'
and salaries.salary > ms.salary 
;
