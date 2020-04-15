CREATE TABLE HappinesRank (
    happines_score INT NOT NULL PRIMARY KEY
    ,hapinnes_rank INT NOT NULL
);


CREATE TABLE CountryRegion (
    country VARCHAR(100) NOT NULL PRIMARY KEY
    ,region VARCHAR(150) NOT NULL
);

CREATE TABLE CountryHappinesScore(
    country  VARCHAR(100)  NOT NULL PRIMARY KEY
    , happines_score  INT NOT NULL REFERENCES HappinesRank(happines_score)
    , economy  FLOAT(126)
    , family 	FLOAT(126)
    , health 	FLOAT(126)
    , freedom 	FLOAT(126)
    , trust 	FLOAT(126)
    , generosity 	FLOAT(126)

)
