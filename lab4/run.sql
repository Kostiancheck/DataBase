--trigger check
INSERT INTO COUNTRY(country) VALUES('Ukraine');

--procedure check
EXEC country_tourist_del('Switzerland', 'basdb');
EXEC country_tourist_del('Switzerland', 'Kostia');
EXEC country_tourist_del('AAAAA', 'Bobanische');


--function check
SELECT * FROM TABLE ( get_happines_score('Canada', 2015) );