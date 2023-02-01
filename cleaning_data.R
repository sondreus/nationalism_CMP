# required packages loaded in get_data.R script

# Loading data

cmp <- read_csv("cmp.csv")


# reducing data to relative subset
data <-
  cmp %>% 
  select(date, 
         partyname, 
         countryname, 
         dep_immigration = per601_2, # anti-immigration
         dep_nation = per601_1, # pro-nation
         dep_law = per605_1, # pro-law
         dep_cultural = per608 ) # anti-multicultural

# Cleaning up a bit
data_r <- 
  data %>% 
  replace_na(list(dep_immigration = 0,  # replacing missing with 0 values
                  dep_nation = 0,
                  dep_law = 0,
                  dep_cultural = 0)) %>% 
  mutate(date = lubridate::ym(date), # creating year variable
         year = lubridate::year(date),
         party_lab = paste(partyname, countryname, year, sep = " | "), # creating party-country-year label
         across(starts_with("dep"), ~ scales::rescale(.x,c(0,1)), .names = "scale_{.col}") # creating rescaled variables to 0,1
  ) %>% 
  rowwise() %>%  # creating sum of measures
  mutate(nat_scale = sum(c(scale_dep_immigration,
                           scale_dep_nation,
                           scale_dep_law,
                           scale_dep_cultural))) %>% 
  ungroup() 
