# COVID-19 Vaccination Database

SQLite reporting project from RMIT University Database Concepts coursework. I designed an 11-table relational schema and used SQL to report cumulative vaccination doses and compare daily vaccination coverage across six reporting locations.

## Reports

| Report | SQL approach | Rows in the original coursework database |
|---|---|---:|
| [Cumulative doses](cumulative_doses.sql) | Join observations to location names and filter for sourced, non-null totals through 31 December 2021 | 34,406 |
| [Daily coverage](daily_coverage.sql) | Group by date and use conditional aggregation to compare fully vaccinated people per hundred across six locations during 2021–2022 | 730 |

The original coursework database, [Vaccinations.db](Vaccinations.db), contains 196,246 observations in the global vaccination table. These are aggregate vaccination records. The database’s `Source` table records the source names and websites. A missing location-date observation appears as a blank cell in CSV output, representing SQL NULL.

## Schema

`GlobalVaccination` stores one observation per reporting location and date. Location, source, age group and vaccine details sit in separate tables. The links below show the foreign-key directions.

| Table | References |
|---|---|
| Source | |
| GlobalLocation | Source |
| USLocation | GlobalLocation |
| Vaccine | |
| AgeGroup | |
| GlobalVaccination | GlobalLocation, Source |
| USVaccination | USLocation |
| AgeGroupVaccination | GlobalLocation, AgeGroup |
| ManufacturerVaccination | GlobalLocation, Vaccine |
| LocationVaccine | GlobalLocation, Vaccine |
| ObservationVaccine | GlobalVaccination, Vaccine |

## Run the reports

From the repository root, use the SQLite CLI to query the original database in read-only mode.

```sh
sqlite3 -readonly -cmd ".mode csv" -cmd ".headers on" Vaccinations.db < cumulative_doses.sql
sqlite3 -readonly -cmd ".mode csv" -cmd ".headers on" Vaccinations.db < daily_coverage.sql
```
