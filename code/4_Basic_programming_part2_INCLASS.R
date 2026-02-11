# ADF&G R Intro Workshop
# Logan Wendling & Matt Tyers
# logan.wendling@alaska.gov
# matt.tyers@alaska.gov


#####         SCRIPT 4            #####
##### PROGRAMMING BASICS, part II #####

### Blank space for in-class stuff!
























### Exercises


# ------------ part 1 ------------ #
# Run the following code to load data vector x.
x <- c(7, 2, 6, 8, 6, 3, 2, 5, 8, 2)     # yes, I totally just mashed some keys

# (a)
# Modify the code below to return the third element of x.
x[]

# (b)
# Now return elements 1 through 5 of x.  Hint: remember :?

# (c)
# Use the operator <- to assign the value 999 to the first 5 elements of x.
# For some reason.




# ------------ part 2 ------------ #

# Run the following code to load a data frame.  Inspect the results.
catch_data <- data.frame(Sex = rep(c("F", "M"), 6),
                         Length = c(395.1, 345.3, 364.1, 560.5, 306.1, 473.6,
                                    374.1,  19.6,  16.5,  19.8,  15.0,  12.8),
                         Tech = c(rep("Arthur", 4), rep("Beverly", 3), rep("Chuck", 5)))
catch_data

# (a)
# Modify the code below to return just the first row.
catch_data[]

# Modify the code below to return just the Length column (using square brackets).
catch_data[,2]

# Now return the Length column by its name (hint: you can resort to bribery)
catch_data


# (b)
# Oh noes!! Chuck recorded his measurements in inches, not mm!  Good news, we can
# fix this.  First, modify the code below to construct a logical statement to
# return just the Length measurements associated with Chuck.
## Answer: 19.6 16.5 19.8 15.0 12.8
catch_data$Length[]


# Use this logical statement in an ifelse() to construct a new column of lengths
# that are converted to mm if needed.
## Answer:
# > catch_data$Length_fix
# [1] 395.10 345.30 364.10 560.50 306.10 473.60
# 374.10 497.84 419.10 502.92 381.00 325.12
catch_data$Length_fix <- ifelse(,                       # logical statement here
                                catch_data$Length*25.4, # if TRUE (convert to mm)
)                       # if FALSE (leave it alone)


# ------------ part 3 ------------ #

# Run the following code to load a data frame.  Inspect the results.
weir_data <- data.frame(Year = c(rep(2023, 4), rep(2024, 6), rep(2025, 5)),
                        Channel = c("West", NA, "West", "East", "East",
                                    "East", "East", "West", "West", "East",
                                    "East", "East", "West", NA, "West"),
                        Length_mm = c(313, 346, 362, 309, 211, 334, 324, 358,
                                      287, 335, 264, 388, 319, 310, 283))
weir_data

# (a)
# Calculate the average (mean) length measurement.  Your manager wants to know.
## Answer: 316.2
mean<- mean(weir_data$Length_mm)

# (b)
# Now your manager is asking for the average length for 2025.  It's what managers do.
# Hint: use a logical statement to take a subset.
## Answer: 312.8
mean<- mean(weir_data$Length_mm[weir_data$Year == 2025])

# (c)
# What is the average length where the Channel was not missing (i.e. not NA)?
## Answer: 314.3846

mean<- mean(weir_data$Length_mm[!is.na(weir_data$Channel)])

# (bonus)
# Run the following statements:
sum(is.na(weir_data$Channel))
mean(is.na(weir_data$Channel))
# What do these answers represent?
# How does this calculation work?
