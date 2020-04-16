import cx_Oracle

username = 'Kostia'
password = 'Kostia'
database = 'localhost/xe'

connection = cx_Oracle.connect(username, password, database)
cursor = connection.cursor()

print('1. Вивести регіон та середній рівень щастя в ньому \n')
query1 = '''
SELECT countryregion.region, round(AVG(countryhappinesscore.happiness_score), 3) as "happines score"
FROM countryhappinesscore
INNER JOIN countryregion
ON countryregion.country = countryhappinesscore.country
GROUP BY   countryregion.region
'''

cursor.execute(query1)

result1 = cursor.fetchall()
for el in result1: print(el)

print('\n\n2. Вивести скільки відсотків складає рівень щастя в Україні від рівня щастя в найщасливішій країні \n')
query2 = '''
SELECT  round(countryhappinesscore.happiness_score/ max.maximum*100, 4) as percent
FROM countryhappinesscore
     ,(SELECT MAX(countryhappinesscore.happiness_score) as maximum
     FROM countryhappinesscore) max
WHERE countryhappinesscore.country = 'Ukraine'
'''

cursor.execute(query2)

result2 = cursor.fetchall()
for el in result2: print(el)

print('\n\n3. Вивести залежність рівня щастя від рівня здоров\'я \n')
query3 = '''
SELECT  happiness_score, AVG(health) as health
FROM countryhappinesscore
GROUP BY happiness_score
ORDER BY health
'''

cursor.execute(query3)

result3 = cursor.fetchall()
for el in result3: print(el)

# Close connection
cursor.close()
connection.close()
