# COVID-19 Global & India Analysis Dashboard

## Executive Summary
This project offers an analysis of the COVID-19. It utilizes over 330,000 rows of Data to build a two-page BI dashboard, focusing on global and India-specific trends in cases, deaths, and vaccinations. The interactive dashboard provides key insights for strategic decision-making.

## Business Problem
The COVID-19 data can be overwhelming and difficult to interpret. Businesses, policymakers need a clear, concise, and interactive way to understand the pandemic's trends:

* Track and compare the progression of cases, deaths, and vaccinations over time.
* Identify the most affected countries and regions.
* Analyze the relationship between key metrics like population, infection rates, and vaccination coverage.
* Provide a focused analysis on the situation in India.

## Methodology
The project was executed in a structured, multi-stage process from data extraction to final presentation:

1.  **Data Extraction & Cleaning (Microsoft Excel):** The initial dataset was sourced from **[Our World in Data - COVID-19 Dataset](https://ourworldindata.org/covid-deaths)** and loaded into Excel. Unnecessary columns were identified and removed.

2.  **Data Processing & Querying (PostgreSQL):** The cleaned CSV file was imported into a PostgreSQL database. Data types were adjusted as needed. SQL queries were written to analyze the data, utilizing features such as:
    * **Common Table Expressions (CTEs)** and **Window Functions** for calculations.
    * Standard clauses like `SELECT`, `FROM`, `WHERE`, `ORDER BY`, `ALIAS`, `GROUP BY`, `HAVING`, `LIKE`, `SUM()`, `ROUND()`.
    
3.  **Data Visualization (Microsoft Power BI):** The PostgreSQL database was connected as a live data source to Power BI. An interactive, two-page report was built:
    * **Data Modeling:** Relationships between tables were established.
    * **Calculations:** **DAX Measures** and **Calculated Columns** were created to derive insights like `Percentage of Cases per Population`.
    * **Dashboard Design:** The report features dynamic slicers (Year, Quarter, Month), line charts, and column charts.
    * **Interactive Dashboard Link:** You can access and interact with the live dashboard here: [https://app.powerbi.com/view?r=eyJrIjoiODM5MjNmOWItOWRkYi00Y2FhLTk3OTYtMTAyMmYyNWQwM2I1IiwidCI6IjM4ZjYyOTI2LTc1NTktNGFlZi04NGFlLWNiNWUxNzI0MDZmYiJ9](https://app.powerbi.com/view?r=eyJrIjoiODM5MjNmOWItOWRkYi00Y2FhLTk3OTYtMTAyMmYyNWQwM2I1IiwidCI6IjM4ZjYyOTI2LTc1NTktNGFlZi04NGFlLWNiNWUxNzI0MDZmYiJ9)

## Skills
* **Data Analysis:** PostgreSQL (CTEs, Window Functions, Views, Aggregate Functions), DAX
* **Data Visualization:** Microsoft Power BI (Dashboarding, Slicers, Data Modeling)
* **Data Management:** Microsoft Excel (Data Cleaning, Filtering)
  
## Results
The primary result is a dynamic two-page Power BI dashboard that effectively visualizes pandemic trends.

* **Page 1: Global Statistics**
    * Displays KPIs for total cases, deaths, and vaccinations done from 08-01-2020 to 21-08-2023 with over 330k+ rows of data.
    * Features yearly, quarterly, and monthly dynamic slicers to drill down inside Line charts showing Total Cases, Deaths, and Vaccinations.
    * Column Charts to show world's Top 8 Nation's cases, with Percentage Cases/population, Death/Population, Vaccination/population.

* **Page 2: India Statistics**
    * Completely dynamic, showing KPIs for Total Cases, Deaths, and Vaccinations done in India.
    * Utilizes two kinds of Line Charts, each serving a distinct analytical purpose, to show the Total Cases, Deaths, and Vaccinations timeline.

## Business Recommendations
The insights from this dashboard can inform several strategic decisions:

* **Risk Assessment:** Businesses can use the geographical trends to assess operational risks and adjust supply chain or travel policies.
* **Market Analysis:** Identification of regions where pandemic is lessening, signaling potential market recovery and opportunities for growth.
* **Public Health Strategy:** Policymakers can use the dashboard to track vaccination campaign effectiveness and allocate resources more efficiently to heavily impacted areas.

## Next Steps
This project can be expanded in several ways to provide even greater value:

* **Economic Impact Analysis:** Integrate economic datasets (e.g., GDP, unemployment rates) to analyze the correlation between the pandemic and economic performance.
* **Predictive Modeling:** Develop a time-series forecasting model to predict future trends in cases or vaccination demand.
* **Variant Analysis:** Incorporate data on different COVID-19 variants to analyze their specific impact on cases and mortality rates.

## Contact
**Sandeep Roy**
* **LinkedIn:** [www.linkedin.com/in/sandeep--roy](https://www.linkedin.com/in/sandeep--roy)
