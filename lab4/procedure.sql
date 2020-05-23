SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE country_tourist_del (
    country_name   VARCHAR2,
    tourist_name   VARCHAR2
) IS
    country_row          country%rowtype;
    person_row           person%rowtype;
    country_region_row   country_region%rowtype;
BEGIN
    SELECT
        *
    INTO country_row
    FROM
        country
    WHERE country.country = country_name;

    SELECT
        *
    INTO person_row
    FROM
        person
    WHERE person.name = tourist_name;

    DELETE FROM tourist
    WHERE
        tourist.person_name = tourist_name
        OR tourist.country_country = country_name;

    DELETE FROM country_region
    WHERE
        country_region.country_country = country_name;

    DELETE FROM country_dystopia_residual
    WHERE
        country_dystopia_residual.country_country = country_name;

    DELETE FROM country_economy
    WHERE
        country_economy.country_country = country_name;
        
    DELETE FROM country
    WHERE
        country.country = country_name;

    DELETE FROM person
    WHERE
        person.name = tourist_name;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Country or tourist does not exist !');
END country_tourist_del;
/
--


-- Я впевнений, що це не дуже правильна процедура.
-- Правильніше було б зробити як мінімум дві окремі процедури: для видалення країни
-- та для видалення туриста.
-- Але в завданні сказано лише про одну процедуру.

