use genzdataset;

show Tables;

select * from learning_aspirations;
select * from manager_aspirations;
select * from mission_aspirations;
select * from personalized_info;

-- Dataset View for Practice

Select PreferredWorkingEnvironment, count(PreferredWorkingEnvironment) from learning_aspirations
group by PreferredWorkingEnvironment;

select Count(personalized_info.Gender) from personalized_info
join learning_aspirations
on learning_aspirations.ResponseID = personalized_info.ResponseID
where personalized_info.Gender Like 'M%' or personalized_info.Gender Like 'F%' 
and learning_aspirations.PreferredWorkingEnvironment = 'Every Day Office Environment';

Select count(*) from personalized_info;
Select count(*) from learning_aspirations;

select
concat(round(Sum(Case
when personalized_info.Gender like 'M%' or personalized_info.Gender Like 'F%'
and learning_aspirations.PreferredWorkingEnvironment = 'Every Day Office Environment' then 1 else 0 end)
/ count(personalized_info.ResponseID) * 100, 2), '%') as Percentage 
from personalized_info
join learning_aspirations
on learning_aspirations.ResponseID = personalized_info.ResponseID;





-- Genz who wants to go Office Everyday--

select
concat(round(Sum(Case
when personalized_info.Gender like 'M%' or personalized_info.Gender Like 'F%'
and learning_aspirations.PreferredWorkingEnvironment = 'Every Day Office Environment' then 1 else 0 end)
/ count(personalized_info.Gender) * 100, 2), '%') as Percentage 
from personalized_info
Left join learning_aspirations
on learning_aspirations.ResponseID = personalized_info.ResponseID;



-- Percenatge of GenZ who wants go in Business Operation Influenced by their Parents

select 
concat(round(sum(Case 
When ClosestAspirationalCareer like ('%Business Operations%')
and CareerInfluenceFactor = 'My Parents' Then 1 else 0 END)/count(personalized_info.Gender) * 100, 2), '%') 
as Percenatge_of_GenZ_Opts_Business_Operations_influenced_by_Parents 
from learning_aspirations
left Join personalized_info
on learning_aspirations.ResponseID = personalized_info.ResponseID;

select 
concat(round(sum(Case 
When ClosestAspirationalCareer like ('%Business Operations%')
and CareerInfluenceFactor = 'My Parents' Then 1 else 0 END)/count(personalized_info.Gender) * 100, 2), '%') 
as Percenatge_of_GenZ_Opts_Business_Operations_influenced_by_Parents 
from learning_aspirations
Join personalized_info
on learning_aspirations.ResponseID = personalized_info.ResponseID;


select
concat(round(sum(case when ClosestAspirationalCareer like ('%Business Operations%') 
and CareerInfluenceFactor = 'My Parents' Then 1 else 0 END)/count(*) * 100, 2), '%') 
as Percenatge_of_GenZ_Opts_Business_Operations_influenced_by_Parents
from learning_aspirations;


-- Percentage of Genz who want go for hIgher studies


select personalized_info.Gender, 
concat(round(sum(case 
when learning_aspirations.HigherEducationAbroad = 'Yes, I wil' then 1 else 0 end)/
Count(personalized_info.Gender)*100, 2), '%') as Percentage_Higher_Studies_Abroad
from personalized_info
join learning_aspirations
on learning_aspirations.ResponseID = personalized_info.ResponseID
group by personalized_info.Gender;



-- Percentage of Genz who wants and don't want to work with comapniws whose mission is misaligned


select personalized_info.Gender, 
concat(round(sum(
CASE WHEN mission_aspirations.MisalignedMissionLikelihood =  'Will work for them' 
and MissionUndefinedLikelihood = 'Yes' then 1 else 0 end)/
count(personalized_info.Gender)* 100, 2), '%') as Will_Work,
concat(round(sum(
CASE WHEN mission_aspirations.MisalignedMissionLikelihood =  'Will NOT work for them' 
and MissionUndefinedLikelihood = 'Yes' then 1 else 0 end)/
count(personalized_info.Gender)* 100, 2), '%') as Will_Not_Work
from personalized_info
join mission_aspirations
on mission_aspirations.ResponseID = personalized_info.ResponseID
group by personalized_info.Gender;


-- most suitable working environment for females


select learning_aspirations.PreferredWorkingEnvironment
from learning_aspirations 
jOIN personalized_info
on learning_aspirations.ResponseID = personalized_info.ResponseID
Where personalized_info.Gender like 'F%'
group by learning_aspirations.PreferredWorkingEnvironment
order by Count(learning_aspirations.PreferredWorkingEnvironment) desc
limit 1;


-- No of Females who wans to work in their aspirational career


select count(Gender) as No_of_Females
from personalized_info
Join mission_aspirations
on mission_aspirations.ResponseID = personalized_info.ResponseID
where personalized_info.Gender Like 'F%' and mission_aspirations.NoSocialImpactLikelihood between 1 and 5 
and mission_aspirations.MisalignedMissionLikelihood =  'Will work for them';



-- Males who wants go abroad and influenced by their parents


select * from personalized_info
join learning_aspirations
on learning_aspirations.ResponseID = personalized_info.ResponseID
where personalized_info.Gender Like 'M%' 
and learning_aspirations.CareerInfluenceFactor = 'My Parents' 
and learning_aspirations.HigherEducationAbroad = 'Yes, I wil';


-- Gender wise percentage have high social impact and interested in higher studies in abroad

select personalized_info.Gender,
concat(round(Sum(Case
when learning_aspirations.HigherEducationAbroad = 'Yes, I wil' 
and mission_aspirations.NoSocialImpactLikelihood between 8 and 10 then 1 else 0 end)
/ count(personalized_info.ResponseID) * 100, 2), '%') as Percentage_of_8_10_Likelihood_want_to_go_abroad
from personalized_info
join learning_aspirations
on learning_aspirations.ResponseID = personalized_info.ResponseID
Join mission_aspirations
on mission_aspirations.ResponseID = learning_aspirations.ResponseID
group by personalized_info.Gender;


-- Gender wise split of working with teams


select 'Overall' as PreferredWorkSetup, 
sum(case when personalized_info.Gender like 'M%' 
and manager_aspirations.PreferredWorkSetup like '%Team%' then 1 else 0 end) 
as Overall_Count_of_Males,
concat(round(sum(case when personalized_info.Gender like 'M%' 
and manager_aspirations.PreferredWorkSetup like '%Team%' then 1 else 0 end)/
count(manager_aspirations.PreferredWorkSetup)* 100, 2), '%')
as Overall_Percenatage_of_Males,
sum(case when personalized_info.Gender like 'F%' 
and manager_aspirations.PreferredWorkSetup like '%Team%' then 1 else 0 end) 
as Overall_Count_of_Females,
concat(round(sum(case when personalized_info.Gender like 'F%' 
and manager_aspirations.PreferredWorkSetup like '%Team%' then 1 else 0 end)/
count(manager_aspirations.PreferredWorkSetup)* 100, 2), '%')
as Overall_Percenatage_of_Females
from manager_aspirations
join personalized_info
on personalized_info.ResponseID = manager_aspirations.ResponseID
union
select  PreferredWorkSetup, 
sum(case when personalized_info.Gender like 'M%' 
and manager_aspirations.PreferredWorkSetup like '%Team%' then 1 else 0 end) 
as Overall_Count_of_Males,
concat(round(sum(case when personalized_info.Gender like 'M%' 
and manager_aspirations.PreferredWorkSetup like '%Team%' then 1 else 0 end)/
count(manager_aspirations.PreferredWorkSetup)* 100, 2), '%')
as Overall_Percentage_Count_of_Males,
sum(case when personalized_info.Gender like 'F%' 
and manager_aspirations.PreferredWorkSetup like '%Team%' then 1 else 0 end) 
as Overall_Count_of_Females,
concat(round(sum(case when personalized_info.Gender like 'F%' 
and manager_aspirations.PreferredWorkSetup like '%Team%' then 1 else 0 end)/
count(manager_aspirations.PreferredWorkSetup)* 100, 2), '%')
as Overall_Percenatage_of_Females
from manager_aspirations
join personalized_info
on personalized_info.ResponseID = manager_aspirations.ResponseID
group by PreferredWorkSetup;



-- Breakdown of work likelihood 3 years for each gender

select manager_aspirations.WorkLikelihood3Years,
sum(case when personalized_info.Gender like 'M%' then 1 else 0 end) as For_Males, 
sum(case when personalized_info.Gender like 'F%' then 1 else 0 end) as For_Females,
sum(case when personalized_info.Gender like 'T%' then 1 else 0 end) as For_Trans
from manager_aspirations
join personalized_info
on personalized_info.ResponseID = manager_aspirations.ResponseID
group by manager_aspirations.WorkLikelihood3Years;



-- Average starting salary for 3 years  gender wise


select p.Gender,
avg(Case when m.ExpectedSalary3years = '31k to 40k' then 40000
when m.ExpectedSalary3years = '21k to 25k' then 25000
when m.ExpectedSalary3years = '>50k' then 50000
when m.ExpectedSalary3years = '26k to 30k' then 30000  
when m.ExpectedSalary3years = '16k to 20k' then 20000
when m.ExpectedSalary3years = '41k to 50k' then 45000
when m.ExpectedSalary3years = '11k to 15k' then 15000
when m.ExpectedSalary3years = '5k to 10k' then 10000 else 0 end) as Average_3_Years_Salary
from mission_aspirations as m
join personalized_info as p
on p.ResponseID = m.ResponseID
group by p.Gender;



-- Average Starting salary for 5 years  gender wise


select p.Gender,
avg(Case when m.ExpectedSalary5years like '%91k to 110k%' then 110000
when m.ExpectedSalary5years like '%50k to 70k%' then 75000
when m.ExpectedSalary5years like '%>151k%' then 150000
when m.ExpectedSalary5years like '%71k to 90k%' then 90000  
when m.ExpectedSalary5years like '%111k to 130k%' then 130000
when m.ExpectedSalary5years like '%131k to 150k%' then 135000
when m.ExpectedSalary5years like '%30k to 50k%' then 50000
else 0 end) as Average_5_Years_Salary
from mission_aspirations as m
join personalized_info as p
on p.ResponseID = m.ResponseID
group by p.Gender;



-- Average higher bar salary for 3 years  gender wise


select p.Gender,
avg(Case when m.ExpectedSalary3years = '31k to 40k' then 40000
when m.ExpectedSalary3years = '>50k' then 50000
else 0 end) as Average_3_Years_Salary
from mission_aspirations as m
join personalized_info as p
on p.ResponseID = m.ResponseID
group by p.Gender;


-- Average higher bar salary for 5 years  gender wise

select p.Gender,
avg(Case when m.ExpectedSalary5years like '%>151k%' then 150000
when m.ExpectedSalary5years like '%131k to 150k%' then 135000
else 0 end) as Average_5_Years_Salary
from mission_aspirations as m
join personalized_info as p
on p.ResponseID = m.ResponseID
group by p.Gender;





-- Average starting salary for 3 years  gender wise for each State


select I.State,
avg(case
when p.Gender like 'M%' and m.ExpectedSalary3years = '31k to 40k' then 40000
when p.Gender like 'M%' and m.ExpectedSalary3years = '21k to 25k' then 25000
when p.Gender like 'M%' and m.ExpectedSalary3years = '>50k' then 50000
when p.Gender like 'M%' and m.ExpectedSalary3years = '26k to 30k' then 30000  
when p.Gender like 'M%' and m.ExpectedSalary3years = '16k to 20k' then 20000
when p.Gender like 'M%' and m.ExpectedSalary3years = '41k to 50k' then 45000
when p.Gender like 'M%' and m.ExpectedSalary3years = '11k to 15k' then 15000
when p.Gender like 'M%' and m.ExpectedSalary3years = '5k to 10k' then 10000
else 0 end) as Average_3_Years_Salary_for_Males,
avg(case
when p.Gender like 'F%' and m.ExpectedSalary3years = '31k to 40k' then 40000
when p.Gender like 'F%' and m.ExpectedSalary3years = '21k to 25k' then 25000
when p.Gender like 'F%' and m.ExpectedSalary3years = '>50k' then 50000
when p.Gender like 'F%' and m.ExpectedSalary3years = '26k to 30k' then 30000  
when p.Gender like 'F%' and m.ExpectedSalary3years = '16k to 20k' then 20000
when p.Gender like 'F%' and m.ExpectedSalary3years = '41k to 50k' then 45000
when p.Gender like 'F%' and m.ExpectedSalary3years = '11k to 15k' then 15000
when p.Gender like 'F%' and m.ExpectedSalary3years = '5k to 10k' then 10000
else 0 end) as Average_3_Years_Salary_for_females,
avg(case
when p.Gender like 'T%' and m.ExpectedSalary3years = '31k to 40k' then 40000
when p.Gender like 'T%' and m.ExpectedSalary3years = '21k to 25k' then 25000
when p.Gender like 'T%' and m.ExpectedSalary3years = '>50k' then 50000
when p.Gender like 'T%' and m.ExpectedSalary3years = '26k to 30k' then 30000  
when p.Gender like 'T%' and m.ExpectedSalary3years = '16k to 20k' then 20000
when p.Gender like 'T%' and m.ExpectedSalary3years = '41k to 50k' then 45000
when p.Gender like 'T%' and m.ExpectedSalary3years = '11k to 15k' then 15000
when p.Gender like 'T%' and m.ExpectedSalary3years = '5k to 10k' then 10000
else 0 end) as Average_3_Years_Salary_for_Transgenders
from India_pincode as I
join personalized_info p
on p.ZipCode = I.Pincode
Join mission_aspirations m
on p.ResponseID = m.ResponseID
group by I.State ;



-- Average starting salary for 5 years  gender wise for each State


select I.State, 
avg(Case when p.Gender like 'M%' and m.ExpectedSalary5years like '%91k to 110k%' then 110000
when p.Gender like 'M%' and m.ExpectedSalary5years like '%50k to 70k%' then 75000
when p.Gender like 'M%' and m.ExpectedSalary5years like '%>151k%' then 150000
when p.Gender like 'M%' and m.ExpectedSalary5years like '%71k to 90k%' then 90000  
when p.Gender like 'M%' and m.ExpectedSalary5years like '%111k to 130k%' then 130000
when p.Gender like 'M%' and m.ExpectedSalary5years like '%131k to 150k%' then 135000
when p.Gender like 'M%' and m.ExpectedSalary5years like '%30k to 50k%' then 50000
else 0 end) as Average_5_Years_Salary_for_Males,
avg(Case when p.Gender like 'F%' and m.ExpectedSalary5years like '%91k to 110k%' then 110000
when p.Gender like 'F%' and m.ExpectedSalary5years like '%50k to 70k%' then 75000
when p.Gender like 'F%' and m.ExpectedSalary5years like '%>151k%' then 150000
when p.Gender like 'F%' and m.ExpectedSalary5years like '%71k to 90k%' then 90000  
when p.Gender like 'F%' and m.ExpectedSalary5years like '%111k to 130k%' then 130000
when p.Gender like 'F%' and m.ExpectedSalary5years like '%131k to 150k%' then 135000
when p.Gender like 'F%' and m.ExpectedSalary5years like '%30k to 50k%' then 50000
else 0 end) as Average_5_Years_Salary_for_Males,
avg(Case when p.Gender like 'M%' and m.ExpectedSalary5years like '%91k to 110k%' then 110000
when p.Gender like 'T%' and m.ExpectedSalary5years like '%50k to 70k%' then 75000
when p.Gender like 'T%' and m.ExpectedSalary5years like '%>151k%' then 150000
when p.Gender like 'T%' and m.ExpectedSalary5years like '%71k to 90k%' then 90000  
when p.Gender like 'T%' and m.ExpectedSalary5years like '%111k to 130k%' then 130000
when p.Gender like 'T%' and m.ExpectedSalary5years like '%131k to 150k%' then 135000
when p.Gender like 'T%' and m.ExpectedSalary5years like '%30k to 50k%' then 50000
else 0 end) as Average_5_Years_Salary_for_Transgenders
from india_pincode I
join personalized_info as p
on p.ZipCode = I.Pincode
join mission_aspirations as m
on m.ResponseID = p.ResponseID
group by I.State;



-- Average higher bar salary for 3 years  gender wise for each State

select I.State,
avg(Case when p.Gender like 'M%' and m.ExpectedSalary3years = '31k to 40k' then 40000
when p.Gender like 'M%' and m.ExpectedSalary3years = '>50k' then 50000
else 0 end) as Average_Higherbar3years_Salary_Males,
avg(Case when p.Gender like 'F%' and m.ExpectedSalary3years = '31k to 40k' then 40000
when p.Gender like 'F%' and m.ExpectedSalary3years = '>50k' then 50000
else 0 end) as Average_Higherbar3years_Salary_Males,
avg(Case when p.Gender like 'T%' and m.ExpectedSalary3years = '31k to 40k' then 40000
when p.Gender like 'T%' and m.ExpectedSalary3years = '>50k' then 50000
else 0 end) as Average_Higherbar3years_Salary_Males
from india_pincode I
join personalized_info as p
on p.ZipCode = I.Pincode
join mission_aspirations as m
on m.ResponseID = p.ResponseID
group by I.State;



-- Average higher bar salary for 5 years  gender wise for each State

select I.State,
avg(Case when p.Gender like 'M%' and m.ExpectedSalary5years like '%>151k%' then 150000
when p.Gender like 'M%' and m.ExpectedSalary5years like '%131k to 150k%' then 135000
else 0 end) as Average_Higherbar3years_Salary_Males,
avg(Case when p.Gender like 'F%' and m.ExpectedSalary5years like '%>151k%' then 150000
when p.Gender like 'F%' and m.ExpectedSalary5years like '%131k to 150k%' then 135000
else 0 end) as Average_Higherbar3years_Salary_Males,
avg(Case when p.Gender like 'T%' and m.ExpectedSalary5years like '%>151k%' then 150000
when p.Gender like 'T%' and m.ExpectedSalary5years like '%131k to 150k%' then 135000
else 0 end) as Average_Higherbar3years_Salary_Males
from india_pincode I
join personalized_info as p
on p.ZipCode = I.Pincode
join mission_aspirations as m
on m.ResponseID = p.ResponseID
group by I.State;


-- Possibility of GenZ working for org where mission is misaligned

select I.State,
concat(round(sum(case when m.MisalignedMissionLikelihood = 'Will work for them' then 1 else 0 end)/
count(m.MisalignedMissionLikelihood)*100, 2), '%')
 as Possibility
from india_pincode I
join personalized_info p
on p.ZipCode = I.Pincode
join mission_aspirations m
on m.ResponseID = p.ResponseID
Group by I.State