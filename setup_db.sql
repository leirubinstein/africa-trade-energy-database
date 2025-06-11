-- setup_db.sql

-- duckdb data/africa_energy.db < setup_db.sql

-- Create individual tables with consistent column structure
CREATE OR REPLACE TABLE ida_indicators AS
SELECT 
    "Country Name" as country,
    "Series Name" as indicator, 
    "Year" as year,
    "Value" as value,
    'ida' as source
FROM read_csv_auto('data/cleaned_data/00_cleaned_indicators.csv')
WHERE "Value" IS NOT NULL;

CREATE OR REPLACE TABLE africa_electricity AS
SELECT 
    "Country" as country,
    "Series Name" as indicator,
    CAST("Year" as INTEGER) as year, 
    "Value" as value,
    "N_Observations" as n_observations,
    'africa_elec' as source  
FROM read_csv_auto('data/cleaned_data/01_africa_electricity_infrastructure.csv')
WHERE "Value" IS NOT NULL 
    AND "Year" != 'MRV2';  -- Exclude MRV2 entries for consistency

CREATE OR REPLACE TABLE energy_institute AS
SELECT
    "Country" as country,
    "Series Name" as indicator,
    "Year" as year,
    "Value" as value, 
    'energy_inst' as source
FROM read_csv_auto('data/cleaned_data/02_energy_institute_africa.csv')
WHERE "Value" IS NOT NULL;

-- Create countries table with unique countries from all datasets
CREATE OR REPLACE TABLE countries AS
SELECT DISTINCT country
FROM (
    SELECT country FROM ida_indicators
    UNION
    SELECT country FROM africa_electricity  
    UNION
    SELECT country FROM energy_institute
) 
ORDER BY country;

-- Create unified view for cross-dataset analysis
CREATE OR REPLACE VIEW energy_data_unified AS
SELECT country, indicator, year, value, source FROM ida_indicators
UNION ALL
SELECT country, indicator, year, value, source FROM africa_electricity
UNION ALL
SELECT country, indicator, year, value, source FROM energy_institute;

-- Show summary for each table
SELECT 'Countries' as dataset, COUNT(*) as records, COUNT(*) as countries, 0 as indicators FROM countries
UNION ALL
SELECT 'IDA Indicators', COUNT(*), COUNT(DISTINCT country), COUNT(DISTINCT indicator) FROM ida_indicators
UNION ALL
SELECT 'Africa Electricity', COUNT(*), COUNT(DISTINCT country), COUNT(DISTINCT indicator) FROM africa_electricity
UNION ALL
SELECT 'Energy Institute', COUNT(*), COUNT(DISTINCT country), COUNT(DISTINCT indicator) FROM energy_institute
UNION ALL
SELECT 'Total (Unified)', COUNT(*), COUNT(DISTINCT country), COUNT(DISTINCT indicator) FROM energy_data_unified;