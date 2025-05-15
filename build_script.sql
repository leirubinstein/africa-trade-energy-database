-- Create the table for trade stagnation scenario
DROP TABLE ida_trade_stag;
CREATE TABLE ida_trade_stag (
    id INTEGER, 
    utility_code VARCHAR,
    lav_2008 DOUBLE,
    mrv2_2008 DOUBLE,
    country_name VARCHAR
);
-- Load data from CSV
COPY ida_trade_stag FROM 'energy_data/ida_trade_stag.csv' (HEADER TRUE);

-- Create the table for optimistic trade scenario
DROP TABLE ida_trade_optim;
CREATE TABLE ida_trade_optim (
    id INTEGER,
    utility_code VARCHAR,
    lav_2008 DOUBLE,
    mrv2_2008 DOUBLE,
    country_name VARCHAR
);
-- Load data from CSV 
COPY ida_trade_optim FROM 'energy_data/ida_trade_optim.csv' (HEADER TRUE);

-- Create the table for historical trade scenario
DROP TABLE ida_tot_historical;
CREATE TABLE ida_tot_historical (
    id INTEGER,
    utility_code VARCHAR,
    lav_2008 DOUBLE,
    mrv2_2008 DOUBLE,
    country_name VARCHAR
);
-- Load data from CSV
COPY ida_tot_historical FROM 'energy_data/ida_tot_historical.csv' (HEADER TRUE);

-- Create the table for oil production
DROP TABLE ei_oil_production;
CREATE TABLE ei_oil_production (
    country_id INTEGER,
    growth_rate_per_annum_2013_2023 DOUBLE,
    year INTEGER,
    production_barrels DOUBLE,
);
-- Load data from CSV
COPY ei_oil_production FROM 'energy_data/ei_oil_production.csv' (HEADER TRUE);

-- Create the table for oil consumption
DROP TABLE ei_oil_consumption;
CREATE TABLE ei_oil_consumption (
    country_id INTEGER,
    growth_rate_per_annum_2013_2023 DOUBLE,
    year INTEGER,
    production_barrels DOUBLE,
);
-- Load data from CSV
COPY ei_oil_consumption FROM 'energy_data/ei_oil_consumption.csv' (HEADER TRUE);

-- Create the table for oil consumption
DROP TABLE countries;
CREATE TABLE countries (
    country_name VARCHAR,
    country_id INTEGER,
);
-- Load data from CSV
COPY countries FROM 'energy_data/countries.csv' (HEADER TRUE);
