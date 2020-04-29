---First query
---Вивести регіон та середній рівень щастя в ньому.

--SELECT countryregion.region, round(AVG(countryhappinesscore.happiness_score), 3) as "happines score"
--FROM countryhappinesscore
--INNER JOIN countryregion
--ON countryregion.country = countryhappinesscore.country
--GROUP BY   countryregion.region;

---------------------------------------------

---Second query
---Вивести скільки відсотків складає рівень щастя в Україні від рівня щастя в найщасливішій країні

--SELECT  round(countryhappinesscore.happiness_score/ max.maximum*100, 4) as percent
--FROM countryhappinesscore 
--     ,(SELECT MAX(countryhappinesscore.happiness_score) as maximum
--     FROM countryhappinesscore) max
--WHERE countryhappinesscore.country = 'Ukraine'

---------------------------------------------

---Third query
---Вивести залежність рівня щастя від рівня здоров'я 

--SELECT  happiness_score, AVG(health) as health
--FROM countryhappinesscore
--GROUP BY happiness_score
--ORDER BY health;


