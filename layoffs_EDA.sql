-- Exploratary Data Analysis

SELECT * FROM layoffs_staging2;

-- most amount of people laid off and max percentage laid off
SELECT MAX(total_laid_off), MAX(percentage_laid_off) -- 1 means 100%
FROM layoffs_staging2;

-- companies that laid off 100% of their employees
SELECT *
FROM layoffs_staging2
WHERe percentage_laid_off = 1
ORDER BY total_laid_off DESC;

-- companies with the most funding that laid of 100%
SELECT *
FROM layoffs_staging2
WHERe percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- companies and the amount of people they laid off
SELECT company, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- which industry laid off the most people
SELECT industry, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

-- which countries laid off the most people
SELECT country, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

-- number of people laid off per year
SELECT YEAR(`date`), sum(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

-- rolling total of lay offs by months
SELECT SUBSTRING(`date`,1,7) AS `MONTH`, sum(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7)  IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC;

--  month by month progression
WITH Rolling_Total as
(
SELECT SUBSTRING(`date`,1,7) AS `MONTH`, sum(total_laid_off) as laid_off
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7)  IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`, laid_off,
sum(laid_off) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_Total;

-- people laid off per company per year
SELECT company, YEAR(`date`), sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;

-- which company laid off the most per year
WITH company_year(company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC
), company_year_rank as -- to see the top 5 companies per year, cte
( 
SELECT *, 
DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) as ranking
FROM company_year
WHERE years IS NOT NULL
)
SELECT * 
FROM company_year_rank 
WHERE ranking <= 5;
-- to see the top 5 companies per year, cte

-- Which stage of company life is most affected by layoffs
SELECT stage, SUM(total_laid_off) as total_laid_off
FROM layoffs_staging2
GROUP BY stage
ORDER BY total_laid_off DESC;

-- Average percentage laid off by industry
SELECT industry, avg(percentage_laid_off) as percent_laid_off
FROM layoffs_staging2
WHERE percentage_laid_off IS NOT NULL
GROUP BY industry
ORDER BY percent_laid_off DESC
;

select * from layoffs_staging2;

-- which cities are most impacted by layoffs
SELECT location, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY location
ORDER BY total_laid_off DESC
LIMIT 10;

-- which countries are most impacted by layoffs
SELECT country, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY country
ORDER BY total_laid_off DESC
LIMIT 10;
