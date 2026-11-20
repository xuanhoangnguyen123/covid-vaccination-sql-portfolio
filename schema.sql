PRAGMA foreign_keys = ON;

CREATE TABLE Source (
    SourceID INTEGER PRIMARY KEY,
    SourceName TEXT,
    SourceWebsite TEXT
);

CREATE TABLE GlobalLocation (
    ISOCode TEXT PRIMARY KEY,
    LocationName TEXT NOT NULL,
    SourceID INTEGER,
    FOREIGN KEY (SourceID) REFERENCES Source(SourceID)
);

CREATE TABLE USLocation (
    USLocationName TEXT PRIMARY KEY,
    ISOCode TEXT NOT NULL,
    FOREIGN KEY (ISOCode) REFERENCES GlobalLocation(ISOCode)
);

CREATE TABLE Vaccine (
    VaccineName TEXT PRIMARY KEY NOT NULL
);

CREATE TABLE AgeGroup (
    AgeGroupName TEXT PRIMARY KEY NOT NULL
);

CREATE TABLE GlobalVaccination (
    ISOCode TEXT NOT NULL,
    Date TEXT NOT NULL,
    TotalVaccinations INTEGER,
    PeopleVaccinated INTEGER,
    PeopleFullyVaccinated INTEGER,
    TotalBoosters INTEGER,
    DailyVaccinationsRaw INTEGER,
    DailyVaccinations INTEGER,
    DailyPeopleVaccinated INTEGER,
    TotalVaccinationsPerHundred REAL,
    PeopleVaccinatedPerHundred REAL,
    PeopleFullyVaccinatedPerHundred REAL,
    TotalBoostersPerHundred REAL,
    DailyVaccinationsPerMillion REAL,
    DailyPeopleVaccinatedPerHundred REAL,
    SourceID INTEGER,

    PRIMARY KEY (ISOCode, Date),
    FOREIGN KEY (ISOCode) REFERENCES GlobalLocation(ISOCode),
    FOREIGN KEY (SourceID) REFERENCES Source(SourceID)
);

CREATE TABLE USVaccination (
    USLocationName TEXT NOT NULL,
    Date TEXT NOT NULL,
    TotalVaccinations INTEGER,
    TotalDistributed INTEGER,
    DistributedPerHundred REAL,
    PeopleVaccinated INTEGER,
    PeopleFullyVaccinated INTEGER,
    TotalBoosters INTEGER,
    TotalBoostersPerHundred REAL,
    DailyVaccinationsRaw INTEGER,
    DailyVaccinations INTEGER,
    DailyVaccinationsPerMillion REAL,
    ShareDosesUsed REAL,
    TotalVaccinationsPerHundred REAL,
    PeopleVaccinatedPerHundred REAL,
    PeopleFullyVaccinatedPerHundred REAL,

    PRIMARY KEY (USLocationName, Date),
    FOREIGN KEY (USLocationName) REFERENCES USLocation(USLocationName)
);

CREATE TABLE AgeGroupVaccination (
    ISOCode TEXT NOT NULL,
    AgeGroupName TEXT NOT NULL,
    Date TEXT NOT NULL,
    PeopleVaccinatedPerHundred REAL,
    PeopleFullyVaccinatedPerHundred REAL,
    PeopleWithBoosterPerHundred REAL,

    PRIMARY KEY (ISOCode, AgeGroupName, Date),
    FOREIGN KEY (ISOCode) REFERENCES GlobalLocation(ISOCode),
    FOREIGN KEY (AgeGroupName) REFERENCES AgeGroup(AgeGroupName)
);

CREATE TABLE ManufacturerVaccination (
    ISOCode TEXT NOT NULL,
    VaccineName TEXT NOT NULL,
    Date TEXT NOT NULL,
    TotalVaccinations INTEGER,

    PRIMARY KEY (ISOCode, VaccineName, Date),
    FOREIGN KEY (ISOCode) REFERENCES GlobalLocation(ISOCode),
    FOREIGN KEY (VaccineName) REFERENCES Vaccine(VaccineName)
);

CREATE TABLE LocationVaccine (
    ISOCode TEXT NOT NULL,
    VaccineName TEXT NOT NULL,

    PRIMARY KEY (ISOCode, VaccineName),
    FOREIGN KEY (ISOCode) REFERENCES GlobalLocation(ISOCode),
    FOREIGN KEY (VaccineName) REFERENCES Vaccine(VaccineName)
);

CREATE TABLE ObservationVaccine (
    ISOCode TEXT NOT NULL,
    Date TEXT NOT NULL,
    VaccineName TEXT NOT NULL,

    PRIMARY KEY (ISOCode, Date, VaccineName),
    FOREIGN KEY (ISOCode, Date)
        REFERENCES GlobalVaccination(ISOCode, Date),
    FOREIGN KEY (VaccineName)
        REFERENCES Vaccine(VaccineName)
);
