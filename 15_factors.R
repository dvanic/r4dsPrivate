# 15.3.1 Exercise
# Explore the distribution of rincome (reported income). What makes the default bar chart hard to understand? How could you improve the plot?
gss_cat %>%  ggplot(aes(x = rincome))+ geom_bar()+ theme(axis.text.x = element_text(angle = 90, hjust = 1))



gss_cat %>%  
  mutate(rincome = fct_rev(rincome)) %>%
  ggplot(aes(x = fct_relevel(rincome, c("Refused", "Don't know", "No answer", "Not applicable"), after = Inf))) + 
  geom_bar()+ theme(axis.text.x = element_text(angle = 90, hjust = 1))

# What is the most common relig in this survey? What’s the most common partyid?
# Protestant
gss_cat %>% count(relig)%>% arrange(desc(n))
# Independent
gss_cat %>% count(partyid)%>% arrange(desc(n))

# Which relig does denom (denomination) apply to? How can you find out with a table? How can you find out with a visualisation?

gss_cat %>% filter(denom != "Not applicable") %>% 
  select(relig) %>% 
  group_by(relig) %>% 
  count()

gss_cat %>% 
  filter(denom != "Not applicable") %>%
  ggplot(aes(x = denom, fill = relig)) + geom_bar() + theme(axis.text.x = element_text(angle = 90, hjust = 1)) + coord_flip()

# 15.4.1 Exercises
# 1.There are some suspiciously high numbers in tvhours. Is the mean a good summary?
gss_cat %>% ggplot(aes(x = tvhours))  + geom_bar()
# 24 hours is odd. 
gss_cat %>% ggplot(aes(y = tvhours))  + geom_boxplot()
summary(gss_cat$tvhours)
# Mean is 3, median is 2, so it's an OK, but not terrible summary

# 2. For each factor in gss_cat identify whether the order of the levels is arbitrary or principled.
glimpse(gss_cat)
# levels(gss_cat$marital)
# arbitrary

# 3. Why did moving “Not applicable” to the front of the levels move it to the bottom of the plot?
# it was assigned a level of 1

# 15.5.1 Exercises
# 1. How have the proportions of people identifying as Democrat, Republican, and Independent changed over time?
gss_cat %>% select(year, partyid) %>%
  mutate(partyid = 
  fct_collapse(partyid,
               "Democrat" = c("Strong democrat", "Not str democrat"),
               "Independent" = c("Ind,near dem", "Independent", "Ind,near rep"),
               "Republican" = c("Not str republican", "Strong republican"),
               "Other" = c("No answer", "Don't know", "Other party"))) %>%
  ggplot(aes(x = year, fill = partyid)) + geom_bar(position = "fill")

# 2.How could you collapse rincome into a small set of categories?

str_extract(levels(gss_cat$rincome), "^[A-z].+")  

mylevels <- levels(gss_cat$rincome)

gss_cat %>% mutate( rincome = fct_collapse(rincome,
                    "test" = str_extract(mylevels, "^[NDR].+"),
                    "Under10k" = c("Lt $1000",  str_c("$", c(1,3,4,5,6,7,8), "000 to ", c(2,3,4,5,6,7,9), "999"))),
                    "10k+" = str_c("$", c(10,15,20), "000 to ", c(14,19,24), "999")
                    )
# debug this later
 


  