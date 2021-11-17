#################
#工作流：项目
#R4DS第6章：项目
#################

# 快捷键：
# Ctrl + shift + F10 重启RStudio
# Ctrl + shift + S 运行当前的脚本

# 创建R项目
# 项目管理

library(tidyverse)

ggplot(diamonds, aes(carat, price)) +
  geom_hex()
ggsave("./figs/diamonds.pdf")

write_csv(diamonds, "./output/diamonds.csv")

# 总结：
# 利用项目来管理R语言的工作

