#####################
#字符串数据处理
#stringr包
#学习资料：R4DS第11章
#####################

# 准备工作
library(tidyverse)
library(stringr)

# Basic Strings
string1 <- "This is a string"
string2 <- 'To put "quote" inside a string, use single quotes'
print(string1)
print(string2)

# 字符串处理函数集
str_length(c("a", "R for data science", NA))

# 字符串连接
str_c("x", "y")
str_c("x", "y", "z")
str_c("x", "y", sep = ",")

x <- c("abc", NA)
str_c("|-", x, "-|")
str_c("|-", str_replace_na(x), "-|")
str_c("prefix-", c("a", "b", "c"), "-suffix")

name <- "Hadley"
time_of_day <- "morning"
birthday <- FALSE

str_c(
  "Good", time_of_day, " ", name,
  if(birthday) " and HAPPY BIRTHDAY",
  "."
)

str_c(c("x", "y", "z"), collapse = ", ")

# 子串获取
x <- c("Apple", "Banana", "Pear")
str_sub(x, 1, 3)
str_sub(x, -3, -1)

str_sub(x, 1, 1) <- str_to_lower(str_sub(x, 1, 1))
x

# 定位
x <- c("apple", "eggplant", "banana")
str_sort(x, locale = "en")
str_sort(x, locale = "haw")

# 重点和难点：
# 使用正则表达式匹配模式
# 模式洞见
x <- c("apple", "banana", "pear")
str_view(x, "an")
str_view(x, ".a.")

str_view(c("abc", "a.c", "bef"), "a\\.c")

# Anchors
x <- c("apple", "banana", "pear")
str_view(x, "^a")
str_view(x, "a$")

x <- c("apple pie", "apple", "apple cake")
str_view(x, "apple")
str_view(x, "^apple$")

# Character Classes and Alternatives
str_view(c("grey", "gray"), "gr(e|a)y")
str_view(c("grey", "gray"), "gr[e|a]y")





# 匹配的次数
x <- "1888 is the longest year in Roman numerals: MDCCCLXXXVIII"
str_view(x, "CC?")
str_view(x, "CC+")
str_view(x, "C[LX]+")
str_view(x, "C{2}")
str_view(x, "C{2,}")
str_view(x, "C{2,3}")






