
SELECT
skills,
count(skills_job_dim.job_id) as count_job
from job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where job_title_short = 'Data Scientist' and job_location = 'New York'
group by skills
order by count_job DESC
limit 10

