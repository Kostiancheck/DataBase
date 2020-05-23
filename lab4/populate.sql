SET DEFINE OFF

INSERT INTO country ( country ) VALUES ( 'Switzerland' );

INSERT INTO country ( country ) VALUES ( 'Canada' );

INSERT INTO country ( country ) VALUES ( 'Australia' );

INSERT INTO region ( region ) VALUES ( 'Western Europe' );

INSERT INTO region ( region ) VALUES ( 'North America' );

INSERT INTO region ( region ) VALUES ( 'Australia and New Zealand' );

INSERT INTO country_region (
    country_country,
    region_region,
    datetime
) VALUES (
    'Switzerland',
    'Western Europe',
    '24041880'
);

INSERT INTO country_region (
    country_country,
    region_region,
    datetime
) VALUES (
    'Canada',
    'North America',
    '24041670'
);

INSERT INTO country_region (
    country_country,
    region_region,
    datetime
) VALUES (
    'Australia',
    'Australia and New Zealand',
    '24041600'
);

INSERT INTO country_dystopia_residual (
    country_country,
    dystopia_residual,
    datetime
) VALUES (
    'Switzerland',
    2.51738,
    '01012015'
);

INSERT INTO country_dystopia_residual (
    country_country,
    dystopia_residual,
    datetime
) VALUES (
    'Canada',
    2.45176,
    '01012015'
);

INSERT INTO country_dystopia_residual (
    country_country,
    dystopia_residual,
    datetime
) VALUES (
    'Australia',
    2.26646,
    '01012015'
);

INSERT INTO country_economy (
    country_country,
    economy,
    datetime
) VALUES (
    'Switzerland',
    1.39651,
    '01012015'
);

INSERT INTO country_economy (
    country_country,
    economy,
    datetime
) VALUES (
    'Canada',
    1.32629,
    '01012015'
);

INSERT INTO country_economy (
    country_country,
    economy,
    datetime
) VALUES (
    'Australia',
    1.33358,
    '01012015'
);

INSERT INTO person ( name ) VALUES ( 'Bob' );

INSERT INTO person ( name ) VALUES ( 'Kostia' );

INSERT INTO person ( name ) VALUES ( 'Misha' );

INSERT INTO tourist (
    person_name,
    country_country,
    datetime
) VALUES (
    'Bob',
    'Switzerland',
    '01012015'
);

INSERT INTO tourist (
    person_name,
    country_country,
    datetime
) VALUES (
    'Bob',
    'Canada',
    '01012015'
);

INSERT INTO tourist (
    person_name,
    country_country,
    datetime
) VALUES (
    'Kostia',
    'Australia',
    '01012015'
);

