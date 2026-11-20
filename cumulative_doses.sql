-- Cumulative COVID-19 vaccine doses by reporting location and date
SELECT
    GL.LocationName AS Country,
    CAST(strftime('%Y', GV.Date) AS INTEGER) AS OY,
    CAST(strftime('%m', GV.Date) AS INTEGER) AS OM,
    CAST(strftime('%d', GV.Date) AS INTEGER) AS OD,
    GV.TotalVaccinations AS "Cumulative Doses"
FROM GlobalVaccination AS GV
JOIN GlobalLocation AS GL
    ON GV.ISOCode = GL.ISOCode
WHERE GV.Date <= '2021-12-31'
    AND GV.TotalVaccinations IS NOT NULL
    AND GL.SourceID IS NOT NULL
ORDER BY GV.Date ASC, GL.LocationName ASC;
