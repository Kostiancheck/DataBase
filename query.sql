---First query
---������� ����� �� ������� ����� ����� � �����.

--SELECT countryregion.region, AVG(countryhappinesscore.happines_score)
--FROM countryhappinesscore
--INNER JOIN countryregion
--ON countryregion.country = countryhappinesscore.country
--GROUP BY   countryregion.region;

---------------------------------------------

---Second query
---������� ������ ������� ������ ����� ����� � ����� �� ���� ����� � ������������ ����

--SELECT  round(countryhappinesscore.happines_score/ max.maximum*100, 4) as percent
--FROM countryhappinesscore 
--     ,(SELECT MAX(countryhappinesscore.happines_score) as maximum
--     FROM countryhappinesscore) max
--WHERE countryhappinesscore.country = 'Ukraine'

---------------------------------------------

---Third query
---������� ��������� ���� ����� �� ���� ������'� 

--SELECT  happines_score, SUM(health)
--FROM countryhappinesscore
--GROUP BY happines_score;



