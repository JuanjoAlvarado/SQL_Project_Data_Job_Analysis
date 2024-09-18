
/*
Question: What are the top-paying <<your role preference>> jobs?
    - Identify the top 10 highest-paying <<your role preference>>
      that are available remotely.
    - Focus on job postings with specified salaries. 

The main goal is to highlight the top-paying opportunities for your specific
role preference, offering insights into employment opportunities according to 
your context.
*/


--Select the columns with the information you want to display
SELECT
    job_id,
    job_title_short,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact


/*
Filter the columns using the "WHERE" statement according to you role preference
(Using the column "job_title_short") and focusing on remote jobs (Using the column
"job_location").

Note: remote jobs is associated in the column "job_location" with the word "Anywhere".
*/

SELECT
    job_id,
    job_title_short,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere'


/*
We want to filter the data set by specified salaries. In other words we don't want
jobs associated with null values in the column "salary_year_avg". For that purpose we
use the "IS NOT NULL" statement.
*/
SELECT
    job_id,
    job_title_short,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL


/*
Now that we have the data set filtered by role preference, job location and salary, the 
next step is to display only the top 10 highest-paying results. So we need to order the 
results in descending order using the statemen "DESC" and limit the results display to 1o
using the limit statement. 
*/
SELECT
    job_id,
    job_title_short,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;


/*
The last step is to show the name of the companies that offers this top 10 highest-paying 
roles. We join the "job_postings_fact" with the table "company_dim" (this table contains
information about the companies such as the name) using a LEFT JOIN and the foreign key 
"company_id". In the "SELECT" statement include the "name" column to show company name.
*/
SELECT
    job_id,
    name AS company_name,
    job_title_short,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact
    LEFT JOIN company_dim
        ON
            job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;