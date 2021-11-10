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
str_view(x, "C{2,3}?")
str_view(x, "C[LX]+?")


# detect matches
x <- c("apple", "banana", "pear")
str_detect(x, "e")

words
sum(str_detect(words, "^t"))
mean(str_detect(words, "[aeiou]$"))

no_vowels_1 <- !str_detect(words, "[aeiou]")

words[str_detect(words, "x$")]
str_subset(words, "x$")

df <- tibble(
  word = words,
  i = seq_along(word)
)
df %>% View

df %>% 
  filter(str_detect(word, "x$"))

x <- c("apple", "banana", "pear")
str_count(x, "a")

mean(str_count(words, "[aeiou]"))

df %>% 
  mutate(
    vowels = str_count(word, "[aeiou]"),
    consonants = str_count(word, "[^aeiou]")
  ) %>% 
  slice_head(n = 100) %>% 
  View

str_count("abababa", "aba")
str_view_all("abababa", "aba")

# Extract Matches
length(sentences)
head(sentences)
str(sentences)
typeof(sentences)

colors <- c(
  "red", "orange", "yellow", "green", "blue", "purple"
)

color_match <- str_c(colors, collapse = "|")
color_match

has_color <- str_subset(sentences, color_match)
has_color

matches <- str_extract(has_color, color_match)
matches

more <- sentences[str_count(sentences, color_match) > 1]
str_view_all(more, color_match)

str_extract(more, color_match)
str_extract_all(more, color_match)
str_extract_all(more, color_match, simplify = TRUE)

x <- c("a", "a b", "a b c")
str_extract_all(x, "[a-z]", simplify = TRUE)


# Grouped Matches
noun <- "(a|the) ([^ ]+)"
has_noun <- sentences %>%
  str_subset(noun) %>%
  head(10)
has_noun %>%
  str_extract(noun)

has_noun %>%
  str_match(noun)

tibble(sentence = sentences) %>%
  tidyr::extract(
    sentence, c("article", "noun"), "(a|the) ([^ ]+)",
    remove = FALSE
  )


# Replace Matches
x <- c("apple", "pear", "banana")
str_replace(x, "[aeiou]", "-")

str_replace_all(x, "[aeiou]", "-")

x <- c("1 house", "2 cars", "3 people")
str_replace_all(x, c("1" = "one", "2" = "two", "3" = "three"))



sentences %>%
  str_replace("([^ ]+) ([^ ]+) ([^ ]+)", "\\1 \\3 \\2") %>%
  head(5)

sentences %>% 
  head(5)

# Splitting
sentences %>% 
  head(5) %>% 
  str_split(" ")

"a|b|c|d" %>%
  str_split("\\|") 

sentences %>%
  head(5) %>%
  str_split(" ", simplify = TRUE)

fields <- c("Name: Hadley", "Country: NZ", "Age: 35")
fields %>% str_split(": ", n = 2, simplify = TRUE)

x <- "This is a sentence. This is another sentence."
str_view_all(x, boundary("word"))

str_split(x, " ")[[1]]

str_split(x, boundary("word"))[[1]]

# Find Matches
str_view(fruit, "nana")
str_view(fruit, regex("nana"))
bananas <- c("banana", "Banana", "BANANA")
str_view(bananas, "banana")

str_view(bananas, regex("banana", ignore_case = TRUE))
x <- "Line 1\nLine 2\nLine 3"
str_extract_all(x, "^Line")[[1]]

str_extract_all(x, regex("^Line", multiline = TRUE))[[1]]

