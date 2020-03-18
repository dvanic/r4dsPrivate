
# 20.3.5 Exercises

# Describe the difference between is.finite(x) and !is.infinite(x).
# 
# Read the source code for dplyr::near() (Hint: to see the source code, drop the ()). How does it work?
#   
#   A logical vector can take 3 possible values. How many possible values can an integer vector take? How many possible values can a double take? Use google to do some research.
# 
# Brainstorm at least four functions that allow you to convert a double to an integer. How do they differ? Be precise.
# 
# What functions from the readr package allow you to turn a string into logical, integer, and double vector?
#   
  

# 
# 20.4.6 Exercises
# 
# What does mean(is.na(x)) tell you about a vector x? What about sum(!is.finite(x))?
#   
#   Carefully read the documentation of is.vector(). What does it actually test for? Why does is.atomic() not agree with the definition of atomic vectors above?
#   
#   Compare and contrast setNames() with purrr::set_names().
# 
# Create functions that take a vector as input and returns:
#   
#   The last value. Should you use [ or [[?
#                                           
#                                           The elements at even numbered positions.
#                                         
#                                         Every element except the last value.
#                                         
#                                         Only even numbers (and no missing values).
#                                         
#                                         Why is x[-which(x > 0)] not the same as x[x <= 0]?
#                                           
#                                           What happens when you subset with a positive integer that’s bigger than the length of the vector? What happens when you subset with a name that doesn’t exist?

# 
# 20.5.4 Exercises
# 
# Draw the following lists as nested sets:
#   list(a, b, list(c, d), list(e, f))
# list(list(list(list(list(list(a))))))
# 
# What happens if you subset a tibble as if you’re subsetting a list? What are the key differences between a list and a tibble?
#   


# 20.7.4 Exercises
# 
# What does hms::hms(3600) return? How does it print? What primitive type is the augmented vector built on top of? What attributes does it use?
#   
# Try and make a tibble that has columns with different lengths. What happens?
#   
# Based on the definition above, is it ok to have a list as a column of a tibble?
  
  
                                          
                                          