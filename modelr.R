# One downside of the linear model is that it is sensitive to unusual values because the distance incorporates a squared term. Fit a linear model to the simulated data below, and visualise the results. Rerun a few times to generate different simulated datasets. What do you notice about the model?

sim1a <- tibble(
  x = rep(1:10, each = 3),
  y = x * 1.5 + 6 + rt(length(x), df = 2)
)
ggplot(sim1a, aes(x = x, y = y)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)


#  We can also do this more systematically, by generating several simulations and plotting the line.
simt <- function(i) {
  tibble(
    x = rep(1:10, each = 3),
    # using a students t distribution
    y = x * 1.5 + 6 + rt(length(x), df = 2),
    .id = i
  )
}
sims <- map_df(1:12, simt)
ggplot(sims, aes(x = x, y = y)) +
  geom_point() +
  geom_smooth(method = "lm", colour = "red") +
  facet_wrap(~.id, ncol = 4)


# For a normal distribution with mean zero and standard deviation one, the probability of being greater than 2 is,
pnorm(2, lower.tail = FALSE)

pt(2, df = 2, lower.tail = FALSE)

### 20.3.1.2  --------------
# One way to make linear models more robust is to use a different distance measure. For example, instead of root-mean-squared distance, you could use mean-absolute distance:

measure_distance_mad <- function(mod, data) {
  diff <- data$y - model1(mod, data)
  mean(abs(diff))
}
# SOLUTION
# get model1 from previous exercise and dist for rmse
model1 <- function(a, data) {
  a[1] + data$x * a[2]
}
measure_distance_rmse <- function(mod, data) {
  diff <- data$y - model1(mod, data)
  sqrt(mean(diff ^ 2))
}

# For rmse we end up wth:
optim(c(0, 0), measure_distance_rmse, data = sim1)$par
# For mad we end up wth:
optim(c(0, 0), measure_distance, data = sim1)$par


edi

