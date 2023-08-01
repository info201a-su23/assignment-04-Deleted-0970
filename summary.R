# Reading and storing the csv file
# Variable to ensure line is <80 characters long
filename <- paste0("https://github.com/melaniewalsh/Neat-Datasets/",
                  "blob/main/us-prison-jail-rates-1990.csv?raw=true")
data <- read.csv(filename, stringsAsFactors = FALSE)

# loading necessary libraries
library(dplyr)

# Calculating the average jail rate per 100,000 of the latinx community in the
# United States.
avg_latinx_jail <- data %>%
  filter(year == max(year, na.rm = TRUE)) %>%
  summarize(mean_latinx_jail_pop_rate =
              round(mean(latinx_jail_pop_rate, na.rm = TRUE), 2))

# Calculating the average jail rate per 100,000 of the white community in the
# United States.
avg_white_jail <- data %>%
  filter(year == max(year, na.rm = TRUE)) %>%
  summarize(mean_white_jail_pop_rate =
              round(mean(white_jail_pop_rate, na.rm = TRUE), 2))

