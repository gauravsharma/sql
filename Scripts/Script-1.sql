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

select
*,
    max(salary) over (partition by salaries.emp_no) as current_salary
,    LAG(salaries.salary) over(partition by salaries.emp_no
order by
    salaries.to_date) as previous_salary
from
    salaries;

-- approach 1, using self join
select t1.A, t1.B, t2.A, t2.B from number_pairs t1 left join number_pairs t2 on t1.B = t2.A and t1.A = t2.B where t2.A is null or t1.A < t2.A;

-- approach 2 using exists or not exists
select * from number_pairs t1 where not exists (select * from number_pairs t2 where t1.B = t2.A and t1.A = t2.B and t1.A < t2.A);

-- approach 3 , using login of sorting or deriving a common key



-- find customer who have placed more orders
WITH total_orders(CUST_CODE,
total_orders_per_customer) AS (
	SELECT
		CUST_CODE,
		count(*) AS total_orders_per_customer
	FROM
		orders
	GROUP BY
		CUST_CODE
),
avg_orders(avg_orders) AS (
SELECT
	AVG(total_orders_per_customer) as avg_orders
from
	total_orders
)
select
	*
from
	total_orders
join avg_orders on
	total_orders.total_orders_per_customer > avg_orders.avg_orders




