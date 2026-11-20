-- Fully vaccinated people per hundred across six locations, 2021–2022
SELECT
    CAST(strftime('%Y', Date) AS INTEGER) AS OY,
    CAST(strftime('%m', Date) AS INTEGER) AS OM,
    CAST(strftime('%d', Date) AS INTEGER) AS OD,
    MAX(CASE WHEN ISOCode = 'AUS'
        THEN PeopleFullyVaccinatedPerHundred END) AS Australia,
    MAX(CASE WHEN ISOCode = 'DEU'
        THEN PeopleFullyVaccinatedPerHundred END) AS Germany,
    MAX(CASE WHEN ISOCode = 'USA'
        THEN PeopleFullyVaccinatedPerHundred END) AS US,
    MAX(CASE WHEN ISOCode = 'OWID_ENG'
        THEN PeopleFullyVaccinatedPerHundred END) AS England,
    MAX(CASE WHEN ISOCode = 'FRA'
        THEN PeopleFullyVaccinatedPerHundred END) AS France,
    MAX(CASE WHEN ISOCode = 'NLD'
        THEN PeopleFullyVaccinatedPerHundred END) AS Netherlands
FROM GlobalVaccination
WHERE Date BETWEEN '2021-01-01' AND '2022-12-31'
    AND ISOCode IN ('AUS', 'DEU', 'USA', 'OWID_ENG', 'FRA', 'NLD')
GROUP BY Date
ORDER BY Date ASC;
