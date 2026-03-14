-- Data Cleaning
SELECT *
FROM layoffs;

-- 1 remove duplicates
-- 2 standardize the data
-- 3 null values and blank vLUES
-- 4 REMOVE ANY COLUMNS
CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT *
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;

SELECT *,
ROW_NUMBER () OVER(
PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,`date`) AS row_num
FROM layoffs_staging;

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER () OVER(
PARTITION BY company,industry,total_laid_off,percentage_laid_off,`date`, stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num>1;

SELECT*
FROM layoffs_staging
WHERE company='Casper';


WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER () OVER(
PARTITION BY company,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging
)
DELETE 
FROM duplicate_cte
WHERE row_num  >  1;



CREATE TABLE `layoffs_staging2` ( 
  `company` TEXT,
  `location` TEXT,
  `industry` TEXT, 
  `total_laid_off` INT DEFAULT NULL, 
  `percentage_laid_off` TEXT,
  `date` TEXT, 
  `stage` TEXT,
  `funds_raised_millions` INT DEFAULT NULL,
  `row_num` INT
) 
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT*
FROM layoffs_staging2;

SELECT*
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2 ADD COLUMN country TEXT;





INSERT INTO layoffs_staging2 (
    company, location, industry, total_laid_off, percentage_laid_off, `date`, 
    stage, country, funds_raised_millions, row_num
)
SELECT 
    company, location, industry, total_laid_off, percentage_laid_off, `date`,
    stage, country, funds_raised_millions,
    ROW_NUMBER() OVER (
        PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,
        `date`, stage, country, funds_raised_millions
    ) AS row_num
FROM layoffs_staging;



SELECT *
FROM  layoffs_staging2
WHERE row_num>1;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM layoffs_staging2 WHERE row_num > 1;


DELETE
FROM  layoffs_staging2
WHERE row_num>1;


SELECT *
FROM  layoffs_staging2;

 SELECT DISTINCT industry
  FROM layoffs_staging2
  ORDER BY 1;
  
  
-- STANDARDIZING DATA

SELECT company,trim(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company  = TRIM(company);

SELECT*
FROM layoffs_staging2
WHERE industry LIKE'Crpto%';

UPDATE  layoffs_staging2
SET industry = 'Crpto'
WHERE industry LIKE'Crpto%';

SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

SELECT *
FROM layoffs_staging2;

SELECT DISTINCT location
FROM layoffs_staging2
ORDER BY 1;

SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country =  TRIM(TRAILING '.' FROM country)
WHERE country LIKE  'United States%';


SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2;


UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');


ALTER TABLE layoffs_staging2
MODIFY COLUMN 	`date` Date;


SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SET SQL_SAFE_UPDATES = 0;


UPDATE layoffs_staging2
SET industry = NULL 
WHERE industry ='';


SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '' ;

SELECT *
FROM layoffs_staging2
WHERE company LIKE 'Bally%';


SELECT t1.industry,t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
WHERE (t1.industry IS  NULL OR t1.industry = '')
AND t2.industry  IS NOT NULL;



UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2	
	ON t1.company=t2.company 
SET t1.industry = t2.industry
WHERE t1.industry IS  NULL 
AND t2.industry  IS NOT NULL; 



SELECT*
FROM layoffs_staging2;


SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


SELECT *
FROM layoffs_staging2;


ALTER TABLE layoffs_staging2
DROP COLUMN row_num;


SELECT *
FROM layoffs_staging2;
