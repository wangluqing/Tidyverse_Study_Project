####################
# 数据变换 dplyr包
# R4DS 第3章
###################

library(nycflights13)
library(tidyverse)


# 1 nycflights13 ----------------------------------------------------------

flights
str(flights)
glimpse(flights)

flights %>% 
  slice_head(n = 100) %>% 
  View


# 2 dplyr Basics ----------------------------------------------------------


# 3 Filter Rows with filter() ---------------------------------------------



