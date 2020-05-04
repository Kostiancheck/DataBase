DECLARE
    country_count INTEGER := 20;
BEGIN
    INSERT INTO region(region) VALUES('Region' || 1);
    INSERT INTO region(region) VALUES('Region' || 2);
    FOR i IN 1..country_count LOOP IF ( i < 10 ) THEN

        INSERT INTO countryregion (
            country,
            region
        ) VALUES (
            'Country' || i,
            'Region' || 1
        );
        

    ELSE
        INSERT INTO countryregion (
            country,
            region
        ) VALUES (
            'Country' || i,
            'Region' || 2
        );

    END IF;
    END LOOP;

END;