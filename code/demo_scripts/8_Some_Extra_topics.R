# ADF&G R Intro Workshop
# Logan Wendling & Matt Tyers
# logan.wendling@alaska.gov
# matt.tyers@alaska.gov


##### SCRIPT 8 ####
##### Some more cool topics! #####


## -------- statistics -------- ##

# Disclaimer: THIS IS NOT A STATISTICS COURSE!!

data(mtcars)
help(mtcars)

# is there a difference in mean mpg between automatic & manual?
# 0 = automatic
# 1 = manual
t.test(mtcars$mpg[mtcars$am==0], mtcars$mpg[mtcars$am==1])
t.test(mpg ~ am,
       data = mtcars)

# maybe there's more to the story...
mpg_by_am <- with(mtcars,
                  table(cyl, am))
chisq.test(mpg_by_am)

# the lm() function fits Linear Models:
# - simple linear regression, multiple linear regression, ANOVA, ...
lm_cars <- lm(mpg ~ cyl, data=mtcars)
summary(lm_cars)

# MLR gives simultaneous effects of multiple variables
lm_cars <- lm(mpg ~ cyl + drat + wt + am, data=mtcars)
summary(lm_cars)






## -------- simulation -------- ##

random_normal <- rnorm(n=10000, mean=100, sd=10)
head(random_normal)
hist(random_normal)

random_binom <- rbinom(n=10000, size=100, prob=0.8)
head(random_binom)
hist(random_binom)
plot(y=1:10000, x=sort(random_binom))


# a hilarious way to approximate pi through stochastic simulation
x <- runif(10000000, min=-1, max=1)
y <- runif(10000000, min=-1, max=1)

mean(x^2 + y^2 < 1) * 4
# the proportion of points within a circle, scaled by the area of an enclosing square





## -------- writing your own functions -------- ##

NChapman <- function(n1, n2, m2) {
  Nhat <- (n1 + 1)*(n2 + 1)/(m2 + 1) - 1
  return(Nhat)
}

NChapman(n1=100, n2=200, m2=20)
NChapman(n1=200, n2=300, m2=50)

# adding an additional argument with a default
NChapman <- function(n1, n2, m2, subservience=TRUE) {
  Nhat <- (n1 + 1)*(n2 + 1)/(m2 + 1) - 1
  if(subservience) {
    print("you got it, boss.")
  }
  return(Nhat)
}

NChapman(n1=100, n2=200, m2=20)






## -------- writing your own packages -------- ##

# show Project associated with dsftools
# - open something from /R, show functions, roxygen documentation
# - show tests




## -------- loops & cool syntax stuff -------- ##

# a simple loop to show how it works
for(i in 1:10) {
  print(i)
}

# - could become -
for(i in 1:10) {
  if(i != 5) {
    print(i)
  } else {
    print("Number five alive! No disassemble!")
  }
}


# opening many files at once  (this will not work!!!)
filenames <- paste0("Coho_", 2012:2025, ".csv")
filenames         # showing what was constructed

all_data <- list()  # initialize a list
for(i in seq_along(filenames)) {
  # all_data[[i]] <- read_csv(filenames[i])
}



## -------- mapping with sf, leaflet, ... -------- ##

library(tidyverse)
# this example isn't actually that interesting
# waterquality <- read_csv("data/DEC_waterquality_2016.csv", skip=1) %>%
#   filter(`Characteristic Name` == "Dissolved oxygen (DO)") %>%
#   rename("Latitude" = "Monitoring Location Latitude") %>%
#   rename("Longitude" = "Monitoring Location Longitude") %>%
#   rename("DO" = "Result Value") %>%
#   group_by(`Monitoring Location Name`) %>%
#   summarise(mean_DO=mean(DO),
#             Lat=mean(Latitude),
#             Long=mean(Longitude))

tburbs <- read_csv("https://github.com/ADFG-DSF/Tanana_burbot_telemetry/raw/refs/heads/main/data/TananaBurbotTelem3.csv")

# sf

# leaflet
library(leaflet)
leaflet(waterquality) %>%
  addTiles() %>%
  addMarkers(~Long, ~Lat, label=~`Monitoring Location Name`)
  # addCircles(~Long, ~Lat, label=~`Monitoring Location Name`)

leaflet(tburbs) %>%
  addTiles() %>%
  # addMarkers(lng= ~longitude,
  #            lat= ~latitude,
  #            label= ~unique_id...2)
  addCircles(lng= ~longitude,
             lat= ~latitude,
             label= ~unique_id...2,
             color= ~rainbow(17)[as.numeric(as.factor(flight_num))])




## -------- interactive apps with Shiny -------- ##

# Start with the Shiny template!! It's a great on-ramp
# - I like structuring it as a single file
# Can deploy to the web!  Here are a few I've made:
# - https://mbtyers.shinyapps.io/Ricker1/
# - https://mbtyers.shinyapps.io/TelemetryWizard/    this one will take some practice to demo
# - https://mbtyers.shinyapps.io/chordfinder/
# - https://mbtyers.shinyapps.io/snowflake/




## -------- reproducible docs with Quarto & Markdown -------- ##

# Start with the Markdown template!! It's a great on-ramp
# - show knitting to Word
# - show echo=FALSE
# - show how to type an equation!!
# - show matching formatting to another doc?



## -------- (we should totally add something about AI tools, and any other topics you might think of) -------- ##
