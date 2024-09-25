# Introduction
The world of data! Are you interested in the data job market? What insights are most important to you when consider starting in this particular market? This project explores top paying jobs, high-demand skills needed and the best combination of both, focusing in data analysis roles.

SQL queries? Chech them out here: [Jobs_Data_Analysis folder](/Jobs_Data_Analysis/)

# Background
It is normal for inexperience or lack of information to discourage people looking to get started in the world of data. 

The objective of this project is to reduce these barriers with useful and accurate information, so that the experience starting in this job market is as fun as possible.

Data hails from the [SQL Course](https://www.lukebarousse.com/sql) by Luke Barousse.  It contains different kinds of data such as: job titles, salaries, locations, essential skills, etc. Feel free to check it out.
### The questions I wanted to answer through the SQL queries were:
1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. What skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used
- **SQL and PostgreSQL**: A lenguange that allows me to bring out critical information and insights from a database; one of the best  and in-demand systems to manage databases was used for this project.
- **Visual Studio Code**: The corner stone and fundamental tool for database management and executing SQL queries.
- **Git & GitHub**: Essential for sharing SQL scripts and analysis, ensuring collaboration and project tracking. 
# The Analysis
### 1. Top-paying Jobs
Highlight the top-paying opportunities for data analyst roles, offering insights into employment opportunities according to 
your context.

```SQL
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
```
![Top-paying Jobs](Assets\Q1.jpg)
*Bar graph 1. Visualizing the year average salary of the top jobs for data analysts.*
### 2. Skills for top-paying Jobs
Provide a detailed look at wich high_paying jobs demand certain 
skill/s, helping job seekers understand wich skills to develop.

```SQL
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

```
![Skills top Jobs](Assets\Q2.jpg)
*Bar graph 2. Visualizing the demand count of skills for the top-paying jobs for data analysts*

### 3. In-demand skills for data analyst
Extract information about the skills with the highest demand
in the job market for data analysts.

```SQL
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
```
| Skills | Demand Count |
|--------|--------------|
| SQL    | 92628        |
| Excel  | 67031        |
| Python | 57326        |
| Tableau| 46554        |
|Power BI| 39468        |

*Table 1. Top 5 demanded skills for data analyst roles.*

### 4. Skills associated with high salaries
Reveal how different skills impact salary levels for your role
preference and helps identify the most financially rewarding skills.

```SQL
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
```
| Skill | Salary Average |
|-------|----------------|
| SVN   | 400,000.00     |
| Solidity | 179,000.00  |
| Couchbase | 160,515.00 |
| Datarobot | 155485.50  |
| Golang | 155,000.00    |

*Table 2. Top 5 high rewarding salaries per skill for data analyst roles.*

### 5. Optimal skills to learn
Target skills that offer job security and financial benefits,
offering insights for career development.

```SQL
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
LIMIT 30; 
```
![Optimal Skills 1](Assets\Q5.jpg)
*Bar graph 3. Top 30 Highest Average Salaries per skill for data analyst roles.*


![Optimal Skills 2](Assets\Q5(1).jpg)
*Bar graph 4. The skills associated to the top 30 Highest Average Salaries for data analyst roles.*
# What I Learned
By creating this project I was able to develop and expand my knowledge about SQL language tools and a database management system like PostgreSQL. Specifically:

- *Complex SQL Query*: Improve the logical process to create advanced queries in SQL; extracting data using temporary data set results (CTE's), joining multiple tables, filtering data sets and more.

- *Data Aggregation*: Feeling more comfortable using aggregate functions every time is needed to acquire more precise information in less time. 

- *Analytical thinking*: Train our mind to ask the correct questions and translate those to executable code is the most powerfull skill anyone who is interested in the world of data has to expand and dominate as I did, taking a little step forward with this project.

# Conclusion
## Insights
### Analysis
1. Top paying data analyst jobs that allow remote work offer a wide range of salaries, the highest  at $650,000.00.

2. Some of the skills associated with to high-paying data analyst roles are SQL, Python, Tableau, R and Snowflake. 

3. SQL is the most demanded skill for data analyst jobs making it a crucial factor to take into account when looking in the market.

4. SVN, Solidity and more. Specialized skills are associated with the top highest paying roles in data analysis, showing a premium on developer niche expertise.

5. It appears that the optimal skill for a data analyst role is SQL, with high demand and reward in the market. Mastering SQL may increase the market value of any professional. 

## Commentary
The information and insights of this project will be use as a guide not only for seeking future jobs but also as a curriculum map for my further professional development. Prioritizing continuous learning and adaptability is the most important conclusion of this work, in my opinion.

I encourage for you to take a better and more detailed look at the queries to fully understand the logical thinking process to extract the information I wanted to show, thanks!
