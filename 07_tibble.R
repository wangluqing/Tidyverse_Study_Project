################
#tibble学习
#R4DS第7章
################

library(tidyverse)


# 1 Creating tibbles ------------------------------------------------------

as_tibble(iris)

tibble(
  x = 1:5, 
  y = 1,
  z = x ^ 2 + y
)

tribble(
  ~x, ~y, ~z,
  "a", 2, 3.6,
  "b", 1, 8.5
)



# 2 Tibbles versus data.frame ---------------------------------------------

tibble(
  a = lubridate::now() + runif(1e3) * 86400,
  b = lubridate::today() + runif(1e3) * 30,
  c = 1:1e3,
  d = runif(1e3),
  e = sample(letters, 1e3, replace = TRUE)
)

nycflights13::flights %>%
  print(n = 10, width = Inf)

df <- tibble(
  x = runif(5),
  y = rnorm(5)
)

df$x
df[["x"]]
df[[1]]

df %>% .$x
df %>% .[["x"]]
