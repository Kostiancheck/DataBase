import csv
import cx_Oracle

username = 'Kostia'
password = 'Kostia'
database = 'localhost/xe'

connection = cx_Oracle.connect(username, password, database)
cursor = connection.cursor()

query = '''
SELECT
        country,
        region,
        happiness_score,
        economy,
        family,
        health,
        freedom,
        trust,
        generosity,
        dystopia_residual
FROM
    happiness_region'''
cursor.execute(query)

with open("my_csv_2015.csv", "w", newline="\n") as file:
    writer = csv.writer(file)

    writer.writerow('Country,Region,Happiness Score,Economy (GDP per Capita),\
    Family,Health (Life Expectancy),Freedom, Trust (Government Corruption),\
    Generosity,Dystopia Residual'.split(','))

    for (country, region, happiness_score, economy, family, health, freedom, trust, generosity,
         dystopia_residual) in cursor:

        writer.writerow([country, region, round(happiness_score, 3), economy, family, health, freedom, trust, generosity,
                         dystopia_residual])

cursor.close()

