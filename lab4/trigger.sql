CREATE OR REPLACE TRIGGER economy_trigger 
AFTER INSERT ON country
FOR EACH ROW
BEGIN
    INSERT INTO country_economy
   ( country_country,
     economy,
     datetime)
   VALUES
   ( :new.country,
     0,
     '01012015' ); 
END;
/

--INSERT INTO COUNTRY(country) VALUES('Ukraine');
