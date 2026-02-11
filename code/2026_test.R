### Below is a base R function for calculating the rolling mean of a dataset. 

set.seed(123)
x <- c(NA, rnorm(20), NA)

plot(x)


rolling_mean_base <- function(x, k) {
  
  if (k %% 2 == 0) {
    stop("k must be odd")
  }
  
  n <- length(x)
  h <- floor(k / 2)
  out <- rep(NA_real_, n)
  
  for (i in seq_len(n)) {
    
    # require full window
    if (i - h < 1 || i + h > n) {
      next
    }
    
    window <- x[(i - h):(i + h)]
    
    # match rollmean(): any NA -> NA
    if (any(is.na(window))) {
      out[i] <- NA_real_
    } else {
      out[i] <- mean(window)
    }
  }
  
  out
}


rm_base <- rolling_mean_base(x, k = 5)

print(rm_base)



### Then we will simplify by loading the package zoo

install.packages("zoo")
library(zoo)

zoo

ls("package:zoo")


rm_pkg <- zoo::rollmean(
  x,
  k = 5,
  fill = NA,
  align = "center"
)

print("Rolling mean using zoo::rollmean()")
print(rm_pkg)
