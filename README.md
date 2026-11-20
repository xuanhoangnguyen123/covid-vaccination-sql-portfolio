# COVID-19 Vaccination Database

SQLite reporting project from RMIT University Database Concepts coursework. I designed an 11-table relational schema and used SQL to report cumulative vaccination doses and compare daily vaccination coverage across six reporting locations.

## Reports

| Report | SQL approach | Rows in the original coursework database |
|---|---|---:|
| [Cumulative doses](cumulative_doses.sql) | Join observations to location names and filter for sourced, non-null totals through 31 December 2021 | 34,406 |
| [Daily coverage](daily_coverage.sql) | Group by date and use conditional aggregation to compare fully vaccinated people per hundred across six locations during 2021–2022 | 730 |

The original global vaccination table contained 196,246 observations. The CSV examples in this repo use synthetic values. A missing location-date observation appears as a blank cell, representing SQL NULL.

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

## Run the demo

Run these commands from the repo root with the SQLite CLI installed.

```sh
cat schema.sql demo_data.sql cumulative_doses.sql | sqlite3 -cmd ".mode csv" -cmd ".headers on" :memory:
cat schema.sql demo_data.sql daily_coverage.sql | sqlite3 -cmd ".mode csv" -cmd ".headers on" :memory:
```

Expected output is in [cumulative_doses_example.csv](cumulative_doses_example.csv) and [daily_coverage_example.csv](daily_coverage_example.csv).
