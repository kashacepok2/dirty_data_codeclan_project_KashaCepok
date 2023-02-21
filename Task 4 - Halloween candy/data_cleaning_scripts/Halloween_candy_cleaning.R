
library(tidyverse)
library(dplyr)
library(janitor)
#install.packages("here")
#install.packages("readxl")
library(here)
library(readxl)
library(stringr)

candy_2015 <- read_xlsx(here("raw data/boing-boing-candy-2015.xlsx"))
candy_2016 <- read_xlsx(here("raw data/boing-boing-candy-2016.xlsx"))
candy_2017 <- read_xlsx(here("raw data/boing-boing-candy-2017.xlsx"))

united_states <- c("'merica",
                   "america",
                   "Ahem....Amerca",
                   "Alaska",
                   "I pretend to be from Canada, but I am really from the United States.",
                   "Merica",
                   "Murica",
                   "murrika",
                   "N. America",
                   "New Jersey",
                   "New York",
                   "North Carolina",
                   "Pittsburgh",
                   "Sub-Canadian North America... 'Merica",
                   "the best one - usa",
                   "The United States",
                   "The Yoo Ess of Aaayyyyyy",
                   "Trumpistan",
                   "U S",
                   "u s a",
                   "u.s.",
                   "U.s.",
                   "U.S.",
                   "u.s.a.",
                   "U.S.A.",
                   "unhinged states",
                   "Unied States",
                   "unite states",
                   "United  States of America",
                   "United Sates",
                   "United staes",
                   "United State",
                   "United Statea",
                   "United Stated",
                   "United Stated",
                   "united states",
                   "United states",
                   "United States",
                   "united States",
                   "UNited States",
                   "united states of america",
                   "United Statss",
                   "United Stetes",
                   "united ststes",
                   "United ststes",
                   "Unites States",
                   "Units States",
                   "us",
                   "Us",
                   "US",
                   "US of A",
                   "usa",
                   "uSA",
                   "Usa",
                   "USa",
                   "USA",
                   "USA (I think but it's an election year so who can really tell)",
                   "USA USA USA",
                   "USA USA USA USA",
                   "USA USA USA!!!!",
                   "USA!",
                   "USA! USA!",
                   "USA! USA! USA!",
                   "USA!!!!!!",
                   "USA? Hard to tell anymore..",
                   "USAA",
                   "usas",
                   "USAUSAUSA",
                   "USSA")

canada <- c("Can",
            "canada",
            "CANADA",
            "Canada`",
            "soviet canuckistan")

uk <- c("endland",
        "england",
        "England",
        "Scotland",
        "U.K.",
        "uk",
        "Uk",
        "UK",
        "United Kindom",
        "United kingdom")

candy_2015_clean <- candy_2015 %>%
  clean_names() %>% 
  rename("100_grand_bar" = "x100_grand_bar") %>% 
  rename("going_trick_or_treating" = "are_you_going_actually_going_trick_or_treating_yourself") %>% 
  rename("age" = "how_old_are_you") %>%
  rename("hersheys_dark_chocolate" = "dark_chocolate_hershey") %>%
  rename("hersheys_kisses" = "hershey_s_kissables") %>% 
  rename("licorice_yes_black" = "licorice") %>% 
  select(2:96)
  
candy_2016_clean <- candy_2016 %>% 
  clean_names() %>% 
  rename("100_grand_bar" = "x100_grand_bar") %>% 
  rename("going_trick_or_treating" = "are_you_going_actually_going_trick_or_treating_yourself") %>% 
  rename("age" = "how_old_are_you") %>% 
  rename("gender" = "your_gender") %>%
  rename("country" = "which_country_do_you_live_in") %>% 
  rename("state_province_county_etc" = "which_state_province_county_do_you_live_in") %>%
  rename("box_o_raisins" = "boxo_raisins") %>%
  select(2:106)

candy_2017_clean <- candy_2017 %>% 
  clean_names() %>% 
  rename_with(.fn = ~str_remove(.x, "^q[:digit:]_"), .cols = everything()) %>% 
  rename("going_trick_or_treating" = "going_out") %>%
  rename("anonymous_brown_globs_that_come_in_black_and_orange_wrappers"
         = "anonymous_brown_globs_that_come_in_black_and_orange_wrappers_a_k_a_mary_janes") %>% 
  rename("box_o_raisins" = "boxo_raisins") %>%
  select(2:109)

candy_all <- bind_rows(list("2015" = candy_2015_clean,
               "2016" = candy_2016_clean,
               "2017" = candy_2017_clean), .id = "year")

candy_all_clean <- candy_all %>%
  mutate(country = case_when(
    country %in% united_states == TRUE ~ "United States of America",
    country %in% canada == TRUE ~ "Canada",
    country %in% uk == TRUE ~ "United Kingdom",
    TRUE ~ "Other")) %>%
  mutate(age = as.integer(age)) %>% 
  filter(age < 100) %>% 
  select(-c(vials_of_pure_high_fructose_corn_syrup_for_main_lining_into_your_vein,
            cash_or_other_forms_of_legal_tender,
            dental_paraphenalia,
            generic_brand_acetaminophen,
            glow_sticks,
            broken_glow_stick,
            creepy_religious_comics_chick_tracts,
            hugs_actual_physical_hugs,
            lapel_pins,
            joy_joy_mit_iodine,
            pencils,
            mint_juleps,
            mint_leaves,
            kale_smoothie,
            spotted_dick,
            peterson_brand_sidewalk_chalk,
            vicodin,
            white_bread,
            whole_wheat_anything,
            bonkers_the_board_game,
            chardonnay,
            person_of_interest_season_3_dvd_box_set_not_including_disc_4_with_hilarious_outtakes,
            real_housewives_of_orange_county_season_9_blue_ray)) %>% 
  relocate(gender, country, state_province_county_etc, .after = age) %>% 
  pivot_longer(c(7:101),
               names_to = "candy",
               values_to = "rating")

write_csv(candy_all_clean, here("clean_data/candy_all_clean.csv"))

  
  
  

