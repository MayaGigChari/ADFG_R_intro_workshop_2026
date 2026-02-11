# First we will start in base R

#Don't worry about understanding any of this yet. 


#R has a lot of built in datasets, so let's look at one of those. 

mtcars

View(mtcars)


# Let's say our goal is to find cars that have a miles per gallon of greater than 20, and we want to also select only the mpg and hp columns. 

#Here's how we do that in base R

results<- mtcars[mtcars$mpg> 20, c("mpg", "hp")]

#let's try to put what we see in a sentence. Without much understanding of R, it's very hard to do. 

#Let's load tidyverse and do this using dplyr

library(tidyverse)

results<- mtcars%>%
  filter(mpg>20)%>%
  select(mpg, hp)

#without knowing how to code at all, which one seems more intuitive to you?


#easy to put it into words: we take mtcars, we filter for mpg > 50 and then we select only the mpg and hp columns 
#similar to SQL!
