
-- QUESTIONS

-- 1. What is the gender breakdown of employees in the company?
SELECT gender, COUNT(*) AS count
FROM HR_Data_Cleaning.dbo.Humain_Ressource
WHERE age >= 18 AND termdate IS NULL
GROUP BY gender;

-- 2. What is the race/ethnicity breakdown of employees in the company?
select race,count(*) as count
FROM HR_Data_Cleaning.dbo.Humain_Ressource
WHERE age >= 18 AND termdate IS NULL
group by race 
order by count(*) desc
-- 3. What is the age distribution of employees in the company?
SELECT age_group, COUNT(*) AS count
FROM (
    SELECT 
        CASE
            WHEN age >= 18 AND age <= 24 THEN '18-24'
            WHEN age >= 25 AND age <= 34 THEN '25-34'
            WHEN age >= 35 AND age <= 44 THEN '35-44'
            WHEN age >= 45 AND age <= 54 THEN '45-54'
            WHEN age >= 55 AND age <= 64 THEN '55-64'
            ELSE '65+'
        END AS age_group
    FROM HR_Data_Cleaning.dbo.Humain_Ressource
    WHERE age >= 18 AND termdate IS NULL
) AS sub
GROUP BY age_group
ORDER BY age_group;


SELECT gender,age_group, COUNT(*) AS count
FROM (
    SELECT 
        CASE
            WHEN age >= 18 AND age <= 24 THEN '18-24'
            WHEN age >= 25 AND age <= 34 THEN '25-34'
            WHEN age >= 35 AND age <= 44 THEN '35-44'
            WHEN age >= 45 AND age <= 54 THEN '45-54'
            WHEN age >= 55 AND age <= 64 THEN '55-64'
            ELSE '65+'
        END AS age_group ,gender
    FROM HR_Data_Cleaning.dbo.Humain_Ressource
    WHERE age >= 18 AND termdate IS NULL
) AS sub
GROUP BY age_group ,gender
ORDER BY age_group ,gender;




-- 4. How many employees work at headquarters versus remote locations?
select location,count(*) as count
  FROM HR_Data_Cleaning.dbo.Humain_Ressource
    WHERE age >= 18 AND termdate IS NULL
group by location

-- 5. How does the gender distribution vary across departments and job titles?

SELECT department, gender, COUNT(*) AS count
FROM HR_Data_Cleaning.dbo.Humain_Ressource
WHERE age >= 18 AND termdate IS NULL
GROUP BY department, gender
ORDER BY department;


-- 6. What is the distribution of job titles across the company?
select jobtitle,count(*) as count 
FROM HR_Data_Cleaning.dbo.Humain_Ressource
WHERE age >= 18 AND termdate IS NULL
group by jobtitle
order by jobtitle desc

-- 7. Which department has the highest turnover rate?

SELECT TOP 15 WITH TIES
    department,
    total_count,
    terminated_count,
    CAST(terminated_count AS DECIMAL) / total_count AS termination_rate
FROM
(
    SELECT
        department,
        COUNT(*) AS total_count,
        SUM(CASE WHEN termdate IS NOT NULL THEN 1 ELSE 0 END) AS terminated_count
    FROM HR_Data_Cleaning.dbo.Humain_Ressource
    WHERE age >= 18
    GROUP BY department
) AS subquery
ORDER BY termination_rate DESC;



-- 8. What is the distribution of employees across locations by city and state?
select location_state, count(*) AS count
FROM HR_Data_Cleaning.dbo.Humain_Ressource
WHERE age >= 18 AND termdate IS NULL 
   group by location_state
   order by count desc


-- 9. How has the company's employee count changed over time based on hire and term dates?
SELECT
    [year],
    hires,
    terminations,
    hires - terminations AS net_change,
    CAST((hires - terminations) AS DECIMAL) / hires AS net_change_percent
FROM
(
    SELECT
        YEAR(hire_date) AS [year],
        COUNT(*) AS hires,
        SUM(CASE WHEN termdate IS NOT NULL THEN 1 ELSE 0 END) AS terminations
    FROM HR_Data_Cleaning.dbo.Humain_Ressource
    WHERE age >= 18
    GROUP BY YEAR(hire_date)
) AS subquery
ORDER BY [year] ASC;


-- 10. What is the tenure distribution for each department?

SELECT
    department,
    ROUND(AVG(DATEDIFF(DAY, hire_date, termdate) / 365.0), 0) AS avg_tenure
FROM HR_Data_Cleaning.dbo.Humain_Ressource
WHERE age >= 18 AND termdate IS NOT NULL
GROUP BY department;

