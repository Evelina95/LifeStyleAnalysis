SELECT * FROM diet_data;
SELECT * FROM person_info;
SELECT * FROM workout_data;
/*workout frequency by age group*/
SELECT 
  CASE 
    WHEN age BETWEEN 18 AND 25 THEN '18-25'
    WHEN age BETWEEN 26 AND 35 THEN '26-35'
    WHEN age BETWEEN 36 AND 45 THEN '36-45'
    WHEN age BETWEEN 46 AND 60 THEN '46-60'
    ELSE '60+' 
  END AS age_group,
  AVG(workout_frequency) AS avg_workout_frequency,
  COUNT(*) AS people_count
FROM person_info
GROUP BY age_group
ORDER BY avg_workout_frequency DESC;

/*Top workout by gender*/
SELECT p.gender, w.workout_type, COUNT(*) AS workout_count
FROM workout_data w
INNER JOIN person_info p using(person_id)
GROUP BY gender, workout_type
ORDER BY workout_count desc;
/*average age, BMI, and body fat percentage for each gender*/
SELECT 
    gender,
    ROUND(AVG(age), 1) AS avg_age,
    ROUND(AVG(bmi), 1) AS avg_bmi,
    ROUND(AVG(fat_percentage), 1) AS avg_fat
FROM person_info
GROUP BY gender;
/*avarage daily macros intakes by gender*/
SELECT 
    p.gender,
    ROUND(AVG(d.proteins_g), 1) AS avg_protein,
    ROUND(AVG(d.carbs_g), 1) AS avg_carbs,
    ROUND(AVG(d.fats_g), 1) AS avg_fats,
    ROUND(AVG(d.calories), 1) AS avg_daily_calories
FROM diet_data d
JOIN person_info p ON d.person_id = p.person_id
GROUP BY p.gender;

 /*Activity by experience level*/
 -- more experience , session duration last longer and burned more calories 
SELECT 
    p.experience_level,
    ROUND(AVG(w.session_duration_hours), 2) AS avg_session_duration,
    ROUND(AVG(w.calories_burned), 1) AS avg_calories_burned
FROM workout_data w
JOIN person_info p ON w.person_id = p.person_id
GROUP BY p.experience_level
ORDER BY p.experience_level;
/*proteine intake by experience level*/
SELECT 
    p.experience_level,
    ROUND(AVG(d.proteins_g / (d.carbs_g + d.fats_g)), 2) AS protein_ratio
FROM diet_data d
JOIN person_info p ON d.person_id = p.person_id
GROUP BY p.experience_level;
/*workout_frequency and BMI*/
SELECT 
    CASE 
        WHEN workout_frequency <= 2 THEN 'Low (0-2 per week)'
        WHEN workout_frequency BETWEEN 3 AND 5 THEN 'Medium (3-5 per week)'
        ELSE 'High (6+ per week)'
    END AS workout_level,
    ROUND(AVG(bmi), 1) AS avg_bmi,
    COUNT(*) AS people_count
FROM person_info
GROUP BY workout_level
ORDER BY avg_bmi;

/*What type of activity burns more calories*/
SELECT 
    workout_type,
    ROUND(AVG(calories_burned), 1) AS avg_calories_burned,
    ROUND(AVG(session_duration_hours), 2) AS avg_duration
FROM workout_data
GROUP BY workout_type
ORDER BY avg_calories_burned DESC;

/*If you train more , you eat more?*/
SELECT 
    workout_frequency,
    ROUND(AVG(d.calories), 1) AS avg_calories_intake
FROM person_info p
JOIN diet_data d ON p.person_id = d.person_id
GROUP BY workout_frequency
ORDER BY workout_frequency;

/*Activity and nutrition*/
SELECT 
    p.gender,
    CASE 
        WHEN workout_frequency <= 2 THEN 'Low activity'
        WHEN workout_frequency BETWEEN 3 AND 5 THEN 'Moderate activity'
        ELSE 'High activity'
    END AS activity_level,
    ROUND(AVG(d.calories), 0) AS avg_calories,
    ROUND(AVG(d.proteins_g), 1) AS avg_protein,
    ROUND(AVG(d.carbs_g), 1) AS avg_carbs,
    ROUND(AVG(d.fats_g), 1) AS avg_fats
FROM person_info p
JOIN diet_data d USING(person_id)
GROUP BY p.gender, activity_level
ORDER BY p.gender, avg_calories DESC;
/*How many calories burnt per hour?*/
SELECT 
    workout_type,
    ROUND(AVG(calories_burned / session_duration_hours), 1) AS calories_per_hour
FROM workout_data
GROUP BY workout_type
ORDER BY calories_per_hour DESC;

/*Does people with bigger IBM train more?*/
SELECT 
    CASE 
        WHEN bmi < 18.5 THEN 'Underweight'
        WHEN bmi BETWEEN 18.5 AND 24.9 THEN 'Normal'
        WHEN bmi BETWEEN 25 AND 29.9 THEN 'Overweight'
        ELSE 'Obese'
    END AS bmi_category,
    ROUND(AVG(workout_frequency), 1) AS avg_workouts_per_week,
    COUNT(*) AS people_count
FROM person_info
GROUP BY bmi_category
ORDER BY avg_workouts_per_week DESC;

/*gender + activitie*/
SELECT 
    gender,
    experience_level,
    ROUND(AVG(workout_frequency), 1) AS avg_workouts
FROM person_info
GROUP BY gender, experience_level
ORDER BY gender, avg_workouts DESC;

/*Are experienced people eat more proteine?*/
SELECT 
    p.experience_level,
    ROUND(AVG(d.proteins_g / p.weight_kg), 2) AS protein_per_kg
FROM diet_data d
JOIN person_info p USING(person_id)
GROUP BY p.experience_level
ORDER BY protein_per_kg DESC;




















