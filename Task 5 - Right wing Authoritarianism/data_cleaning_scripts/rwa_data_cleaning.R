
library(tidyverse)
library(janitor)
library(dplyr)
library(here)
library(purrr)
library(magrittr)

rwa <- read_csv(here("raw_data/rwa.csv"))

reverse_num <- function(x) {
  return(as.integer(10 - x))
}

rwa_clean <- rwa %>%
  clean_names() %>% 
  filter(surveyaccurate == 1) %>% 
  filter(vcl6 == 0 & vcl9 == 0 & vcl12 == 0) %>% 
  select(3:22, 45:47, 63, 66, 69, 74:84, 86:90) %>%
  map_at(c("q4", "q6", "q8", "q9", "q11", "q13", "q15", "q18", "q20", "q21"), reverse_num) %>% 
  as.tibble() %>% 
  mutate(total_rwa_score =
           q3 + q4 + q5 + q6 + q7 + q8 + q9 + q10 + q11 + q12 + q13 +
           q14 + q15 + q16 + q17 + q18 + q19 + q20 + q21 + q22) %>%
  mutate(voted = case_when(
    voted == 1 ~ TRUE,
    voted == 2 ~ FALSE)
  ) %>% 
  mutate(engnat = case_when(
    engnat == 1 ~ TRUE,
    engnat == 2 ~ FALSE)
  ) %>% 
  mutate(education = case_when(
    education == 1 ~ "Less than high school",
    education == 2 ~ "High school",
    education == 3 ~ "University degree",
    education == 4 ~ "Graduate degree"
  )) %>%
  mutate(urban = case_when(
    urban == 1 ~ "Rural",
    urban == 2 ~ "Suburban",
    urban == 3 ~ "Urban"
  )) %>%
  mutate(gender = case_when(
    gender == 1 ~ "Male",
    gender == 2 ~ "Female",
    gender == 3 ~ "Other"
  )) %>%
  mutate(hand = case_when(
    hand == 1 ~ "Right",
    hand == 2 ~ "Left",
    hand == 3 ~ "Both"
  )) %>%
  mutate(orientation = case_when(
    orientation == 1 ~ "Heterosexual",
    orientation == 2 ~ "Bisexual",
    orientation == 3 ~ "Homosexual",
    orientation == 4 ~ "Asexual",
    orientation == 5 ~ "Other"
  )) %>%
  mutate(religion = case_when(
    religion == 1 ~ "Agnostic",
    religion == 2 ~ "Atheist",
    religion == 3 ~ "Buddhist",
    religion == 4 ~ "Catholic",
    religion == 5 ~ "Mormon",
    religion == 6 ~ "Protestant",
    religion == 7 ~ "Other Christian",
    religion == 8 ~ "Hindu",
    religion == 9 ~ "Jewish",
    religion == 10 ~ "Muslim",
    religion == 11 ~ "Sikh",
    religion == 12 ~ "Other"
  )) %>% 
  mutate(married = case_when(
    married == 1 ~ "Never married",
    married == 2 ~ "Currently married",
    married == 3 ~ "Previously married"
  ))

write.csv(rwa_clean, "clean_data/rwa_clean")
         
  