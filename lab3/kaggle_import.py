import csv
import cx_Oracle

username = 'Kostia'
password = 'Kostia'
database = 'localhost/xe'

connection = cx_Oracle.connect(username, password, database)
cursor = connection.cursor()

filename = "2015.csv"

with open(filename, newline='') as file:
    reader = csv.reader(file)
    for el in list(reader)[1:]:
        country = el[0]
        region = el[1]
        economy = el[5]
        family = el[6]
        health = el[7]
        freedom = el[8]
        trust = el[8]
        generosity = el[10]
        dystopia_residual = el[11]

        try:
            insert_query_region = '''INSERT INTO REGION (region)
                        VALUES (:region)'''
            cursor.execute(insert_query_region, region=region)
        except:
            print('already in database')

        insert_query_countryregion = '''INSERT INTO COUNTRYREGION (country, region)
                    VALUES (:country, :region)'''
        cursor.execute(insert_query_countryregion, country=country, region=region)

        insert_query_countryhappinesscore = '''INSERT INTO COUNTRYHAPPINESSCORE
                (country, economy, family, health, freedom, trust, generosity, dystopia_residual)
                    VALUES (:country, :economy, :family, :health, :freedom, :trust, :generosity, :dystopia_residual)'''
        cursor.execute(insert_query_countryhappinesscore, country=country, economy=economy, family=family,
                       health=health, freedom=freedom, trust=trust, generosity=generosity,
                       dystopia_residual=dystopia_residual)

    connection.commit()
    cursor.close()
    connection.close()