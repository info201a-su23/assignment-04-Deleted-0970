# Reading and storing the csv file
# Variable to ensure line is <80 characters long
filename <- paste0("https://github.com/melaniewalsh/Neat-Datasets/",
                   "blob/main/us-prison-jail-rates-1990.csv?raw=true")
data <- read.csv(filename, stringsAsFactors = FALSE)

# load necessary libraries
library(ggplot2)
library(dplyr)
options(scipen = 999) # removes scientific notation

# Aggregate data
aggregate_data_urban <- data %>%
  group_by(year) %>%
  filter(urbanicity == "urban") %>%
  summarize(latinx_jail_pop_rate = mean(latinx_jail_pop_rate, na.rm = TRUE),
            total_jail_pop_rate = mean(total_jail_pop_rate, na.rm = TRUE))

# Create the scatter plot with the aggregated data
ggplot(
  data = aggregate_data_urban
) +
  geom_point( # Latinx scatter plot
    aes(x = year, y = latinx_jail_pop_rate, color = "LatinX")
  ) +
  geom_smooth( # Latinx trend line
    aes(x = year, y = latinx_jail_pop_rate, color = "LatinX"),
    method = "loess", formula = "y ~ x", se = FALSE
  ) +
  geom_point( # US scatter plot
    aes(x = year, y = total_jail_pop_rate, color = "US Total")
  ) +
  geom_smooth( # US trend line
    aes(x = year, y = total_jail_pop_rate, color = "US Total"),
    method = "loess", formula = "y ~ x", se = FALSE
  ) +
  labs( # labels
    x = "Year", y = "Urban Jail Rate Per 100,000 Residents",
    title = "Urban Jail Rates: Latinx vs. US Total",
    color = "Group"
  ) +
  theme_light() # Changing graph background