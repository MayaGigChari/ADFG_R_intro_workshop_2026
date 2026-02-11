# GGPLOTLY EXAMPLE


# Load Packages
library(tidyverse)
library(plotly)

# Clean the data: remove missing values
sw_clean <- starwars %>%
  filter(!is.na(height), !is.na(mass), !is.na(species))

# Create the ggplot
p <- ggplot(sw_clean, aes(x = height, y = mass,
                          color = mass,
                          text = paste("Name:", name,
                                       "<br>Height:", height,
                                       "<br>mass:", mass))) +
  geom_point(size = 3, alpha = 0.8) +
  labs(title = "Star Wars Characters: Height vs Mass",
       x = "Height (cm)",
       y = "Mass (kg)") +
  theme_minimal()

# Convert to interactive plotly object
ggplotly(p, tooltip = "text")



# Unemployment example 

# Line plot of unemployment over time
p <- ggplot(economics, aes(x = date, y = unemploy)) +
  geom_line(color = "darkred", size = 1) +
  labs(title = "U.S. Unemployment Over Time",
       x = "Year", y = "Number Unemployed (in thousands)") +
  theme_minimal()

ggplotly(p)


#Diamonds Example

# Sample a smaller subset for performance
diamonds_sample <- diamonds %>% sample_n(1000)

# Create boxplot of price by cut, with jittered points
p <- ggplot(diamonds_sample, aes(x = cut, y = price,
                                 text = paste("Price:", price, "<br>Carat:", carat))) +
  geom_boxplot(outlier.shape = NA, fill = "lightblue") +
  geom_jitter(aes(color = cut), width = 0.2, alpha = 0.6) +
  labs(title = "Diamond Price Distribution by Cut",
       x = "Cut Quality", y = "Price (USD)") +
  theme_minimal()

ggplotly(p, tooltip = "text")



# Salary Example

salary <- read_csv("data/Salary65th_cleaned.csv")

salary <- salary %>%
  rename(
    Group = `AK State Occupational Group`,
    Family = `AK State Job Family`,
    BU = `AK State BU`,
    Title = `AK State Job Title Only`,
    Code = `AK State Job Class Code`,
    Range = `AK State Pay Range`,
    State_Salary = `AK State Annual Range Minimum (Step A)`,
    Market_65th = `Combined Market 65th Percentile MINIMUM`,
    Percent_Diff = `% Difference (State minus Market)/Market)`,
  ) %>%
  select(Title, Group, Family, Code, BU, Range, State_Salary, Market_65th, Percent_Diff)

p = ggplot(data = salary, mapping = aes(
  x = Market_65th,
  y = State_Salary,
  color = Family == "PH01 - Fish and Wildlife", #Only changing the color and size of F&W job family
  size = Family == "PH01 - Fish and Wildlife",   #Only changing the color and size of F&W job family
  text = paste("Job Title",Title,"<br>Perecnt Difference",Percent_Diff)
)) +  
  geom_point() + # Create Scatterplot
  geom_abline(slope = 1, intercept = 0, linetype = "dashed") + # Creates a 1-1 line to represent 0% difference
  scale_color_manual(
    values = c("gray70", "darkgreen"), # Specifies color change just for F&W
    labels = c("Other", "PH01 - Fish and Wildlife"), 
    name = "Job Family"
  ) + 
  scale_size_manual(
    values = c(1.5, 2), # Specifies the size for F&W vs Others
    guide = "none"      # hide size legend (optional)
  ) + 
  labs(                 # Specify your title and axis labels
    title = "State vs Market Salary", 
    x = "Market 65th Percentile Salary",
    y = "State Salary Minimum"
  ) + 
  theme_minimal()

ggplotly(p, tooltip = "text")
