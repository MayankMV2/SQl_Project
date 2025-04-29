with top_paying_job as(     
    select 
    job_id,
    job_title,
    salary_year_avg,
    name as company_name
    from job_postings_fact
    left join company_dim on job_postings_fact.company_id = company_dim.company_id
where
job_title_short = 'Data Analyst' and 
job_location = 'Anywhere'
and salary_year_avg is not null 
ORDER BY 
salary_year_avg desc
limit 10
)

SELECT 
top_paying_job.*,
skills from top_paying_job
INNER JOIN skills_job_dim on top_paying_job.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
order by salary_year_avg desc


