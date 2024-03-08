use GenZDataset;
show Tables ;

select * from learning_aspirations;
select * from manager_aspirations;
select * from mission_aspirations;
select * from personalized_info;


#count of males responded to the survey#

select count(Gender) from personalized_info
where Gender like ('M%');

#count of Females responded to the survey#

select count(Gender) from personalized_info
where Gender like ('F%');



#No. of Genz Influenced by their Parents In India

select count(learning_aspirations.CareerInfluenceFactor) as Ifluenced_by_Parents 
from learning_aspirations
join personalized_info
on personalized_info.ResponseID = learning_aspirations.ResponseID
where learning_aspirations.CareerInfluenceFactor = 'My Parents' 
and personalized_info.CurrentCountry = 'India';

# No. of Females Influenced by their Parents in India

select count(personalized_info.Gender) as Ifluenced_by_Parents 
from learning_aspirations
join personalized_info
on personalized_info.ResponseID = learning_aspirations.ResponseID
where personalized_info.Gender like ('Female%') 
and learning_aspirations.CareerInfluenceFactor = 'My Parents' 
and personalized_info.CurrentCountry = 'India';

# No. of Males Influenced by their Parents in India

select count(personalized_info.Gender) as Ifluenced_by_Parents from learning_aspirations
join personalized_info
on personalized_info.ResponseID = learning_aspirations.ResponseID
where personalized_info.Gender like ('Male%') 
and learning_aspirations.CareerInfluenceFactor = 'My Parents' 
and personalized_info.CurrentCountry = 'India';

# No. of Males & Females(Separately) Influenced by their Parents

Select sum(case when Gender like ('Male%') then 1 else 0 end) as Count_of_Males_Influenced_by_Parents,
sum(case when Gender like ('Female%') then 1 else 0 end) as Count_of_Females_Influenced_by_Parents
from personalized_info
join learning_aspirations
on personalized_info.ResponseID = learning_aspirations.ResponseID
where learning_aspirations.CareerInfluenceFactor = 'My Parents' 
and personalized_info.CurrentCountry = 'India';

# No of GenZ who are Influenced by Media & Influencers

Select count(CareerInfluenceFactor) as Count_of_Genz_Influenced_by_Media_Influencers from learning_aspirations
where CareerInfluenceFactor in ('Social Media Like LinkedIn', 'Influencers who had successful careers');

# No of Males & Females(Separately) who are Influenced by Media & Influencers in India

Select sum(case when Gender like ('Male%') then 1 else 0 end) 
as Count_of_Males_Influenced_by_Media_Influencers,
sum(case when Gender like ('Female%') then 1 else 0 end) 
as Count_of_Females_Influenced_by_Media_Influencers
from personalized_info
join learning_aspirations
on personalized_info.ResponseID = learning_aspirations.ResponseID
where learning_aspirations.CareerInfluenceFactor 
in ('Social Media like LinkedIn', 'Influencers who had successful careers')
and personalized_info.CurrentCountry = 'India';

# No of GennZ Influenced by Media and want to go Abroad

select Count(CareerInfluenceFactor) from learning_aspirations
where CareerInfluenceFactor like ('Social Media%') and HigherEducationAbroad like ('Yes%');

# No of GennZ Influenced by their circle and want to go Abroad

select Count(CareerInfluenceFactor) from learning_aspirations
where CareerInfluenceFactor like ('People from%') and HigherEducationAbroad like ('Yes%');



