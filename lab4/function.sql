SET SERVEROUTPUT ON;
--функція виводить країну та рівень щастя в ній за певний рік
--Для спрощення свого життя я залишив лише показники economy та dystopia residual 
--Але вона не працює. Я не знаю чому, але ця функція не працює
CREATE OR REPLACE TYPE country_happinesscore IS OBJECT (
    country         varchar2(100),
    happinesscore   FLOAT(100)
);
/
CREATE OR REPLACE TYPE country_happinesscore_table IS TABLE OF country_happinesscore;
/


CREATE OR REPLACE FUNCTION get_happines_score ( country_name in country.country%TYPE,
                                                year_ in integer
) RETURN country_happinesscore_table
PIPELINED AS
country   varchar2(100);
happinesscore   FLOAT(100);
CURSOR c1 is SELECT
    country_economy.country_country,
    (country_economy.economy + country_dystopia_residual.dystopia_residual ) as "happiness score"
FROM
    country_economy 
    INNER JOIN country_dystopia_residual ON country_dystopia_residual.country_country = country_economy.country_country
                                  AND country_dystopia_residual.datetime = country_economy.datetime
WHERE
    country_economy.country_country = country_name
    AND EXTRACT(YEAR FROM country_economy.datetime) = year_;
    
BEGIN
OPEN c1;
LOOP
FETCH c1
    INTO country, happinesscore;
    EXIT WHEN c1 % NOTFOUND;
    PIPE ROW(country_happinesscore(country, happinesscore));
    END LOOP; 
END get_happines_score;
/
