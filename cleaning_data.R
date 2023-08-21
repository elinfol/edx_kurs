library(tidyverse)

path <- system.file("extdata", package = "dslabs")
fname <- "life-expectancy-and-fertility-two-countries-example.csv"
filename <- file.path(path, fname)
raw_dat <- read_csv(filename)
#select(raw_dat, 1:4)
dat <- raw_dat %>% pivot_longer(-country)
#head(dat)

#The seperate() function takes 3 arguments apart from the data:
#1 the name of the columns to be seperated
#2 the names to be used for the new columns
#3 the character that seperates the variables

#dat %>% separate(name, c("year", "name"), sep = "_")

#since _ is the default seperator we dont need to specify this, we also want to 
#convert the years to numeric:

#dat %>% separate(name, c("year", "name"), convert = TRUE)

#since there's a _ in life_expectancy we have to use extra="merge" to merge when theres
#an extra _
dat %>% separate(name, c("year", "name"), sep = "_", extra = "merge", convert = TRUE) %>%

#to create a column for each variable we use: (obs piped)
pivot_wider()

#One more way of doing what we did above:

#dat %>%
#  separate(name, c("year", "name_1", "name_2"), 
#           fill = "right", convert = TRUE) %>%
#  unite(name, name_1, name_2, sep = "-") %>%
#  spread(name, value) %>%
#  rename(fertility = "fertility-NA")




