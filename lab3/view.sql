CREATE OR REPLACE VIEW happiness_region AS
    SELECT
        countryregion.country AS country,
        countryhappinesscore.economy,
        countryhappinesscore.family,
        countryhappinesscore.health,
        countryhappinesscore.freedom,
        countryhappinesscore.trust,
        countryhappinesscore.generosity,
        countryhappinesscore.dystopia_residual,
        countryregion.region,
        (countryhappinesscore.economy + countryhappinesscore.family + countryhappinesscore.health + countryhappinesscore.freedom
        + countryhappinesscore.trust +
        countryhappinesscore.generosity + countryhappinesscore.dystopia_residual) as happiness_score
    FROM
        countryhappinesscore
        INNER JOIN countryregion ON countryregion.country = countryhappinesscore.country;

