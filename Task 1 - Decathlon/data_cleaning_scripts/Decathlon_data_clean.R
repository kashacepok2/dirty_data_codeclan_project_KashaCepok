
library(tidyverse)
library(janitor)
library(here)
library(dplyr)
library(tibble)
library(tools)

decathlon <- readRDS(here("Raw data/decathlon.rds"))

decathlon_clean <- decathlon %>% 
  rownames_to_column("name") %>%
  clean_names() %>%
  mutate(name = tolower(name)) %>% 
  mutate(name = toTitleCase(name)) %>% 
  rename("100m" = "x100m") %>% 
  rename("400m" = "x400m") %>% 
  rename("1500m" = "x1500m") %>% 
  rename("110m_hurdle" = "x110m_hurdle") %>% 
  pivot_longer("100m":"1500m",
               names_to = "event",
               values_to = "result")

write.csv(decathlon_clean, "clean_data/decathlon_clean")