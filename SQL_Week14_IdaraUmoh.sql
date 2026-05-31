--select*
--from EmployeeDemographics2

--select*
--from EmployeeSalary2

--INSERT INTO EmployeeDemographics2
--values(NULL,'Idara', 'Umoh',NULL,30),
--(1008,NULL,'Yemen','Male',Null)

--Insert into EmployeeSalary2
--values(NULL,'Senior Analyst',120000),
--(1008,NULL,40000)

--select *
--from EmployeeDemographics2
--inner join EmployeeSalary2
--on EmployeeDemographics2.EmployeeID=EmployeeSalary2.EmployeeID

--select *
--from EmployeeDemographics2
--full outer join EmployeeSalary2
--on EmployeeDemographics2.EmployeeID=EmployeeSalary2.EmployeeID

-- select *
--from EmployeeDemographics2
--left outer join EmployeeSalary2
--on EmployeeDemographics2.EmployeeID=EmployeeSalary2.EmployeeID

-- select EmployeeDemographics2.EmployeeID,FirstName,LastName,Gender,JobTitle,Salary
--from EmployeeDemographics2
--inner join EmployeeSalary2
--on EmployeeDemographics2.EmployeeID=EmployeeSalary2.EmployeeID

-- select EmployeeSalary2.EmployeeID,FirstName,LastName,Gender,JobTitle,Salary
--from EmployeeDemographics2
--inner join EmployeeSalary2
--on EmployeeDemographics2.EmployeeID=EmployeeSalary2.EmployeeID

-- select EmployeeDemographics2.EmployeeID,FirstName,LastName,Gender,JobTitle,Salary
--from EmployeeDemographics2
--left outer join EmployeeSalary2
--on EmployeeDemographics2.EmployeeID=EmployeeSalary2.EmployeeID

-- select EmployeeDemographics2.EmployeeID,FirstName,LastName,Gender,JobTitle,Salary
--from EmployeeDemographics2
--right outer join EmployeeSalary2
--on EmployeeDemographics2.EmployeeID=EmployeeSalary2.EmployeeID

-- select EmployeeSalary2.EmployeeID,FirstName,LastName,Gender,JobTitle,Salary
--from EmployeeDemographics2
--left outer join EmployeeSalary2
--on EmployeeDemographics2.EmployeeID=EmployeeSalary2.EmployeeID

-- select EmployeeDemographics2.EmployeeID,FirstName,LastName,Salary
--from EmployeeDemographics2
--INNER join EmployeeSalary2
--on EmployeeDemographics2.EmployeeID=EmployeeSalary2.EmployeeID
--WHERE FirstName<>'Mercy'
--order by Salary desc

-- select JobTitle, salary, AVg(salary)
--from EmployeeDemographics2
--inner join EmployeeSalary2
--on EmployeeDemographics2.EmployeeID=EmployeeSalary2.EmployeeID
--Where JobTitle='Data Analyst'

--select JobTitle, AVg(salary)
--from EmployeeDemographics2
--inner join EmployeeSalary2
--on EmployeeDemographics2.EmployeeID=EmployeeSalary2.EmployeeID
--Where JobTitle='Data Analyst'
--group by JobTitle

--create table WarehouseEmployeeDemographics 
--(EmployeeID int,
--FirstName varchar(50),
--LastName varchar(50),
--Gender varchar(50),
--Age int
--)

--insert into WarehouseEmployeeDemographics VALUES
--(1009,'Favour', 'Aniefiok','Male', NULL),
--(1010,null,'Gaston','Female',46)

--SELECT *
--from EmployeeDemographics2
--union
--select*
--from  WarehouseEmployeeDemographics


--SELECT *
--from EmployeeDemographics2
--union all
--select*
--from  WarehouseEmployeeDemographics
--order by EmployeeID 

--SELECT EmployeeID, FirstName, Age
--FROM EmployeeDemographics2
--UNION
--SELECT EmployeeID, JobTitle, Salary
--FROM  EmployeeSalary2
--ORDER BY EmployeeID

select FirstName,LastName, Age,
case 
WHEN Age>30 THEN 'Old'
else 'Young'
end
from EmployeeDemographics2
where age is not null
order by Age
