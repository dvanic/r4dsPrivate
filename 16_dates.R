# 16.2.4 Exercises
# 1. What happens if you parse a string that contains invalid dates?
ymd(c("2010-10-10", "bananas"))

# it generats a warning message and returns NA at that position

# 2. What does the tzone argument to today() do? Why is it important?
today(tzone = "UTC")
# specifies the time zone
# because Australia's usually one day ahead of the world

# 3.Use the appropriate lubridate function to parse each of the following dates:
  
mdy("January 1, 2010")
ymd("2015-Mar-07")
dmy("06-Jun-2017")
mdy(c("August 19 (2015)", "July 1 (2015)"))
mdy("12/30/14") 

# 16.3.4 Exercises

# 1. How does the distribution of flight times within a day change over the course of the year?
# 2. Compare dep_time, sched_dep_time and dep_delay. Are they consistent? Explain your findings.
# 3. Compare air_time with the duration between the departure and arrival. Explain your findings. (Hint: consider the location of the airport.)
# How does the average delay time change over the course of a day? Should you use dep_time or sched_dep_time? Why?
#   
#   On what day of the week should you leave if you want to minimise the chance of a delay?
#   
#   What makes the distribution of diamonds$carat and flights$sched_dep_time similar?
#   
#   Confirm my hypothesis that the early departures of flights in minutes 20-30 and 50-60 are caused by scheduled flights that leave early. Hint: create a binary variable that tells you whether or not a flight was delayed.

# 16.4.5 Exercises

# Why is there months() but no dmonths()?
#   
#   Explain days(overnight * 1) to someone who has just started learning R. How does it work?
#   
#   Create a vector of dates giving the first day of every month in 2015. Create a vector of dates giving the first day of every month in the current year.
# 
# Write a function that given your birthday (as a date), returns how old you are in years.
# 
# Why can’t (today() %--% (today() + years(1))) / months(1) work?
  
