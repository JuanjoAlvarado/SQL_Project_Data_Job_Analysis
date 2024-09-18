/*
Question: What skills are required for the top-paying <<your role preference>> jobs?
    - Use the top 10 highest-paying <<your role preference>> jobs from first query.
    - Add the specific skills required for these roles.

The main goal is to provide a detailed look at wich high_paying jobs demand certain 
skill/s, helping job seekers understand wich skills to develop.
*/


/*
We are going to bring the first query for the top 10 highest-paying jobs reducing the
columns we want to display.
*/
SELECT
    job_id,
    name AS company_name,
    job_title_short,
    salary_year_avg
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


/*
For this particular query we are going to use a CTE("common table expression") to associate
the top 10 highest-paying jobs with the skills names in the "skills_dim" table. Use a SELECT *
to see if the CTE is working fine.
*/
WITH top_paying_job AS (

    SELECT
        job_id,
        name AS company_name,
        job_title_short,
        salary_year_avg
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
    LIMIT 10
)

SELECT *
FROM
    top_paying_job


/*
Join the temporary date set result from the CTE with the table skills_job_dim to associate the 
job with the skill_id demanded using the primary key "job_id". Next join these "two tables" with 
"skills_dim" table to associate the skill_id with the name of the skill using the foreign key "skill_id".
*/
WITH top_paying_job AS (

    SELECT
        job_id,
        name AS company_name,
        job_title_short,
        salary_year_avg
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
    LIMIT 10
)

SELECT *
FROM
    top_paying_job
    INNER JOIN skills_job_dim
        ON
            top_paying_job.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim
        ON
            skills_job_dim.skill_id = skills_dim.skill_id


/*
Normally we would already finished but sometimes when using a CTE and joining more than one table
the results order is not the one we specified in the CTE (salary_year_avg DESC). So we need to do it
again at the end of the query.
*/

WITH top_paying_job AS (

    SELECT
        job_id,
        name AS company_name,
        job_title_short,
        salary_year_avg
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
    LIMIT 10
)

SELECT
    top_paying_job.*,
    skills
FROM
    top_paying_job
    INNER JOIN skills_job_dim
        ON
            top_paying_job.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim
        ON
            skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC
