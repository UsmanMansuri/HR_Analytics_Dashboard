use project;
select * from hr_merge1_2;

#  Total Employee ---------------------------

create view Total_employee as
select count(*) total_employee from hr_merge1_2;

select * from Total_employee;

# Grnder Count ------------------------------------------

create view gender as
select gender, count(gender) Coutn_gender from hr_merge1_2
group by gender;

select * from gender;

# Current Employee ---------------------------------------------------------

create view `current employee` as
Select count(attrition) current_employee from hr_merge1_2 where attrition = 'No';

select * from `current employee`;

# Attrition Employee ------------------------------------------------------

create view Attrition AS
SELECT count(attrition) Ex_Employee from hr_merge1_2 where attrition = 'Yes';

select * from Attrition;


# -----------------------------1. Average Attrition rate for all Departments ----------------------------#


select * from hr_merge1_2;
select Department,count(attrition) `Number of Attrition`from hr_merge1_2
where attrition = 'yes'
group by Department;


create view Dept_average as
select department, round(count(attrition)/(select count(employeenumber) from hr_merge1_2)*100,2)  as attrtion_rate
from hr_merge1_2
where attrition = "yes"
group by department;
select * from dept_average;



# ----------------------------------2. Average Hourly rate of Male Research Scientist--------------------------------#


DELIMITER //
create procedure emp_role (in input_gender varchar(20), in input_jobrole varchar(30))
begin
 select Gender, round(avg(HourlyRate),2) `Avg Hourly Rate` from hr_merge1_2
 where gender = input_gender and jobrole = input_jobrole
 group by gender;
end //
DELIMITER ;
drop procedure emp_role;
call emp_role('male',"Research Scientist");



# ------------------------------3. Attrition rate Vs Monthly income stats-------------------------------------#

select department,
round(count(attrition)/(select count(employeenumber) from hr_merge1_2)*100,2) `Attrtion rate`,
round(avg(MonthlyIncome),2) average_incom from hr_merge1_2
where attrition = 'Yes'
group by department;

create view Attrition_employeeincome as
select department,
round(count(attrition)/(select count(employeenumber) from hr_merge1_2)*100,2) `Attrtion rate`,
round(avg(MonthlyIncome),2) average_income from hr_merge1_2
where attrition = 'Yes'
group by department;

select * from attrition_employeeincome;



#----------------------------- --------4. Average working years for each Department-------------------------------------#

select department,Round(avg(totalworkingyears),0) from hr_merge1_2
group by department;

Create view `Employee Age` as 
select department,Round(avg(totalworkingyears),0) from hr_merge1_2
group by department;

select * from `employee age`;



# --------------------------------------5. Job Role Vs Work life balance------------------------------------#


select * from hr_merge1_2;

select jobrole,worklifebalance, count(worklifebalance) Employee_count
from hr_merge1_2 
group by jobrole,worklifebalance
order by jobrole;

DELIMITER //
Create procedure Get_Count (in job_role varchar(30),in Work_balance varchar(30),out Ecount int)
begin
select count(worklifebalance)  Employee_count into ecount

where jobrole = job_role and worklifebalance = Work_balance
group by job_role,work_balance;
end //
DELIMITER ;
 
 call get_count('developer','Good',@Ecount);
 select @Ecount;



# --------------------------6. Attrition rate Vs Year since last promotion relation-----------------------------------#


select * from  hr_merge1_2;

select `YearsSinceLastPromotion`,count(attrition)  attrition_count
from hr_merge1_2 
where attrition = 'Yes'
group by `YearsSinceLastPromotion`
order by `YearsSinceLastPromotion`;

 
  # -------------------------------------7)  Distance vs Attrition -------------------------------#
  


Select distancefromhome, round(count(attrition)/(select count(employeenumber) from hr_merge1_2)*100,2) attrition_rate from hr_merge1_2
where attrition = 'Yes'
group by distancefromhome;


#  Education vs attrition

Select educationField, count(attrition) current_employee from hr_merge1_2
where attrition = 'yes'
group by educationfield;

# ------------------------------------8)  gender based percentage of employee ----------------------------------------#

SELECT
    gender,
    COUNT("Employee ID") AS total_count,
    round(COUNT("Employee ID") / (SELECT COUNT("Employee ID") FROM hr_merge1_2) * 100,4) AS percentage
FROM
    hr_merge1_2
WHERE
    gender IS NOT NULL
GROUP BY
    gender;


#---------------------------------9)  Department/ Job Role wise job satisfaction------------------------------------#


SELECT
    department,
    jobrole,
    AVG(jobsatisfaction) AS average_job_satisfaction
FROM
    hr_merge1_2
GROUP BY
    department, jobrole
ORDER BY
    department, jobrole;
    
  #----------------------------10) Count of Employees based on Educational Fields-------------------------#
  
    
    SELECT
    educationfield,
    COUNT("employee id") AS employee_count
FROM
   hr_merge1_2
GROUP BY
    educationfield
ORDER BY
    educationfield;

