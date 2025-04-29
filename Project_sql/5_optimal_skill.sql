with skills_demand as (
SELECT
skills_dim.skill_id,
skills_dim.skills,
count(skills_job_dim.job_id) as count_job
from job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where job_title_short = 'Data Scientist' and job_location = 'New York'and salary_year_avg is not null
group by skills_dim.skill_id,skills_dim.skills

),


 average_salary as (
SELECT
skills_job_dim.skill_id,
skills_dim.skills,
round(avg(salary_year_avg), 2)as avg_salary
from job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where job_title_short = 'Data Scientist' 
and job_location = 'New York' 
and salary_year_avg is not null
group by skills_job_dim.skill_id, skills_dim.skills

)

select skills_demand.skill_id,
skills_demand.skills,
average_salary.avg_salary,
skills_demand.count_job
from skills_demand
INNER JOIN average_salary on skills_demand.skill_id = average_salary.skill_id
order by count_job desc, avg_salary desc
limit 100;