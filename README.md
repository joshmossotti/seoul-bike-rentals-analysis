# seoul-bike-rentals-analysis
Analysis of Seoul bike rental patterns using R and Tableau, examining how weather conditions disrupt baseline hourly demand and influence rider behavior.

**Overview**

This project explores how weather conditions influence bicycle rental behavior in Seoul, South Korea (2017–2018). The goal was to understand how external factors—such as temperature, humidity, and precipitation—disrupt typical daily usage patterns.

Using a baseline vs. condition comparison framework, this analysis highlights how rider behavior changes under different environmental conditions and distinguishes between necessity-driven and discretionary usage.


**Objectives**

-  Establish a baseline hourly rental pattern
-  Measure how weather conditions deviate from this baseline
-  Identify which factors most strongly influence rider behavior
-  Explore how environmental comfort impacts transportation choices


**Tools**

-  R → Data cleaning, transformation, feature engineering
-  Tableau → Interactive dashboard and visualization


**Data Preparation**

The raw dataset was cleaned and transformed in R:

-  Created Rental Periods (Morning Commute, Midday, Evening Commute, Night, Off Hours)
-  Engineered categorical bins for:
   - Temperature (Cold, Cool, Mild, Warm)
   - Humidity (Dry, Moderate, Humid, Very Humid)
   - Precipitation (None, Rain, Snow, Mixed)
-  Built a baseline dataset representing all conditions
-  Generated condition-specific datasets and combined them into a unified structure for visualization


**Methodology**

**Baseline vs. Overlay Framework**

A baseline average of bike rentals by hour was established using all observations.
Each weather condition was then compared against this baseline to measure deviation.

**Key Metric**

-  % Change vs Baseline used to quantify behavioral disruption

**Visualization Design**

-  Dual-axis timeline:
   - Bars → Baseline (All Conditions)
   - Line → Selected Condition
-  Parameter-driven selector to switch between:
   - Precipitation
   - Temperature
   - Humidity
-  Custom tooltips to highlight deviations and maintain clarity

**Key Insights**

-  Consistent Daily Pattern
  Bike rentals follow a stable commute-driven pattern, with peaks in the morning and evening.
-  Temperature Influences Evening Demand
  Warmer temperatures significantly increase evening rentals, suggesting discretionary trips after work.
-  Humidity Suppresses Non-Essential Trips
  High humidity reduces rentals after the morning peak, indicating rider sensitivity to comfort.
-  Precipitation Has the Strongest Impact
  Rain and mixed precipitation consistently reduce rentals across all time periods.


**Interpretation**

The analysis suggests a distinction between:

-  Necessity-driven behavior (morning commute)
-  Discretionary behavior (evening and off-peak usage)

Environmental conditions have a greater influence on discretionary trips, where riders have more flexibility in transportation choices.


**Dashboard**

Link:
https://public.tableau.com/app/profile/joshua.mossotti/viz/SeoulHourlyBikeData2017-2018/SeoulHourlyBikeData2017-2018


**Limitations**

-  Data limited to 2017–2018
-  Results may not reflect post-pandemic or long-term behavioral changes
-  Analysis is observational and does not establish causation


**Future Work**

-  Add predictive modeling (Python) to estimate rental demand based on weather
-  Compare with additional cities or time periods
-  Incorporate more granular weather or geographic data
