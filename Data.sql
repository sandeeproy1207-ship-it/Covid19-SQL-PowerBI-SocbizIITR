-- This code drops the 'covid' table if it exists and then creates a new 'covid' table with specified columns.

DROP TABLE IF EXISTS covid;
CREATE TABLE covid (
	iso_code Varchar,
	continent Varchar,
	location varchar,
	date timestamp,
	total_cases int,
	new_cases int,
	new_cases_smoothed float,
	total_death int,
	new_deaths int,
	new_deaths_smoothed float,
	total_cases_per_millions float,
	new_cases_per_million float,
	new_cases_per_smoothed_per_million float,
	total_deaths_per_million float,
	new_deaths_per_million float,
	new_deaths_smoothed_per_million float,
	reproduction_rate float,
	total_tests int,
	new_tests int,
	positive_rate float,
	tests_per_case float,
	tests_units varchar,
	total_vaccinations int,
	people_vaccinated int,
	people_fully_vaccinated int,
	total_boosters bigint,
	new_vaccinations int,
	population bigint
)

-- This code selects all rows from the 'covid' table.

SELECT * FROM covid;

-- Changing data types of specific columns in the 'covid' table.

ALTER TABLE Covid
ALTER COLUMN total_vaccinations SET DATA TYPE bigint;

ALTER TABLE Covid
ALTER COLUMN people_vaccinated SET DATA TYPE bigint;

ALTER TABLE Covid
ALTER COLUMN people_fully_vaccinated SET DATA TYPE bigint;

ALTER TABLE Covid
ALTER COLUMN total_tests SET DATA TYPE bigint;

ALTER TABLE Covid
ALTER COLUMN date SET DATA TYPE date;

-- Selecting specific columns from the 'covid' table where 'continent' is not null.

SELECT 
	continent,
	location,
	date,
	new_cases,
	new_deaths,
	new_vaccinations,
	population
FROM covid
WHERE continent IS NOT NULL;

-- Total number of cases, deaths, and vaccinations by continent.

SELECT
	continent,
	SUM(new_cases) as Total_Cases,
	SUM(new_deaths) as Total_Death,
	SUM(new_vaccinations) as Total_vaccinations
FROM covid
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY SUM(new_cases) DESC;

-- Total number of cases, deaths, vaccinations, and population by each country.

WITH cte as 
(
	SELECT 
		location,
		SUM(new_cases) as Total_Cases,
		SUM(new_deaths) as Total_Death,
		SUM(new_vaccinations) as Total_vaccinations,
		population
	FROM covid
	WHERE continent IS NOT NULL
	GROUP BY location, population
)
SELECT *,
	ROUND(100.0 * Total_Cases/ population,2) as Cases_per_Population_Percentage,
	ROUND(100.0 * Total_Death/ population,2) as Death_per_Population_Percentage,
	ROUND(100.0 * Total_vaccinations/ population,2) as Vaccination_per_Population_Percentage
FROM cte
WHERE 
	ROUND(100.0 * Total_Cases/ population,2) IS NOT NULL 
	AND ROUND(100.0 * Total_vaccinations/ population,2) IS NOT NULL
ORDER BY Cases_per_Population_Percentage DESC;

-- Cumulative sum of cases, deaths, and vaccinations.

SELECT
	continent,
	location,
	date,
	new_cases,
	new_deaths,
	new_vaccinations,
	SUM(new_cases) OVER(Partition by location ORDER by date) as rolling_cases_everyday,
	SUM(new_deaths) OVER(Partition by location ORDER by date) as rolling_death_everyday,
	SUM(new_vaccinations) OVER(Partition by location ORDER by date) as rolling_vaccinations_everyday
FROM covid
WHERE continent IS NOT NULL;

-- Cumulative sum of cases, deaths, and vaccinations in India.

SELECT
	continent,
	location,
	date,
	new_cases,
	new_deaths,
	new_vaccinations,
	SUM(new_cases) OVER(Partition by location ORDER by date) as rolling_cases_everyday,
	SUM(new_deaths) OVER(Partition by location ORDER by date) as rolling_death_everyday,
	SUM(new_vaccinations) OVER(Partition by location ORDER by date) as rolling_vaccinations_everyday
FROM covid
WHERE continent IS NOT NULL 
	AND location LIKE '%India%';

-- Percentage of cases per death when vaccination started in India.

WITH cte as 
(
SELECT
	continent,
	location,
	date,
	new_cases,
	new_deaths,
	new_vaccinations
FROM covid
WHERE continent IS NOT NULL 
	AND new_vaccinations IS NOT NULL
	AND location LIKE '%India'
)
SELECT *,
	ROUND(100.0 * new_deaths/NULLIF(new_cases,0),2) as cases_per_death
FROM cte;

-- Creating views to store data for visualizations.

-- Creating a view of total cases, deaths, and vaccinations by continent.

CREATE VIEW Continent_stats as 
SELECT
	continent,
	SUM(new_cases) as Total_Cases,
	SUM(new_deaths) as Total_Death,
	SUM(new_vaccinations) as Total_vaccinations
FROM covid
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY SUM(new_cases) DESC;

-- Creating a view of total cases, deaths, vaccinations, and population by each country.

CREATE VIEW country_stats as
WITH cte as 
(
	SELECT 
		location,
		SUM(new_cases) as Total_Cases,
		SUM(new_deaths) as Total_Death,
		SUM(new_vaccinations) as Total_vaccinations,
		population
	FROM covid
	WHERE continent IS NOT NULL
	GROUP BY location, population
)
SELECT *,
	ROUND(100.0 * Total_Cases/ population,2) as Cases_per_Population_Percentage,
	ROUND(100.0 * Total_Death/ population,2) as Death_per_Population_Percentage,
	ROUND(100.0 * Total_vaccinations/ population,2) as Vaccination_per_Population_Percentage
FROM cte
WHERE 
	ROUND(100.0 * Total_Cases/ population,2) IS NOT NULL 
	AND ROUND(100.0 * Total_vaccinations/ population,2) IS NOT NULL
ORDER BY Cases_per_Population_Percentage DESC;

-- Creating a view of cumulative sum of cases, deaths, and vaccinations.

CREATE VIEW global_cummulative_sum as 
SELECT
	continent,
	location,
	date,
	new_cases,
	new_deaths,
	new_vaccinations,
	SUM(new_cases) OVER(Partition by location ORDER by date) as rolling_cases_everyday,
	SUM(new_deaths) OVER(Partition by location ORDER by date) as rolling_death_everyday,
	SUM(new_vaccinations) OVER(Partition by location ORDER by date) as rolling_vaccinations_everyday
FROM covid
WHERE continent IS NOT NULL;

-- Creating a view of cumulative sum of cases, deaths, and vaccinations in India.

CREATE VIEW cummulative_sum_india as 
SELECT
	continent,
	location,
	date,
	new_cases,
	new_deaths,
	new_vaccinations,
	SUM(new_cases) OVER(Partition by location ORDER by date) as rolling_cases_everyday,
	SUM(new_deaths) OVER(Partition by location ORDER by date) as rolling_death_everyday,
	SUM(new_vaccinations) OVER(Partition by location ORDER by date) as rolling_vaccinations_everyday
FROM covid
WHERE continent IS NOT NULL 
	AND location LIKE '%India%';

-- Creating a view of percentage of cases per death when vaccination started in India.

CREATE VIEW india_stats as 
WITH cte as 
(
SELECT
	continent,
	location,
	date,
	new_cases,
	new_deaths,
	new_vaccinations
FROM covid
WHERE continent IS NOT NULL 
	AND new_vaccinations IS NOT NULL
	AND location LIKE '%India'
)
SELECT *,
	ROUND(100.0 * new_deaths/NULLIF(new_cases,0),2) as cases_per_death
FROM cte;
