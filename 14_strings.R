library(tidyverse)
# 14.5.1 Exercises
# 1. How would you find all strings containing \ with regex() vs. with fixed()?

str_extract("me\\you", regex("\\\\"))
str_extract("me\\you", fixed("\\"))

# 2. What are the five most common words in sentences?
words <- str_split(sentences, boundary("word"))  %>% unlist()

tibble(words) %>% mutate(words = str_to_lower(words)) %>% count(words) %>% arrange(desc(n))

