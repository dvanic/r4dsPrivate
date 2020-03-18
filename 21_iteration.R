df <- tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)
output <- vector("double", ncol(df))  # 1. output
for (i in seq_along(df)) {            # 2. sequence
  output[[i]] <- median(df[[i]])      # 3. body
}

# 21.2.1 Exercises

# 1. Write for loops to:
# a. Compute the mean of every column in mtcars.
desired <- vector("double", length(mtcars))
names(desired) <- names(mtcars)
for (i in seq_along(mtcars)) {
  desired[[i]] <- mean(mtcars[[i]])
}
map_dbl(mtcars, mean)

# b. Determine the type of each column in nycflights13::flights
library(nycflights13)
desired <- vector("character", length(flights))
names(desired) <- names(flights)
for (i in seq_along(flights)) {
  desired[[i]] <- typeof(flights[[i]])
}

map_chr(nycflights13::flights, typeof)

# c. Compute the number of unique values in each column of iris.
desired <- vector("double", length(iris))
names(desired) <- names(iris)
for (i in seq_along(iris)) {
  desired[[i]] <- length(unique(iris[[i]]))
}

map_dbl(iris, ~length(unique(.x)))

# d. Generate 10 random normals from distributions with means of -10, 0, 10, and 100

map_dfc(means, ~rnorm(10, .x))

means <- list(-10,0,10,100)
desired <- vector("list", length(means))
for (i in seq_along(means)){
  desired[[i]] <- rnorm(10, mean = means[[i]])
}
as.data.frame(desired)



# 2. Eliminate the for loop in each of the following examples by taking advantage of an existing function that works with vectors:
# a.
# out <- ""
# for (x in letters) {
#   out <- stringr::str_c(out, x)
# }

str_c(letters,  collapse = "")

# b. 
# x <- sample(100)
# a <- 0
# for (i in seq_along(x)) {
#   a <- a + (x[i] - mean(x)) ^ 2
# }
# a <- sqrt(a / (length(x) - 1))

stats::sd(sample(100))

# c.
# x <- runif(100)
# out <- vector("numeric", length(x))
# out[1] <- x[1]
# for (i in 2:length(x)) {
#   out[i] <- out[i - 1] + x[i]
# }
cumsum(runif(100))

# 
# 3. Combine your function writing and for loop skills:
#   
#   Write a for loop that prints() the lyrics to the children’s song “Alice the camel”.
# 
humps <- c("five", "four", "three", "two", "one", "no")
for (i in seq_along(humps)){
  cat(rep(str_c("Alice the camel has", humps[[i]], "humps.\n", sep = " "), 3))
  if (humps[[i]] != "no"){
  cat("So go, Alice, go.\n\n")
  } else {
    # i == no
    cat("Now Alice is a horse.\n")
  }
}

# Convert the nursery rhyme “ten in the bed” to a function. Generalise it to any number of people in any sleeping structure.
# 
# Convert the song “99 bottles of beer on the wall” to a function. Generalise to any number of any vessel containing any liquid on any surface.
# 
# It’s common to see for loops that don’t preallocate the output and instead increase the length of a vector at each step:
#   
#   output <- vector("integer", 0)
# for (i in seq_along(x)) {
#   output <- c(output, lengths(x[[i]]))
# }
# output
# 
# How does this affect performance? Design and execute an experiment.

# 21.3.5 Exercises
# 
# 1. Imagine you have a directory full of CSV files that you want to read in. You have their paths in a vector, files <- dir("data/", pattern = "\\.csv$", full.names = TRUE), and now want to read each one with read_csv(). Write the for loop that will load them into a single data frame.

files <- dir(getwd(), pattern = "\\.csv$", full.names = TRUE)

tmp <- map_dfr(files, ~read_csv(.x))

# 
# What happens if you use for (nm in names(x)) and x has no names? What if only some of the elements are named? What if the names are not unique?


#   
#   Write a function that prints the mean of each numeric column in a data frame, along with its name. For example, show_mean(iris) would print:
#   
#   show_mean(iris)
# #> Sepal.Length: 5.84
# #> Sepal.Width:  3.06
# #> Petal.Length: 3.76
# #> Petal.Width:  1.20
# 
# (Extra challenge: what function did I use to make sure that the numbers lined up nicely, even though the variable names had different lengths?)
show_mean <- function(df){
  stopifnot(class(df) == "data.frame")
  whichcolsdouble <- map_lgl(df, is_double)
  whichcolsint <- map_lgl(df, is_integer)
  whichcolsnum <- whichcolsdouble | whichcolsint
  df_sub <- df[,whichcolsnum]
  map_dfc(mtcars, mean) %>% 
    pivot_longer(everything(),names_to = "variables",values_to = "mean")
}


# 
# What does this code do? How does it work?
#   
#   trans <- list( 
#     disp = function(x) x * 0.0163871,
#     am = function(x) {
#       factor(x, labels = c("auto", "manual"))
#     }
#   )
# for (var in names(trans)) {
#   mtcars[[var]] <- trans[[var]](mtcars[[var]])
# }



# 21.4.1 Exercises
# 
# Read the documentation for apply(). In the 2d case, what two for loops does it generalise?
#   
#   Adapt col_summary() so that it only applies to numeric columns You might want to start with an is_numeric() function that returns a logical vector that has a TRUE corresponding to each numeric column.


# 21.5.3 Exercises

# Write code that uses one of the map functions to:
#   Compute the mean of every column in mtcars.
# Determine the type of each column in nycflights13::flights.
# Compute the number of unique values in each column of iris.
# Generate 10 random normals from distributions with means of -10, 0, 10, and 100.
# 
# How can you create a single vector that for each column in a data frame indicates whether or not it’s a factor?
#   
#   What happens when you use the map functions on vectors that aren’t lists? What does map(1:5, runif) do? Why?
#   
#   What does map(-2:2, rnorm, n = 5) do? Why? What does map_dbl(-2:2, rnorm, n = 5) do? Why?
#   
#   Rewrite map(x, function(df) lm(mpg ~ wt, data = df)) to eliminate the anonymous function.


# 21.9.3 Exercises
# 
# Implement your own version of every() using a for loop. Compare it with purrr::every(). What does purrr’s version do that your version doesn’t?
#   
#   Create an enhanced col_summary() that applies a summary function to every numeric column in a data frame.
# 
# A possible base R equivalent of col_summary() is:
#   
#   col_sum3 <- function(df, f) {
#     is_num <- sapply(df, is.numeric)
#     df_num <- df[, is_num]
#     
#     sapply(df_num, f)
#   }
# 
# But it has a number of bugs as illustrated with the following inputs:
#   
#   df <- tibble(
#     x = 1:3, 
#     y = 3:1,
#     z = c("a", "b", "c")
#   )
# # OK
# col_sum3(df, mean)
# # Has problems: don't always return numeric vector
# col_sum3(df[1:2], mean)
# col_sum3(df[1], mean)
# col_sum3(df[0], mean)
# 
# What causes the bugs?
