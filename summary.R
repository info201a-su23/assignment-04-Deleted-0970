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

# Calculating the difference in average jail rate per 100,000 of the latinx
# community in the US between the most recent date and a decade ago.
avg_latinx_jail_past <- data %>%
  filter(year == max(year, na.rm = TRUE) - 10) %>%
  summarize(mean_latinx_jail_pop_rate =
              round(mean(latinx_jail_pop_rate, na.rm = TRUE), 2))
avg_latinx_jail_diff <- avg_latinx_jail - avg_latinx_jail_past

# Calculating the difference in average jail rate per 100,000 of the white
# community in the US between the most recent date and a decade ago.
avg_white_jail_past <- data %>%
  filter(year == max(year, na.rm = TRUE) - 10) %>%
  summarize(mean_white_jail_pop_rate =
              round(mean(white_jail_pop_rate, na.rm = TRUE), 2))
avg_white_jail_diff <- avg_white_jail - avg_white_jail_past

# Calculating the state with the greatest difference in jail rates between
# White and LatinX people in the most recent year.
# This data turned out to be unusable because Irwin County GA has a 
# latinx_jail_pop_rate of >250,000 which isn't possible.
state_greatest_diff <- data %>%
  filter(year == max(year, na.rm = TRUE)) %>%
  mutate(wl_jail_diff = latinx_jail_pop_rate - white_jail_pop_rate) %>%
  filter(wl_jail_diff == max(wl_jail_diff, na.rm = TRUE)) %>%
  select(state)

state_greatest_diff_num <- data %>%
  filter(year == max(year, na.rm = TRUE)) %>%
  mutate(wl_jail_diff = latinx_jail_pop_rate - white_jail_pop_rate) %>%
  filter(wl_jail_diff == max(wl_jail_diff, na.rm = TRUE)) %>%
  select(wl_jail_diff)

# Calculating the average difference in jail population rate per 100,000 of
# latinx people and white people in the US.
avg_wl_jail_diff <- data %>%
  mutate(wl_jail_diff = latinx_jail_pop_rate - white_jail_pop_rate) %>%
  summarize(mean_jail_diff = 
              round(mean(wl_jail_diff, na.rm = TRUE), 2))
  
  