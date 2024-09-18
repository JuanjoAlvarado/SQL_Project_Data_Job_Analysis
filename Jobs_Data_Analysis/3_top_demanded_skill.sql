/*
Question: What are the most in-demad skills for data analysts?
    - Identify the top 5 in-demand skills for <<Your role preference>>
    - Focus on all job postings to see if there is a diference. 

The main goal is to extract information about the skills with the highest demand
in the job market according to your role preference.
*/


/*
To identify the top 5 in-demand skills according to your role preference we need the 
data from the tables "job_postings_fact", "skills_job_dim" and "skills_dim". Use a 
"INNER JOIN" in order to extract only the information that these three tables have in 
common.
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
LIMIT 5;


/*
In the SELECT statement display the column "skills" corresponding to the name of the skill.
Now we want to know how many jobs posted demand a certain skill, fo that we use the "COUNT"
statement. As the argument of the "COUNT" we use the "job_id" from the skills_job_dim table.
We only need the top 5; use the "LIMIT" statement.

Note: remember that every time we use an aggregate function we need to use a group by statement.
*/
SELECT
    skills,
    COUNT(skills_job_dim.job_id) as demand_count
FROM
    job_postings_fact
    INNER JOIN skills_job_dim
        ON
            job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim
        ON
            skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY
    skills
LIMIT 5;


/*
Now we have the demand frecuency of each skill and need to filter the data set only by our role
preference as we are focusing also in all jobs postings. USe the "WHERE" statement and the column
"job_title_short" to pick the role you want.

Note: remember to use a "ORDER BY" statement as the data set by default is going to display the results
in ascending order (lowest to highest).
*/
SELECT
    skills,
    COUNT(skills_job_dim.job_id) as demand_count
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
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;