# Load Required Packages
library(dplyr)
library(haven)
library(table1)
library(pwr)
library(ggplot2)

# Load Data
kiggs_data <- read_sav("data/health_survey.sav")
head(kiggs_data)

# Data Selection
kiggs_nasa <- kiggs_data %>%
  select(sex, age2, birthweight = e017a_k, 
         disease1 = e02001, disease2 = e02002, 
         disease3 = e02006, disease4 = e02009)
head(kiggs_nasa)

# Data Transformation
kiggs_nasa <- kiggs_nasa %>%
  mutate(
    sex = factor(sex, labels = c("boys", "girls")),
    age2 = factor(age2, labels = c("0-1y", "2-3y", "4-5y", "6-7y", "8-9y", "10-11y", "12-13y", "14-15y", "16-17y")),
    birthweight = factor(birthweight, labels = c("under 2500", "2500 - 2999", "3000 - 3499", "3500 - 3999", "4000 - 4499", "4500+"))
  )

# Convert Disease Variables to Binary and Compute Disease Count
kiggs_nasa <- kiggs_nasa %>%
  mutate(across(disease1:disease4, ~ ifelse(. == 1, 1, 0)),  # Convert 1 = Yes, 0 = No
         disease_count = rowSums(across(disease1:disease4), na.rm = TRUE))  # Sum diseases

# Save Processed Data
save(kiggs_nasa, file = "data/formatted_data.RData")

# Descriptive Statistics
load("data/formatted_data.RData")
table1(~ age2 + sex + disease1 + disease2 + disease3 + disease4, data = kiggs_nasa)

# Data Visualization
## Distribution of Age Groups
ggplot(kiggs_nasa, aes(x = age2, fill = sex)) +
  geom_bar(position = "dodge") +
  labs(title = "Age Distribution by Sex", x = "Age Groups", y = "Count") +
  theme_minimal()

ggsave("results/age_distribution.png", width = 8, height = 5, dpi = 300)

## Birthweight Distribution
ggplot(kiggs_nasa, aes(x = birthweight)) +
  geom_bar(fill = "skyblue") +
  labs(title = "Birthweight Distribution", x = "Birthweight Category", y = "Count") +
  theme_minimal()

ggsave("results/birthweight_distribution.png", width = 8, height = 5, dpi = 300)

## Disease Burden vs Birthweight
ggplot(kiggs_nasa, aes(x = birthweight, y = disease_count, fill = birthweight)) +
  geom_boxplot(alpha = 0.6) +
  geom_jitter(aes(color = birthweight), width = 0.2, alpha = 0.5) +
  stat_summary(fun = mean, geom = "point", shape = 4, size = 4, color = "red") +
  labs(title = "Disease Burden vs Birthweight", x = "Birthweight Category", y = "Number of Diseases") +
  theme_minimal()

ggsave("results/disease_burden_vs_birthweight.png", width = 8, height = 5, dpi = 300)

# Quasi-Poisson Regression
quasi_poisson_model <- glm(disease_count ~ birthweight, 
                           data = kiggs_nasa, 
                           family = quasipoisson)
summary(quasi_poisson_model)

sink("results/regression_results.txt")
summary(quasi_poisson_model)
sink()

# Sample Size Calculation
sample_size <- pwr.t.test(d = 0.3, power = 0.8, sig.level = 0.05, 
                          type = "two.sample", alternative = "greater")
print(sample_size$n)

sink("results/sample_size_calc.txt")
print(sample_size)
sink()

