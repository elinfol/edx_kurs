library(tidyverse)
library(dslabs)

co2_wide <- data.frame(matrix(co2, ncol = 12, byrow = TRUE)) %>% 
  setNames(1:12) %>%
  mutate(year = as.character(1959:1997))

co2_tidy <- pivot_longer(co2_wide, -year, names_to = "month", values_to = "co2")

co2_tidy %>% ggplot(aes(as.numeric(month), co2, color = year)) + geom_line()

data(admissions)
dat <- admissions %>% select(-applicants)
dat_tidy <- pivot_wider(dat, names_from = gender, values_from = admitted)

tmp <- admissions %>%
  pivot_longer(cols = c(admitted, applicants), names_to = "key", values_to = "value")
tmp2 <- unite(tmp, column_name, c(key, gender)) 
temp2_tidy <- pivot_wider(tmp2, names_from = column_name, values_from = value)

#COMBINING DATA 

library(Lahman)
top <- Batting %>% 
  filter(yearID == 2016) %>%
  arrange(desc(HR)) %>%    # arrange by descending HR count
  slice(1:10)    # take entries 1-10
#top %>% as_tibble()

#People %>% as_tibble()

top_names <- top %>% left_join(People) %>%
  select(playerID)#, nameFirst, nameLast, HR)

top_salary <- Salaries %>% filter(yearID == 2016) %>%
  right_join(top_names) %>%
  select(nameFirst, nameLast, teamID, HR, salary)

awards_2016 <- AwardsPlayers  %>% filter(yearID == "2016") %>%
  select(playerID)
