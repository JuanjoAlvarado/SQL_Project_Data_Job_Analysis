/*
Question: What are the optimal skills to learn?
    - Identify skills in high demand and associated with high average salaries for
      your role preference.
    - Concentrate on remote positions with specified salaries.

The main goal is to target skills that offer job security and financial benefits,
offering insights for career development.
*/


/*
Display the skill_id (specifying from wich table), skill name (specifying from wich table),
the demand of each skill ("COUNT" statement of the job_id from the skills_job_table) and the 
average salary associated to that skill("AVG" statement of the salary_year_avg).

To show all this information join the data from the tables "job_postings_fact", "skills_job_dim" 
and "skills_dim". Use a "INNER JOIN" in order to extract only the information that these three 
tables have in common.

Now we include the "WHERE" statement to filter the data set by our role preference, jobs with
specified salary ("salary_year_avg IS NOT NULL") and remote positions ("job_work_from_home = TRUE").
We also need to filter the result set by showing only the skills that have a demand superior to "x" number,
as we can't use an aggregate function we need to use the "HAVING" clause. 

Finally order the result set by the salary first and demand second, both in descending order.
*/
SELECT
    skills_dim.skill_id,  -- Combine using primary or foreign key
    skills_dim.skills,        -- Show the name of the skill ID
    COUNT(skills_job_dim.job_id) as demand_count,
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
    salary_year_avg IS NOT NULL AND  --Filter
    job_work_from_home = TRUE  --Filter 
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    salary_skill_average DESC,
    demand_count DESC
LIMIT 25; 