# Africa Trade and Energy Indicators Database

## Description

This repository houses code used to create a database of energy infrastructure statistics, energy cost projections, and human development indicators for Africa derived three different from World Bank and Energy Institute datasets.

Additionally, it contains files for querying and visualizations derived from these queries that answer the question of how different trade scenarios impact electricity cost and access across different countries in Africa.

## Data Visualizations

Please see `data_visualization.ipynb` for the code used to create these visualizations.

These packages are required for data cleaning: `os`, `numpy`, `pandas` and data visualization: `duckdb`, `geopandas` `matplotlib`, `numpy`, `pandas`, `seaborn`.

![Bar Chart of Projected Long Run Marginal Cost Savings by Top 10 Countries from Regional Trade Integration](figures/africa_lrmc_savings.png)

![Chloropleth Map of Africa, Colored by % Access to Electricity](figures/africa_electricity_access_map.png)

![Chloropleth Map of Africa, Colored by % Cost Savings from Regional Trade Integration](figures/africa_trade_map.png)

## Database Schema

The below diagram, created using [dbdiagram.io](https://dbdiagram.io/home) outlines the structure and organization of the database. It contains four tables: `countries`, `ida_indicators`, `africa_electricity`, and `energy_institute`.

![Entity-Relationship Diagram of Database, created using dbdiagram.io](figures/er-diagram.png)

## Data Access

Sources:

| Dataset | Publisher | Description | Citation/Link |
|---|---|---|---|
| IDA Results Measurement System | World Bank | Measures progress on aggregate outcomes for International Development Association countries for selected indicators. | https://databank.worldbank.org/source/ida-results-measurement-system,-tier-i-database-%E2%80%93-wdi/Series/EG.ELC.ACCS.ZS |
| Africa Infrastructure: Electricity | World Bank | Measures electricity infrastructure for Africa, contains series on electricity costs under different regional trade scenarios. | https://databank.worldbank.org/source/africa-infrastructure:-electricity |
| 2024 Statistical Review of World Energy | Energy Institute | Data on world energy markets (sources, generation/consumption, prices, emissions). | Energy Institute (2024), Statistical Review of World Energy 2024, Energy Institute, London. Available online at: https://www.energyinst.org/statistical-review/home |

The `data_cleaning.ipynb` notebook details code used to clean the above datasets for ingestion into the database, and the database setup code is located in `setup_db.sql`. 

## Repository Structure

