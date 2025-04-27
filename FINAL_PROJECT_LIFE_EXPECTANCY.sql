---imported csv and checking denormalized table
select *
from [Life Expectancy Data]

--- creating tables for normalization
CREATE TABLE Country (
    CountryID INT IDENTITY(1,1) PRIMARY KEY,
    CountryName NVARCHAR(100),
    CONSTRAINT UQ_Country UNIQUE (CountryName)
);
CREATE TABLE Years (
    YearID INT IDENTITY(1,1) PRIMARY KEY,
    YearName NVARCHAR(100),
    CONSTRAINT UQ_Year UNIQUE (YearName)

);

CREATE TABLE Statuses (
    StatusID INT IDENTITY(1,1) PRIMARY KEY,
    StatusName NVARCHAR(100),
    CONSTRAINT UQ_Status UNIQUE (StatusName)
);

	CREATE TABLE Life_expectancy_fact (
    IdCountry INT FOREIGN KEY REFERENCES Country(CountryID),
	IdYear INT FOREIGN KEY REFERENCES Years(YearID),
	IdStatus INT FOREIGN KEY REFERENCES Statuses(StatusID),
    Life_expectancy float,
    Adult_Mortality int,
	infant_deaths int,
	Alcohol float,
	percentage_expenditure float,
	Hepatitis_B int,
	Measles int,
	BMI float,
	under_five_deaths float,
	Polio int,
	Total_expenditure float,
	Diphtheria int,
	HIV_AIDS float,
	GDP float,
	Populat int,
	thinness_1_19_years float,
	thinness_5_9_years float,
	Income_composition_of_resources float,
	Schooling float
);

---importing data into the tables

-- Country
INSERT INTO Country(CountryName)
SELECT DISTINCT Country
FROM [Life Expectancy Data]
;

-- Years
INSERT INTO Years(YearName)
SELECT DISTINCT "Year"
FROM [Life Expectancy Data]
;

-- Statuses
INSERT INTO Statuses(StatusName)
SELECT DISTINCT "Status"
FROM [Life Expectancy Data]
;

--Life_expectancy_fact
INSERT INTO Life_expectancy_fact(
    IdCountry,
    IdYear,
    IdStatus,
    Life_expectancy,
    Adult_Mortality,
    infant_deaths,
    Alcohol,
    percentage_expenditure,
    Hepatitis_B,
    Measles,
    BMI,
    under_five_deaths,
    Polio,
    Total_expenditure,
    Diphtheria,
    HIV_AIDS,
    GDP,
    Populat,
    thinness_1_19_years,
    thinness_5_9_years,
    Income_composition_of_resources,
    Schooling
)
SELECT 
    c.CountryID,
    y.YearID,
    s.StatusID,
    d.Life_expectancy,
    d.Adult_Mortality,
    d.infant_deaths,
    d.Alcohol,
    d.percentage_expenditure,
    d.Hepatitis_B,
    d.Measles,
    d.BMI,
    d.under_five_deaths,
    d.Polio,
    d.Total_expenditure,
    d.Diphtheria,
    d.HIV_AIDS,
    d.GDP,
    d.[Population],
    d.thinness_1_19_years,
    d.thinness_5_9_years,
    d.Income_composition_of_resources,
    d.Schooling
FROM [Life Expectancy Data] d
JOIN Country c ON c.CountryName = d.Country
JOIN Years y ON y.YearName = d.[Year]
JOIN Statuses s ON s.StatusName = d.Status;


