# Africa Trade and Energy Indicators Database

![](figures/global_south_africa_electricity_002.png)
Source: [Brookings Institution](https://www.brookings.edu/articles/figure-of-the-week-electricity-access-in-africa/)

## Introduction

While recent American policy trends towards trade protecionism, regional electricity trade integration represents one of Africa's most promising pathways to achieve universal energy access and economic development, with potential to save African countries $40 billion in capital spending, according to a [report by the World Bank](https://www.worldbank.org/en/results/2025/02/06/powering-africa-the-transformational-impact-of-regional-energy-projects-in-west-africa). The [UN Sustainable Development Group](https://unsdg.un.org/latest/stories/decoding-africa%E2%80%99s-energy-journey-three-key-numbers#:~:text=Caption%3A%20Around%20600%20million%20Africans,the%20global%20electricity%20access%20gap.) estimates that over 600 million Africans still lack electricity access.  Understanding the potential benefits and trade-offs of connecting national power grids is crucial for policymakers and NGOs. This database and my queries were produced to address these questions: 

**- Which countries would benefit most from regional trade?**
**- What are the potential cost savings?**
**- How do current electricity access patterns relate to integration opportunities?**

By analyzing scenarios comparing isolated national markets versus optimal regional trade, we can identify countries that could dramatically reduce electricity costs and countries that might resist integration due to higher costs. The analysis reveals stark differences in how African countries would benefit from regional electricity trade integration, with Chad (57% cost savings), Mozambique (50%), and Niger (20%) showing the highest potential benefits, while Tanzania (-20%), Ethiopia (-16%), and Cameroon (-14%) would face higher costs as net electricity exporters. This uneven distribution of benefits could create coalitions for and against integration, highlighting the need for compensation mechanisms to ensure equitable participation in regional electricity markets.

In working with this data, I encountered the challenges of inconsistent and missing data for a significant number of countries across all datasets and most indicators/series, and had to modify my queries to obtain results with any data. I aggregated cost projections by country, but some of the names for these entities could have represented transnational power pools in the original data. There was no documentation in the metadata on what these entities represented, so I took my best guess. Due to these challenges, my analyses may not be robust or accurate.

Causes for poor data collection could be political instability or insufficient economic investment in survey infrastructure. Having insufficient data only compounds these issues, because policymakers or international aid groups  cannot set accurate benchmarks to evaluate policies or interventions.

## Description

This repository houses code used to create a database of energy infrastructure statistics, energy cost projections, and human development indicators for Africa derived three different from World Bank and Energy Institute datasets.

Additionally, it contains files for querying and visualizations derived from these queries that answer the question of how different trade scenarios impact electricity cost and access across different countries in Africa.

## Data Visualizations

Please see `data_visualization.ipynb` for the code used to create these visualizations.

These packages are required for data cleaning: `os`, `numpy`, `pandas` and data visualization: `duckdb`, `geopandas` `matplotlib`, `numpy`, `pandas`, `seaborn`.

![1. Bar Chart of Projected Long Run Marginal Cost Savings by Top 10 Countries from Regional Trade Integration](figures/africa_lrmc_savings.png)

![2. Chloropleth Map of Africa, Colored by % Access to Electricity](figures/africa_electricity_access_map.png)

![3. Chloropleth Map of Africa, Colored by % Cost Savings from Regional Trade Integration](figures/africa_trade_map.png)

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

```
📦
├── data
│   ├── cleaned_data # cleaned data for ingestion into database 
│   │   ├── 00_cleaned_indicators.csv
│   │   ├── 01_africa_electricity_infrastructure.csv
│   │   └── 02_energy_institute_africa.csv
│   ├── energy_institute 
│   │   └── Statistical Review of World Energy Data.xlsx # raw energy institute markets data
│   ├── world_bank
│   │   ├── P_Data_Extract_From_Africa_Infrastructure_Electricity.xlsx # raw africa electricity data
│   │   └── P_Data_Extract_From_IDA_Results_Measurement_System.xlsx # raw economic and human development indicators data
│   └── africa_energy.db # database!
├── figures
│   ├── africa_electricity_access_map.png # data visualization 2
│   ├── africa_lrmc_savings.png # data visualization 1
│   ├── africa_trade_map.png # data visualization 3
│   └── er-diagram.png # schema diagram
│   └── global_south_africa_electricity_002.png
├── .gitignore
├── data_cleaning.ipynb # notebook for data cleaning
├── data_visualization.ipynb # notebook for data visualizations
├── LICENSE
├── queries.sql # queries used to produce data visualizations
├── README.md
├── requirements.txt # project packages and dependencies
└── setup_db.sql # DuckDB sql code used to set up database
```

## Environment & Dependencies

**Version:** Python 3.7.13

Please see `requirements.txt` for project packages and dependencies.

## Author

Leilanie Rubinstein

*Master of Environmental Data Science Student, Bren School of Environmental Science & Management*

Contact information:

- [leilanierubinstein@gmail.com]
- [rubinstein@bren.ucsb.edu]

## Acknowledgments 

*This project was produced as an assignment for Bren School of Environmental Science & Management course EDS 213: Databases and Data Management (2025). Materials and instructions were produced by Annie Adams, Julien Brun, and Greg Janée.*
