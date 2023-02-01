
# Loading required libraries and installing if not already
req_packages <- c("tidyverse","manifestoR","gt","gtExtras","scales","lubridate","ggiraph","htmltools")

for (i in req_packages){
  require(i, character.only = TRUE)
}

# Store api key in project folder. See manifestoR documentation for instructions
mp_setapikey("manifesto_apikey.txt")

# loading entire CMP data
cmp <- mp_maindataset()

# writing to csv file
write_csv(cmp,"cmp.csv")