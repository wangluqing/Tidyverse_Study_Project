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

filter(flights, month == 1, day == 1)
jan1 <- filter(flights, month == 1, day == 1)
(dec25 <- filter(flights, month == 12, day == 25))

# filter(flights, month = 1)
sqrt(2) ^ 2 == 2
1/49 * 49 == 1

near(sqrt(2) ^ 2, 2)
near(1 / 49 * 49, 1)

filter(flights, month == 11 | month == 12)
nov_dec <- filter(flights, month %in% c(11, 12))

filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120, dep_delay <= 120)

df <- tibble(x = c(1, NA, 3))

filter(df, x > 1)
filter(df, is.na(x) | x > 1)

arrange(flights, year, month, day)
arrange(flights, desc(arr_delay))

df <- tibble(x = c(5, 2, NA))
arrange(df, x)

arrange(df, desc(x))


# 4 Select Columns with select() ------------------------------------------

select(flights, year, month, day)
select(flights, year:day)
select(flights, -(year:day))
rename(flights, tail_num = tailnum)

select(flights, time_hour, air_time, everything())

# 5 Add New Variables with mutate() ---------------------------------------

flights_sml <- select(flights,
                      year:day,
                      ends_with("delay"),
                      distance,
                      air_time
)

mutate(flights_sml,
       gain = arr_delay - dep_delay,
       speed = distance / air_time * 60
)

mutate(flights_sml,
       gain = arr_delay - dep_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours
)

transmute(flights,
          gain = arr_delay - dep_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours
)

transmute(flights,
          dep_time,
          hour = dep_time %/% 100,
          minute = dep_time %% 100
)


# 6 Grouped Summaries with summarize() ------------------------------------

summarize(flights, delay = mean(dep_delay, na.rm = TRUE))
by_day <- group_by(flights, year, month, day)
summarize(by_day, delay = mean(dep_delay, na.rm = TRUE))



# 7 Combining Multiple Operations with the Pipe ---------------------------


