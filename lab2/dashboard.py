import cx_Oracle
import re
import chart_studio
import plotly.graph_objects as go
import chart_studio.plotly as py
import chart_studio.dashboard_objs as dashboard


def fileId_from_url(url):
    """Return fileId from a url."""
    raw_fileId = re.findall("~[A-z.]+/[0-9]+", url)[0][1:]
    return raw_fileId.replace('/', ':')


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

'''Create dashboard'''

# Connect to our char_studio account
chart_studio.tools.set_credentials_file(username='gorbach.kostia', api_key='GD9ZDiJXr9lOP9aWRoCF')

# First graph
countries = list(map(lambda x: x[0], result1))
average_happiness = list(map(lambda x: x[1], result1))
bar = go.Bar(x=countries, y=average_happiness, marker_color='lightsalmon', name="Рівень щастя в регіоні")
layout = go.Layout(
    title='Рівень щастя в регіоні',
    xaxis=dict(
        title='Регіон',
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    ),
    yaxis=dict(
        title='Рівень щастя',
        rangemode='nonnegative',
        autorange=True,
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    )
)
fig = go.Figure(data=bar, layout=layout)
region_happiness = py.plot(fig, filename='Average Happiness')

# Second graph
ukraine_happiness = float(result2[0][0])
rest = 100 - ukraine_happiness
pie = go.Pie(labels=['Ukraine', 'rest'], values=[ukraine_happiness, rest],
             textinfo='label+percent', title="Відношення рівня щастя в Україні до рівня щастя в найщасливішій країні")
ukraine_happiness_percent = py.plot([pie], filename='Pie')

# Third graph
x_values = list(map(lambda x: x[1], result3))
y_values = list(map(lambda x: x[0], result3))
x_values.sort()
y_values.sort()

line1 = [go.Scatter(
    x=x_values,
    y=y_values,
)]

layout = go.Layout(
    title="Залежність рівня щастя від рівня здоров'я",
    xaxis=dict(
        title="Здоров'я",
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    ),
    yaxis=dict(
        title='Щастя',
        rangemode='nonnegative',
        autorange=True,
        titlefont=dict(
            family='Courier New, monospace',
            size=18,
            color='#7f7f7f'
        )
    )
)
fig = go.Figure(data=line1, layout=layout)
health_happiness_depend = py.plot(fig, filename='Dynamics')

# Create dashboard
my_dboard = dashboard.Dashboard()

region_happiness_id = fileId_from_url(region_happiness)
ukraine_happiness_percent_id = fileId_from_url(ukraine_happiness_percent)
health_happiness_depend_id = fileId_from_url(health_happiness_depend)
box_1= {
    'type': 'box',
    'boxType': 'plot',
    'fileId': region_happiness_id,
    'title': 'Рівень щастя в регіоні'
}

box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': ukraine_happiness_percent_id,
    'title': 'Відношення рівня щастя в Україні до рівня щастя в найщасливішій країні'
}

box_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': health_happiness_depend_id,
    'title': 'Залежність рівня щастя від рівня здоров\'я'
}

my_dboard.insert(box_3)
my_dboard.insert(box_2, 'below', 1)
my_dboard.insert(box_1, 'right', 2)

py.dashboard_ops.upload(my_dboard, 'Be happy')


