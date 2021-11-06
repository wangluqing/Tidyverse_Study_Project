####################
#学习资料：
#
#创建时间：2021-11-16
####################

library(tidyverse)

diamonds %>% 
  group_by(clarity) %>% 
  summarise(
    m = mean(price)
  ) %>% 
  ungroup()

# ggplot包内置的数据集
data(package = "ggplot2")
glimpse(diamonds)
str(diamonds)
diamonds %>% 
  slice_head(n = 100) %>% 
  View
?diamonds

# dplyr包
# mutate()
diamonds %>% 
  mutate(
    JustOne = 1,
    Values = "something",
    Simple = TRUE
  ) %>% 
  slice_tail(n = 100) %>% 
  View

diamonds %>% 
  mutate(
    price200 = price - 200
  ) %>% 
  slice_head(n = 100) %>% 
  View

diamonds %>% 
  mutate(
    price200 = price - 200,
    price20perc = price * 0.20,
    price20percoff = price * 0.80,
    pricepercarat = price / carat,
    pizza = depth ^ 2
  ) %>% 
  slice_sample(n = 10) %>% 
  View

diamonds1 <- diamonds %>% 
  mutate(
    price200 = price - 200,
    price20perc = price * 0.20,
    price20percoff = price * 0.80,
    pricepercarat = price / carat,
    pizza = depth ^ 2
  ) %>% 
  slice_sample(n = 10)


diamonds %>% 
  mutate(m = mean(price)) %>% 
  slice_head(n = 100) %>% 
  View

diamonds %>% 
  mutate(
    m = mean(price),
    sd = sd(price),
    med = median(price)
  ) %>% 
  slice_head(n = 100) %>% 
  View

# 使用recode函数对变量取值做重编码操作
diamonds %>% 
  mutate(
    cut_new = recode(
      cut,
      "Fair" = "Okay",
      "Ideal" = "IDEAL"
    )
  ) %>% 
  slice_head(n = 100) %>% 
  View

Sex <- factor(c("male", "m", "M", "Female", "Female", "Female"))
TestScore <- c(10, 20, 10, 25, 12, 5)
dataset <- tibble(Sex, TestScore)
str(dataset)

dataset %>% 
  mutate(Sex_new = recode(Sex, 
                          "m" = "Male",
                          "M" = "Male",
                          "male" = "Male"))

# summarize()函数
diamonds %>% 
  summarise(avg_price = mean(price))

diamonds %>% 
  summarise(
    avg_price = mean(price),
    dbl_price = 2 * mean(price),
    random_add = 1 + 2,
    avg_carat = mean(carat),
    stdev_price = sd(price)
  ) %>% 
  slice_head(n = 100) %>% 
  View

# group_by()函数和ungroup()函数
ID <- c(1:50)
Sex <- rep(c("male", "female"), 25)
Age <- c(26, 25, 39, 37, 31, 34, 34, 30, 26, 33, 
         39, 28, 26, 29, 33, 22, 35, 23, 26, 36, 
         21, 20, 31, 21, 35, 39, 36, 22, 22, 25, 
         27, 30, 26, 34, 38, 39, 30, 29, 26, 25, 
         26, 36, 23, 21, 21, 39, 26, 26, 27, 21) 
Score <- c(0.010, 0.418, 0.014, 0.090, 0.061, 0.328, 0.656, 0.002, 0.639, 0.173, 
           0.076, 0.152, 0.467, 0.186, 0.520, 0.493, 0.388, 0.501, 0.800, 0.482, 
           0.384, 0.046, 0.920, 0.865, 0.625, 0.035, 0.501, 0.851, 0.285, 0.752, 
           0.686, 0.339, 0.710, 0.665, 0.214, 0.560, 0.287, 0.665, 0.630, 0.567, 
           0.812, 0.637, 0.772, 0.905, 0.405, 0.363, 0.773, 0.410, 0.535, 0.449)

data <- tibble(ID, Sex, Age, Score)
data %>% 
  group_by(Sex) %>% 
  summarise(
    m = mean(Score),
    s = sd(Score),
    n = n()
  ) %>% 
  View

data %>% 
  group_by(Sex) %>% 
  mutate(m = mean(Score)) %>%
  ungroup()

# filter()函数
diamonds %>% 
  filter(cut == "Fair") %>% 
  slice_head(n = 100) %>% 
  View

diamonds %>%
  filter(cut %in% c("Fair", "Good"), price <= 600) %>% 
  slice_head(n = 100) %>% 
  View

diamonds %>%
  filter(cut == "Fair", cut == "Good", price <= 600) %>% 
  slice_head(n = 100) %>% 
  View

# select()函数
diamonds %>% 
  select(cut, color) %>% 
  slice_head(n = 100) %>% 
  View

diamonds %>% 
  select(-(1:5)) %>% 
  slice_head(n = 100) %>% 
  View

diamonds %>% 
  select(x, y, z, everything()) %>% 
  slice_head(n = 100) %>% 
  View

diamonds %>% 
  arrange(cut) %>% 
  slice_head(n = 100) %>% 
  View

# count()函数
diamonds %>% 
  count(cut)

# 等价于
diamonds %>% 
  group_by(cut) %>% 
  count(cut)

# 等价于
diamonds %>% 
  group_by(cut) %>% 
  summarise(n = n())


# rename()函数
diamonds %>% 
  rename(PRICE = price) %>% 
  slice_head(n = 100) %>% 
  View

# 等价于
diamonds %>% 
  mutate(
    PRICE = price
  ) %>% 
  select(- price) %>% 
  slice_head(n = 100) %>% 
  View

# row_number()函数
practice <- 
  tibble(Subject = rep(c(1,2,3),8),
         Date = c("2019-01-02", "2019-01-02", "2019-01-02", 
                  "2019-01-03", "2019-01-03", "2019-01-03",
                  "2019-01-04", "2019-01-04", "2019-01-04", 
                  "2019-01-05", "2019-01-05", "2019-01-05", 
                  "2019-01-06", "2019-01-06", "2019-01-06", 
                  "2019-01-07", "2019-01-07", "2019-01-07",
                  "2019-01-08", "2019-01-08", "2019-01-08",
                  "2019-01-01", "2019-01-01", "2019-01-01"),
         DV = c(sample(1:10, 24, replace = TRUE)),
         Inject = rep(c("Pos", "Neg", "Neg", "Neg", "Pos", "Pos"), 4))

practice %>% 
  mutate(
    Session = row_number()
  ) %>% View

practice %>% 
  group_by(Subject, Inject) %>%
  mutate(Session = row_number()) %>% 
  View

# ifelse()函数
practice %>% 
  mutate(Health = ifelse(Subject == 1,
                         "sick",
                         "healthy")) %>% 
  View



