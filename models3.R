library(gapminder)
by_country <- gapminder %>% 
  # continent is redundant but doesn't get nested :)
  group_by(country, continent) %>% 
  nest()
country_model <- function(df) {
  lm(lifeExp ~ year, data = df)
}

by_country <- by_country %>% 
  mutate(model = purrr::map(data, country_model)) %>%
  mutate(resids = map2(data, model, add_residuals))

unnest(by_country, resids) %>% ggplot(aes(year, resid)) +
  geom_line(aes(group = country), alpha = 1 / 3) + 
  geom_smooth(se = FALSE)  + 
  facet_wrap(~continent)


myglance <- by_country %>% 
  mutate(glance = map(model, broom::glance)) %>% 
  # new syntax 
  select(-model, -data) %>%
  unnest(glance)

myglance %>% 
  ggplot(aes(continent, r.squared)) + 
  geom_jitter(width = 0.5)

bad_fit <- filter(myglance, r.squared < 0.25)
gapminder %>% 
  semi_join(bad_fit, by = "country") %>% 
  ggplot(aes(year, lifeExp, colour = country)) +
  geom_line()


## Not done - challenges
25.2.5 Exercises

A linear trend seems to be slightly too simple for the overall trend. Can you do better with a quadratic polynomial? How can you interpret the coefficients of the quadratic? (Hint you might want to transform year so that it has mean zero.)

Explore other methods for visualising the distribution of R2

per continent. You might want to try the ggbeeswarm package, which provides similar methods for avoiding overlaps as jitter, but uses deterministic methods.

To create the last plot (showing the data for the countries with the worst model fits), we needed two steps: we created a data frame with one row per country and then semi-joined it to the original dataset. It’s possible to avoid this join if we use unnest() instead of unnest(.drop = TRUE). How?