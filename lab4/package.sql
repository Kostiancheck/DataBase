--DROP PACKAGE PROC_FUNC;

SET SERVEROUTPUT ON;

CREATE OR REPLACE PACKAGE proc_func AS
    TYPE country_happinesscore IS RECORD (
        country         VARCHAR2(100),
        happinesscore   FLOAT(100)
    );
    TYPE country_happinesscore_table IS
        TABLE OF country_happinesscore;
    PROCEDURE country_tourist_del (
        country_name   VARCHAR2,
        tourist_name   VARCHAR2
    );

    FUNCTION get_happines_score (
        country_name   IN   country.country%TYPE,
        year_          IN   INTEGER
    ) RETURN country_happinesscore_table
        PIPELINED;

END proc_func;
/

CREATE OR REPLACE PACKAGE BODY proc_func
AS
    PROCEDURE country_tourist_del (
        country_name   VARCHAR2,
        tourist_name   VARCHAR2
    ) IS
        country_row          country%rowtype;
        person_row           person%rowtype;
        country_region_row   country_region%rowtype;
    BEGIN
        SELECT * INTO country_row FROM country
        WHERE country.country = country_name;
        
        SELECT * INTO person_row FROM person
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
    
    FUNCTION get_happines_score (
        country_name   IN   country.country%TYPE,
        year_          IN   INTEGER
    ) RETURN country_happinesscore_table
        PIPELINED
    AS
        country         VARCHAR2(100);
        happinesscore   FLOAT(100);
        CURSOR cursore IS
        SELECT
            country_economy.country_country,
            ( country_economy.economy + country_dystopia_residual.dystopia_residual ) AS "happiness score"
        FROM
            country_economy
            INNER JOIN country_dystopia_residual ON country_dystopia_residual.country_country = country_economy.country_country
                                                    AND country_dystopia_residual.datetime = country_economy.datetime
        WHERE
            country_economy.country_country = country_name
            AND EXTRACT(YEAR FROM country_economy.datetime) = year_;

    BEGIN
        FOR curr IN cursore

            LOOP

                PIPE ROW (curr);

            END LOOP;
    END get_happines_score;

END proc_func;
/