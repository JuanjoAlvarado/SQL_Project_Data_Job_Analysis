/*
Question: What are the top skills based on salary?
    - Look at the average salary associated with each skill for <<Your role preference>>
      positions.
    - Focuses on roles with specified salaries, regardless of location.

The main goal is to reveal how different skills impact salary levels for your role
preference and helps identify the most financially rewarding skills to acquire or improve.
*/


/*
We need the data from the tables "job_postings_fact", "skills_job_dim" and "skills_dim". Use a 
"INNER JOIN" in order to extract only the information that these three tables have in common. 
Filter the result set by your role preference using the "WHERE" statement. You can LIMIT the result
set to have only the top 5, top 10, etc.
*/
SELECT
FROM
    job_postings_fact
    INNER JOIN skills_job_dim
        ON
            job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim
        ON
            skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
LIMIT 30;


/*
We want to display the name of the skill (column "skills") and the average salary for each skill.
In order to have an average salary for each skill we use the "AVG"(average) aggregate function and
the data in the column "salary_year_avg". We group by the skill name. Now we have the average salary
associated to a skill. 

Order by the average salary column in descending order to have
the top paying skills. Remember we need jobs with specified salaries so in the "WHERE" statement we
we need to include a "IS NOT NULL" to the column "salary_year_avg"

Note: you can use the "ROUND" statement to specify how many decimal point you want to display when 
using an aggregate function.
*/
SELECT
    skills,
    ROUND(AVG(salary_year_avg), 2) as salary_skill_average
FROM
    job_postings_fact
    INNER JOIN skills_job_dim
        ON
            job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim
        ON
            skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    salary_skill_average DESC
LIMIT 30;