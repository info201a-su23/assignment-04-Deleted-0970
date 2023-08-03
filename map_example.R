# Reading and storing the csv file
# Variable to ensure line is <80 characters long
filename <- paste0("https://github.com/melaniewalsh/Neat-Datasets/",
                   "blob/main/us-prison-jail-rates-1990.csv?raw=true")

# load necessary libraries
library(ggplot2)
library(dplyr)
library(scales)
library(maps)
library(mapproj)
options(scipen = 999) # removes scientific notation

data <- read.csv(filename, stringsAsFactors = FALSE) %>%
  filter(year == max(year)) %>%
  mutate(state = tolower(state.name[match(state, state.abb)]))
  # mutate state abbreviations into state names.
  # convert state names to lower case.

state_shape <- map_data("state")

aggregate_data <- data %>%
  group_by(state) %>%
  summarize(latinx_jail_pop_rate = mean(latinx_jail_pop_rate, na.rm = TRUE))

incarceration_state_shape <- left_join(
  aggregate_data, state_shape, by = c("state" = "region"))

blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(), # remove axis lines
    axis.text = element_blank(), # remove axis labels
    axis.ticks = element_blank(), # remove axis ticks
    axis.title = element_blank(), # remove axis titles
    plot.background = element_blank(), # remove gray background
    panel.grid.major = element_blank(), # remove major grid lines
    panel.grid.minor = element_blank(), # remove minor grid lines
    panel.border = element_blank(), # remove border around plot
  )

ggplot(data = incarceration_state_shape) +
  geom_polygon(mapping = aes(x = long,
                             y = lat,
                             group = group,
                             fill = latinx_jail_pop_rate)) +
  scale_fill_continuous(low = "grey",
                        high = "red",
                        ) +
  labs(title = "LatinX Jail Rate Per 100,000 Residents",
       fill = "Average Jail Rate") +
  coord_map() + blank_theme
