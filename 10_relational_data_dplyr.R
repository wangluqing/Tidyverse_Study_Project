#############
#关系型数据
#dplyr包
#学习资料：R4DS第10章
############

# 准备工作
library(tidyverse)
library(nycflights13)

data(package="nycflights13")

glimpse(airlines)
glimpse(airports)
glimpse(planes)
glimpse(weather)
glimpse(flights)

# 主键判断
# 用于唯一标识表的样本
planes %>% 
  count(tailnum) %>% 
  filter(n > 1)

weather %>% 
  count(year, month, day, hour, origin) %>% 
  filter(n > 1)

flights %>% 
  count(year, month, day, flight) %>% 
  filter(n > 1)

flights %>% 
  count(year, month, day, tailnum) %>% 
  filter(n > 1)

# 表格没有主键的解决方案
# 使用mutate()或者row_number()增加一个标记


# Mutating Joins
flights2 <- flights %>% 
  select(year:day, hour, origin, dest, tailnum, carrier)
flights2 %>% 
  slice_head(n = 100) %>% 
  View

# 想知道full airline name的全名
flights2 %>% 
  select(-origin, -dest) %>% 
  left_join(airlines, by = "carrier") %>% 
  slice_head(n = 100) %>% 
  View

# 等价于
flights2 %>% 
  select(-origin, -dest) %>% 
  mutate(
    name = airlines$name[match(carrier, airlines$carrier)]
  ) %>% 
  slice_head(n = 100) %>% 
  View


# 理解Joins
x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  3, "x3"
)

y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2",
  4, "y4"
)

# inner_join
x %>% 
  inner_join(y, by = "key") %>% 
  View

# outer joins
# 1) left join
# 2) right join
# 3) full join

# Filter Joins
# 1) semi_join
# 2) anti_join
top_dest <- flights %>% 
  count(dest, sort = TRUE) %>% 
  head(10)

top_dest %>% 
  View

flights %>% 
  filter(dest %in% top_dest$dest) %>% 
  slice_head(n = 100) %>% 
  View

flights %>% 
  semi_join(top_dest) %>% 
  slice_head(n = 100) %>% 
  View
