# Employee-Performance-Analysis


## Overview
This project analyzes employee performance at **National Choice Bank (NCB)** using survey data to determine the key factors influencing productivity, teamwork, communication, and customer satisfaction. The findings help inform better workforce management strategies and data-driven decision-making.

## Key Features
- **Survey Data Analysis:** Employee feedback on training, communication, and teamwork.
- **Statistical Modeling:** Regression analysis to identify key performance drivers.
- **Predictive Insights:** Understanding how customer orientation and training impact employee communication and teamwork.
- **Visualization & Reporting:** Data visualization using R for better insights.

## Data & Methodology
### **Dataset**
The study uses a dataset (`Kenexa.csv`) containing survey responses from 2230 employees across 128 NCB branches. Employees rated factors such as:
- Customer orientation
- Training quality
- Workplace communication
- Team collaboration

### **Analysis Approach**
- **Descriptive Statistics:** Mean, standard deviation, and correlation analysis.
- **Exploratory Data Analysis (EDA):** Visualizations (histograms, scatter plots) to explore trends.
- **Regression Models:** Predictive analysis of employee performance metrics.
- **Key Metrics:** Employee communication, teamwork, and overall branch productivity.

## Key Findings
1. **Customer orientation & training are key drivers of employee performance.**
2. **Training significantly improves communication, with a 0.72 unit increase per 1 unit of training improvement.**
3. **Customer orientation has a stronger impact on teamwork than training.**
4. **Improving internal communication fosters better teamwork and employee satisfaction.**

## Recommendations
- **Enhanced Training Programs:** Include role-playing exercises, writing workshops, and communication best practices.
- **Regular Employee Surveys:** Collect data on work culture, leadership, and mental health support.
- **Customer Feedback Integration:** Gather structured feedback on employee service quality.
- **Data-Driven Decision Making:** Utilize analytics to track employee engagement and productivity.

## Tools & Technologies
- **R Programming** (for data analysis & regression modeling)
- **ggplot2 & corrplot** (for data visualization)
- **QuantPsyc & psych** (for statistical modeling)

## How to Run the Analysis
1. Install required R packages:
   ```r
   install.packages("GGally", "ggpubr", "ggplot2", "corrplot", "corrgram", "QuantPsyc", "Hmisc", "psych")
   ```
2. Load the dataset:
   ```r
   kenexa <- read.csv("Kenexa.csv")
   ```
3. Run the analysis using `Starter_code.R`
   ```r
   source("Starter_code.R")
   ```

## License
This project is open-source and intended for academic and business use.

