#ggplot Animation Examples

library(ggplot2)
library(gganimate)
library(gapminder)
library(gifski)
# Define plot
p <- ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_point(alpha = 0.7, show.legend = FALSE) +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  labs(title = "Year: {frame_time}", x = "GDP per capita", y = "Life expectancy") +
  transition_time(year) +
  ease_aes("linear")

# Animate it
animated_plot <- animate(p, fps = 10, duration = 10, width = 800, height = 600, renderer = gifski_renderer())

# View it
animated_plot

### Babynames Animation
library(babynames)
library(tidyverse)
library(gganimate)

# Filter names to plot
filtered_data <- babynames %>%
  filter(name %in% c("George", "Jason", "Logan", "Cody","Matthew"))

# Aggregate to one row per name/year
filtered_summary <- filtered_data %>%
  group_by(year, name) %>%
  summarise(n = sum(n), .groups = "drop")

# Animate
p <- ggplot(filtered_summary, aes(x = year, y = n, color = name, group = name)) +
  geom_line(size = 1.2) +
  labs(title = "Baby Name Popularity",
       x = "Year", y = "Number of Babies",
       color = "Name") +
  theme_minimal(base_size = 14) +
  transition_reveal(year)+scale_x_continuous(breaks = seq(1880,2010,10))

animate(p, fps = 4, width = 900, height = 500, duration = 10,renderer = gifski_renderer())


