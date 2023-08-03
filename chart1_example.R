# Reading and storing the csv file
# Variable to ensure line is <80 characters long
filename <- paste0("https://github.com/melaniewalsh/Neat-Datasets/",
                   "blob/main/us-prison-jail-rates-1990.csv?raw=true")
data <- read.csv(filename, stringsAsFactors = FALSE)

# load necessary libraries
library(ggplot2)
library(dplyr)
options(scipen = 999) # removes scientific notation

# aggregating data
aggregate_data <- data %>%
  group_by(year) %>%
  summarize(latinx_jail_pop_rate = mean(latinx_jail_pop_rate, na.rm = TRUE),
            white_jail_pop_rate = mean(white_jail_pop_rate, na.rm = TRUE),
            total_jail_pop_rate = mean(total_jail_pop_rate, na.rm = TRUE))

# Create the scatter plot with the aggregated data
ggplot(
  data = aggregate_data,
  aes(x = year) # setting x-axis
) +
  geom_point( # latinx scatter plot
    aes(y = latinx_jail_pop_rate, color = "LatinX")
  ) +
  geom_smooth( # latinx trend line
    aes(y = latinx_jail_pop_rate, color = "LatinX"),
    method = "loess",
    formula = y ~ x,
    se = FALSE
  ) +
  geom_point( # white scatter plot
    aes(y = white_jail_pop_rate, color = "White")
  ) +
  geom_smooth( # white trend line
    aes(y = white_jail_pop_rate, color = "White"),
    method = "loess",
    formula = y ~ x,
    se = FALSE
  ) +
  geom_point( # US scatter plot
    aes(y = total_jail_pop_rate, color = "US Total")
  ) +
  geom_smooth( # US trend line
    aes(y = total_jail_pop_rate, color = "US Total"),
    method = "loess",
    formula = y ~ x,
    se = FALSE
  ) +
  labs( # adding labels
    x = "Year",
    y = "Average Jail Rate Per 100,000 Residents",
    title = "Average Latinx vs. White Jail Rate Over Time",
    color = "Group"
  ) +
  theme_light() # changing background of graph


