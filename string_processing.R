library(rvest)
library(tidyverse)
library(stringr)
url <- "https://en.wikipedia.org/w/index.php?title=Opinion_polling_for_the_United_Kingdom_European_Union_membership_referendum&oldid=896735054"
tab <- read_html(url) %>% html_nodes("table")
polls <- tab[[6]] %>% html_table(fill = TRUE)

polls <- polls %>% setNames(c("dates", "remain", "leave", "undecided", "lead", "samplesize", "pollster", "poll_type", "notes")) %>% 
  filter(str_detect(remain,"%$"))


str_replace(polls$undecided, "N/A", "0")

temp <- str_extract_all(polls$dates, "\\d+\\s[a-zA-Z]+")
end_date <- sapply(temp, function(x) x[length(x)]) # take last element (handles polls that cross month boundaries)

#### Dates & Times ####
library(dslabs)
library(lubridate)
data(brexit_polls)
sum(month(brexit_polls$startdate) == 4)
sum(round_date(brexit_polls$enddate, unit = "week") == "2016-06-12")
table(weekdays(brexit_polls$enddate))

data(movielens)
table(hour(as_datetime(movielens$timestamp)))


#### Dates, Times & text mining ####
library(tidyverse)
library(gutenbergr)
library(tidytext)
options(digits = 3)
gutenberg_metadata

install.packages("lazyeval")
install.packages("urltools")
url <- "https://cran.r-project.org/src/contrib/Archive/gutenbergr/gutenbergr_0.2.3.tar.gz" 
rchive_gb <- "gutenbergr_0.2.3.tar.gz" 
download.file(url = url, destfile = rchive_gb) 
install.packages(pkgs=rchive_gb, type="source", repos=NULL) 
unlink(rchive_gb) 
library(gutenbergr)

str_detect(gutenberg_metadata$title,"Pride and Prejudice") 

gutenberg_metadata %>%
  filter(str_detect(title, "Pride and Prejudice"))

gutenberg_works(title == "Pride and Prejudice")

book <- gutenberg_download(1342)
words <- book %>%
  unnest_tokens(word, text)
nrow(words)

words <- words %>% anti_join(stop_words)
nrow(words)

words <- words %>%
  filter(!str_detect(word, "\\d"))
nrow(words)

words %>%
  count(word) %>%
  filter(n > 100) %>%
  nrow()

words %>%
  count(word) %>%
  top_n(1, n) %>%
  pull(word)

words %>%
  count(word) %>%
  top_n(1, n) %>%
  pull(n)

afinn_sentiments <- inner_join(words, afinn, join_by(word))
afinn_sentiments
pos <- filter(afinn_sentiments, afinn_sentiments$value == 4)
pos
