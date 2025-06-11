-- Compare costs between optimal trade vs trade stagnation scenarios
SELECT 
    country, 
    year,
    MAX(CASE WHEN indicator = 'Cost of electricity per unit, LRMC, optimal trade scenario' THEN value END) as optimal_trade_cost,
    MAX(CASE WHEN indicator = 'Cost of electricity per unit, LRMC, trade stagnation scenario' THEN value END) as stagnation_cost,
    (MAX(CASE WHEN indicator = 'Cost of electricity per unit, LRMC, trade stagnation scenario' THEN value END) - 
     MAX(CASE WHEN indicator = 'Cost of electricity per unit, LRMC, optimal trade scenario' THEN value END)) as cost_difference,
    ROUND(
        ((MAX(CASE WHEN indicator = 'Cost of electricity per unit, LRMC, trade stagnation scenario' THEN value END) - 
          MAX(CASE WHEN indicator = 'Cost of electricity per unit, LRMC, optimal trade scenario' THEN value END)) /
         MAX(CASE WHEN indicator = 'Cost of electricity per unit, LRMC, optimal trade scenario' THEN value END)) * 100, 2
    ) as percent_savings_from_trade
FROM africa_electricity
WHERE indicator IN (
    'Cost of electricity per unit, LRMC, optimal trade scenario', 
    'Cost of electricity per unit, LRMC, trade stagnation scenario'
)
GROUP BY country, year
HAVING optimal_trade_cost IS NOT NULL AND stagnation_cost IS NOT NULL
ORDER BY cost_difference DESC;

-- Electricity access vs trade benefits analysis
-- Compare 2005 trade cost benefits with electricity access improvements (2010-2020)
WITH trade_benefits AS (
    SELECT 
        country,
        (MAX(CASE WHEN indicator = 'Cost of electricity per unit, LRMC, trade stagnation scenario' THEN value END) - 
         MAX(CASE WHEN indicator = 'Cost of electricity per unit, LRMC, optimal trade scenario' THEN value END)) as cost_difference_2005,
        MAX(CASE WHEN indicator = 'Cost of electricity per unit, LRMC, optimal trade scenario' THEN value END) as optimal_trade_cost_2005
    FROM africa_electricity
    WHERE indicator IN (
        'Cost of electricity per unit, LRMC, optimal trade scenario', 
        'Cost of electricity per unit, LRMC, trade stagnation scenario'
    )
    AND year = 2005
    GROUP BY country
    HAVING cost_difference_2005 IS NOT NULL
),
electricity_access AS (
    SELECT 
        country,
        AVG(value) as avg_electricity_access_2010_2020,
        MIN(value) as min_electricity_access_2010_2020,
        MAX(value) as max_electricity_access_2010_2020,
        COUNT(*) as years_of_data
    FROM ida_indicators
    WHERE indicator = 'Access to electricity (% of population)'
      AND year BETWEEN 2010 AND 2020
    GROUP BY country
    HAVING COUNT(*) >= 3  -- At least 3 years of data
)
SELECT 
    tb.country,
    tb.cost_difference_2005,
    tb.optimal_trade_cost_2005,
    ROUND(
        (tb.cost_difference_2005 / tb.optimal_trade_cost_2005) * 100, 2
    ) as percent_cost_savings_from_trade,
    ea.avg_electricity_access_2010_2020,
    ea.min_electricity_access_2010_2020,
    ea.max_electricity_access_2010_2020,
    ea.years_of_data
FROM trade_benefits tb
JOIN electricity_access ea ON tb.country = ea.country
ORDER BY tb.cost_difference_2005 DESC;

-- Countries with highest renewable energy generation (2020-2023)
SELECT 
    country,
    indicator,
    AVG(value) as avg_generation_twh,
    MAX(value) as max_generation_twh,
FROM energy_institute
WHERE indicator IN ('Hydro Generation (TWh)', 'Solar Generation (TWh)', 'Wind Generation (TWh)')
  AND year BETWEEN 2020 AND 2023
  AND value > 0
GROUP BY country, indicator
HAVING COUNT(*) >= 2
ORDER BY country, avg_generation_twh DESC;

--  Summary statistics by data source
SELECT 
    source,
    COUNT(*) as total_records,
    COUNT(DISTINCT country) as unique_countries,
    COUNT(DISTINCT indicator) as unique_indicators,
    MIN(year) as earliest_year,
    MAX(year) as latest_year,
    ROUND(AVG(value), 2) as avg_value,
    ROUND(MIN(value), 2) as min_value,
    ROUND(MAX(value), 2) as max_value
FROM energy_data_unified
GROUP BY source
ORDER BY source;