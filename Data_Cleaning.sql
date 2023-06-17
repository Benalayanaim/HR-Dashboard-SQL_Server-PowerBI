select * from HR_Data_Cleaning.dbo.Humain_Ressource


EXEC sp_help 'HR_Data_Cleaning.dbo.Humain_Ressource';




select birthdate from HR_Data_Cleaning.dbo.Humain_Ressource

UPDATE HR_Data_Cleaning.dbo.Humain_Ressource
SET birthdate = CASE
    WHEN birthdate LIKE '%/%' THEN CONVERT(date, birthdate)
    WHEN birthdate LIKE '%-%' THEN CONVERT(date, birthdate)
    ELSE NULL
END;



ALTER TABLE HR_Data_Cleaning.dbo.Humain_Ressource
ALTER COLUMN birthdate DATE;


UPDATE HR_Data_Cleaning.dbo.Humain_Ressource
SET hire_date = CASE
    WHEN hire_date LIKE '%/%' THEN CONVERT(date, hire_date)
    WHEN hire_date LIKE '%-%' THEN CONVERT(date, hire_date)
    ELSE NULL 
end 

ALTER TABLE HR_Data_Cleaning.dbo.Humain_Ressource
ALTER COLUMN hire_date DATE;

select hire_date from HR_Data_Cleaning.dbo.Humain_Ressource

select termdate from HR_Data_Cleaning.dbo.Humain_Ressource

UPDATE HR_Data_Cleaning.dbo.Humain_Ressource
SET termdate = CONVERT(Date,termdate, '%Y-%m-%d %H:%i:%s UTC')
WHERE termdate IS NOT NULL AND termdate != ' ';



ALTER TABLE HR_Data_Cleaning.dbo.Humain_Ressource
ADD age INT;



UPDATE HR_Data_Cleaning.dbo.Humain_Ressource
SET age = DATEDIFF(YEAR, birthdate, GETDATE());

select age,birthdate from HR_Data_Cleaning.dbo.Humain_Ressource



SELECT 
    MIN(age) AS youngest,
    MAX(age) AS oldest
FROM HR_Data_Cleaning.dbo.Humain_Ressource;

SELECT COUNT(*) 
FROM  HR_Data_Cleaning.dbo.Humain_Ressource
WHERE age < 18
