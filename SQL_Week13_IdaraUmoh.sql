--select MAX(Salary)
--from EmployeeSalary

--select MIN(Salary)
--from EmployeeSalary


--select AVG(Salary)
--from EmployeeSalary

--select COUNT(EmployeeID)
--from EmployeeDemographics


--select *
--from SQLWEEK1.DBO.EmployeeSalary

select *
from EmployeeDemographics
WHERE FirstName = 'Mercy'

select *
from EmployeeDemographics
WHERE Age<=32 and Gender='Male'

select *
from EmployeeDemographics
WHERE Age<=32 or Gender='Male'

select *
from EmployeeDemographics
WHERE LastName like '%s%'








