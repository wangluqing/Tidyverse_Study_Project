#####################
#管道操作
#R4DS第14章学习
#####################

# 利用管道操作
# 代码易读性

library(magrittr)

diamonds <- ggplot2::diamonds
diamonds2 <- diamonds %>%
  dplyr::mutate(price_per_carat = price / carat)

