-- --Loading the tables created with the data of the csv files-- --

COPY company_dim
FROM '[your file path]\company_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_dim
FROM '[your file path]\skills_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY job_postings_fact
FROM '[your file path]\job_postings_fact.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_job_dim
FROM '[your file path]\skills_job_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');


/* 
Database Load Issues (follow if receiving permission denied when running SQL code below)

NOTE: If you are having issues with permissions. And you get error: 

'could not open file "[your file path]\job_postings_fact.csv" for reading: Permission denied.'

In some cases is not necessary to do the following but could be the best option:

1. Use the code line: DROP DATABASE IF EXISTS "sql_course" or the name you gave it;
2. Create once again the data base and the tables using the sql files in the sql_load folder.

Then do the following steps:

1. Open pgAdmin
2. In Object Explorer (left-hand pane), navigate to `sql_course` database
3. Right-click `sql_course` and select `PSQL Tool`
    - This opens a terminal window to write the following code
4. Get the absolute file path of your csv files
    1. Find path by right-clicking a CSV file in VS Code and selecting “Copy Path”
5. Paste the following into `PSQL Tool`, (with the CORRECT file path)

\copy company_dim FROM '[your file path]\company_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_dim FROM '[your file path]\csv_files\skills_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy job_postings_fact FROM '[your file path]\csv_files\job_postings_fact.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_job_dim FROM '[your file path]\csv_files\skills_job_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

*/