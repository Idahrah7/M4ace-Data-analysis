select * from [HR Data]

EXEC sp_help 'HR Data'
 
--cleaned term date
ALTER TABLE [HR Data] ADD termdate_clean DATE

UPDATE [HR Data]
SET termdate_clean = TRY_CONVERT(DATE, LEFT(termdate, 10), 120)             --10 is the first 10 characters from the left of the cell and 
WHERE termdate IS NOT NULL AND termdate <> ' '                              --120 means date as YYYY-MM-DD.


--created age column
ALTER TABLE [HR Data] ADD age INT


UPDATE [HR Data]
SET age =
DATEDIFF(YEAR,birthdate,GETDATE())                    --subtracts today's date from the birth date i.e 2026 - 1996 = 30
-
CASE
    WHEN DATEADD(YEAR,                                
                 DATEDIFF(YEAR,birthdate,GETDATE()),
                 birthdate) > GETDATE()
    THEN 1
    ELSE 0
                                                      --this case statement basically says that if its not their birthday or birthdate yet,
                                                     -- 1 will be subtracted for the calculation if it has passed the 0 is subtracted
                                                     --e.g if its 1 and the dateadd is 30 that will be 30 - 1 = 29
                                                     --thats the age

                        
                        
                        
                 --checking for error in the age column oldest and youngest
SELECT 
    MIN(age) AS youngest,
    MAX(age) AS oldest
FROM [HR Data]

select * from [HR Data]

                                     
                                    
                                    --realised that some termination date are in the futher not the past, lets clean that
SELECT COUNT(*) FROM [HR Data] WHERE termdate_clean > GETDATE()


SELECT TOP 20
    id,
    first_name,
    last_name,
    hire_date,
    termdate_clean
FROM [HR Data]
WHERE termdate_clean > GETDATE()
ORDER BY termdate_clean                             --lets inspect them
                                                    --the dates are in the recent future
                                                    --so i created a column explaining their status
ALTER TABLE [hr data]
ADD [Employee Status] VARCHAR(20)

select* from [HR Data]


UPDATE [HR Data]
SET [Employee Status] =
CASE
    WHEN termdate_clean IS NULL THEN 'Active'
    WHEN termdate_clean > GETDATE() THEN 'Pending Termination'
    ELSE 'Terminated'
END

SELECT [Employee Status],
    COUNT(*) AS [Employee Count]
FROM [HR Data]                                  --checking how many employees in the table fiteach category
GROUP BY [Employee Status]
ORDER BY [Employee Count] DESC


SELECT  COUNT([Employee Status])
FROM [HR Data]


                                  --checking the different locations
SELECT location,
    COUNT(*) AS [Location Count]
FROM [HR Data]
GROUP BY location
ORDER BY [Location Count] DESC

                                 -- checking for errors in race column
SELECT DISTINCT Race
FROM [HR Data]

                                  --checking for duplicates
SELECT id,
    COUNT(*) AS Duplicate_Count
FROM [HR Data]
GROUP BY id
HAVING COUNT(*) > 1
                                 --no duplicates

                           --creating a temp table
SELECT
    id AS ID,
    first_name AS [First Name],
    last_name AS [Last Name],
    birthdate AS [Birth Date],
    gender AS Gender,
    race AS Race,
    department AS Department,
    jobtitle AS [Job Title],
    hire_date AS [Hire Date],
    location AS Location,
    termdate_clean AS [Termination Date],
    age AS Age,
    [Employee Status]
INTO [Cleaned HR Data]
FROM [HR Data]
 
 select * from [Cleaned HR Data]


                                   --active employees by gender
 SELECT  Gender,
    COUNT(*) AS [Employee Count]
FROM [Cleaned HR Data]
WHERE [Employee Status] in  ('Active','Pending Termination')
GROUP BY Gender
ORDER BY [Employee Count] DESC
                                                                             -- Here;
                                                                                   -- Male employees slightly outnumber female employees,
                                                                                   -- but the workforce is still balanced.






SELECT
    gender,
    COUNT(*) AS [Employee Count],
   CAST(
        (
            COUNT(*) * 100.0 /
            (SELECT COUNT(*) FROM [Cleaned HR Data])
        ) AS DECIMAL(5,2)
    ) AS [Percentage of Total Employees]
FROM [Cleaned HR Data]
GROUP BY gender
ORDER BY [Employee Count] DESC
                                                                                            --As percentage








                                   
                                    --active employees by race
SELECT
    Race,
    COUNT(*) AS [Employee Count]
FROM [Cleaned HR Data]
WHERE [Employee Status] in  ('Active','Pending Termination')
GROUP BY Race
ORDER BY [Employee Count] DESC
                                                                         -- Here
                                                                          -- There are more White employees than any other racial group,
                                                                          -- but the company is still diverse, with employees from different racial backgrounds.




SELECT
    Race,
    COUNT(*) AS [Employee Count],
   CAST(
        (
            COUNT(*) * 100.0 /
            (SELECT COUNT(*) FROM [Cleaned HR Data])
        ) AS DECIMAL(5,2)
    ) AS [Percentage Of Race Distribution]
FROM [Cleaned HR Data]
GROUP BY Race
ORDER BY [Employee Count] DESC
                               








                          --grouping the age column
SELECT
    CASE
        WHEN Age BETWEEN 18 AND 24 THEN '18-24'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS [Age Group],
                                            --how many employees fall into each group
    COUNT(*) AS [Employee Count]
FROM [Cleaned HR Data]
WHERE [Employee Status] IN ('Active', 'Pending Termination')
GROUP BY
    CASE
        WHEN Age BETWEEN 18 AND 24 THEN '18-24'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END
    ORDER BY [Employee Count]desc
                                                                                        -- Here:
                                                                                            -- Employees aged 35-44 make up the largest age group.
                                                                                            -- Most employees are between 25 and 54 years old.
                                                                                            -- this shows that the workforce is made up of mostly mid career professionals












                       --ACTIVE EMPLOYEES IN EACH DEPARTMENT
   SELECT Department,
    COUNT(*) AS [Employee Count]
FROM [Cleaned HR Data]
WHERE [Employee Status] IN ('Active', 'Pending Termination')
GROUP BY Department
ORDER BY [Employee Count] DESC

                                                                                -- Here:
                                                                                    -- Engineering has the highest number of active employees,
                                                                                    -- making it the largest department in the company.
                                                                                    -- Auditing has the least nunber of employees.














                         --active employees doing each job
SELECT [Job Title],
    COUNT(*) AS [Employee Count]
FROM [Cleaned HR Data]
WHERE [Employee Status] IN ('Active', 'Pending Termination')
GROUP BY [Job Title]
ORDER BY [Employee Count] DESC;

                                                               --Here:
                                                                    -- Research Assistant II is the most common job title in the company.
                                                                    -- The workforce includes a wide range of roles across each departmrnt

SELECT count( distinct[Job Title])
FROM [Cleaned HR Data]                   --JUST CHECKED THE NUMBER OF JOB TITLES
AS [Number of Job Title]
                                                                                                    --there are 185 job titles















                            --creating a CTE to summarise employees in deparment
;WITH DepartmentSummary AS
(
    SELECT
        Department,
        COUNT(*) AS [Total Employees],
        SUM(
            CASE
                WHEN [Employee Status] IN ('Active','Pending Termination')
                THEN 1
                ELSE 0
            END                                       --for employees actively workin in each department
        ) AS [Current Employees],
         SUM(
            CASE
                WHEN [Employee Status] = 'Pending Termination'
                THEN 1
                ELSE 0
            END                                     -- for employye in each department leaving soon
        ) AS [On Notice],
        SUM(
            CASE
                WHEN [Employee Status] = 'Terminated'
                THEN 1
                ELSE 0
            END                                      --for former employees
        ) AS [Former Employees]
    FROM [Cleaned HR Data]
    GROUP BY Department )



       --using the cte to create turnover table which is the percentage of people that left the company
SELECT
    Department,
    [Total Employees],
    [Current Employees],
    [On Notice],
    [Former Employees],
    CAST(                                             --converts from one data tpe to anither
        ([Former Employees] * 100.0 / [Total Employees])
        AS DECIMAL(5,2)  )                                     -- 5=total digits allowed
     AS [Turnover Rate (%)]                                    -- 2=digits after dp
FROM DepartmentSummary
ORDER BY [Turnover Rate (%)] DESC

                                         --note that the turnover rate does not over exagerrate even if auditing had 56 employees and lost 10
                                         --while engineering had 6686 and lost 873
                                         --think about it like this auditing lost 19.23% of their workforce and engine lost 13.06%
                                         --The Turnover Rate shows the percentage of  workforce lost



                                         --Here:
                                            -- Auditing recorded the highest turnover rate (19.23%),
                                            -- indicating the greatest proportion of employee departures relative to department size.











                                    --checking which department has the highest workforce
SELECT
    Department,
    COUNT(*) AS [Employee Count],
    RANK() OVER (                     --ranks the departments
        ORDER BY COUNT(*) DESC
    ) AS [Department Rank]
FROM [Cleaned HR Data]
WHERE [Employee Status] IN ('Active','Pending Termination')
GROUP BY Department
                                                    --Here:
                                                    --Engineering has the largest active workforce and ranks first among all departments.













--seeing how termination dates are permanent for some employees how long do they actually stay before they leave
--whats the average time an employee stays before leaving

SELECT
     CAST(                     --ROUNDS up to 2 dp
     AVG(DATEDIFF(DAY,[Hire Date],[Termination Date])   --subtracts the last two dates it appears in days
     )/365.0                                          -- then divides by 365.0 to get in years
     AS DECIMAL(3,0)
     )AS [Average Years Employed]
     FROM [Cleaned HR Data]
     WHERE[Employee Status] = 'Terminated'

                                                                      --  Here:
                                                                      -- Employees who left the company remained employed for an average of 8 years before termination.









     
                                --LOCATION OF ACTIVE EMPLOYEES
SELECT
    Location,
    COUNT(*) AS [Employee Count]
    FROM[Cleaned HR Data]
    WHERE [Employee Status] IN ('Active','Pending Termination')
    GROUP BY Location
    ORDER BY [Employee Count]DESC 
                                                            
                                                            --Here
                                                                -- Headquarters employs the majority of active employees (14,523),
                                                                -- compared to 4,828 remote employees, indicating that the company has a primarily office-based workforce.








          --gender of employees in each department
 SELECT
    Department,
    Gender,
    COUNT(*) AS [Employee Count]
FROM [Cleaned HR Data]
WHERE [Employee Status] IN ('Active','Pending Termination')
GROUP BY Department, Gender
ORDER BY Department
   

                                              --Here:
                                                    -- Male employees slightly outnumber female employees in most departments.
                                                    -- But, departments such as Auditing, Marketing, and Research & Development actually maintain a relatively balanced gender distribution.
                                                    -- Non-Conforming employees represent a small proportion of the workforce across all departments,
                                                    -- while Engineering has the largest workforce for both males (2,941) and females (2,700).

                                               




  --finding ut how the employee hire or the company's hiring activity hhas changed over time
  SELECT
    YEAR([Hire Date]) AS [Hire Year],
    COUNT(*) AS [Employees Hired]
FROM [Cleaned HR Data]
GROUP BY YEAR([Hire Date])


                                                   -- Here:
                                                        -- Hiring activity remained relatively stable over time, but it reached its highest level in 2018 with 1,147 employees hired.
                                                      