# childEpiDataR: Epidemiological Data Analysis using R

## Project Overview
This repository focuses on analyzing epidemiological data using R, applying biostatistical methods to explore health-related variables in children. The project involves data preprocessing, statistical modeling, and hypothesis testing to derive meaningful insights from health datasets.
                  ![Epidemiological Data Analysis](images/Image.webp)


## Problem Statement
Understanding childhood disease burden and its relationship with demographic and health factors is essential for public health planning. This project aims to:
- Process and clean health survey data.
- Analyze the prevalence of various diseases in children.
- Perform statistical modeling to assess the impact of birthweight on disease burden.
- Estimate sample sizes for future studies.

## Repository Structure
```
├── README.md              # Project description and instructions
├── data/                  # Contains raw and processed data files
│   ├── health_survey.sav  # Example raw dataset
│   ├── formatted_data.RData # Processed dataset after transformations
├── scripts/               # R scripts and markdown files
│   ├── data_analysis.Rmd  # Main analysis file
│   ├── data_preprocessing.Rmd # Data cleaning and formatting script
├── results/               # Output folder for tables and plots
│   ├── descriptive_stats.csv   # Summary statistics
│   ├── regression_results.txt # Regression model outputs
│   ├── sample_size_calc.txt   # Sample size calculation results
└── LICENSE                # License for the project
```

## How to Use
1. Clone the repository:
   ```bash
   git clone https://github.com/your_username/childEpiDataR.git
   ```
2. Open RStudio and set the working directory to the project folder.
3. Run `data_analysis.Rmd` to execute all analyses and generate reports.

## Summary of Tasks
### Data Import and Cleaning
- Import health survey dataset using `haven`.
- Select relevant variables for analysis.
- Apply data formatting and transformation.

### Data Transformations
- Convert categorical variables to factors.
- Handle missing values and outliers.
- Create new derived variables such as `disease_burden`.

### Descriptive Statistics
- Generate frequency tables for key variables.
- Identify missing values and analyze completeness of records.

### Regression Analysis
- Choose an appropriate regression model to assess birth weight effects.
- Compute regression models and extract coefficients.
- Interpret statistical significance and effect sizes.

### Sample Size Calculation
- Determine an appropriate effect size for a t-test.
- Conduct power analysis using the `pwr` package.
- Evaluate study design for validity.

## Dependencies
Ensure the following R packages are installed:
```r
install.packages(c("tidyverse", "haven", "dplyr", "ggplot2", "pwr"))
```

## License
This project is licensed under the MIT License.

