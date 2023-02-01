
# required packages loaded in get_data.R script

# Getting country flag images for table
flags <- read.csv("https://query.data.world/s/qfhl3i2o7xbuckxavnhih7cmgc4fo4", header=TRUE, stringsAsFactors=FALSE);

# creating palettes for heat map in table
blue_palette <- c("#EBEDFA","#141F52")
green_palette <- c("#E9FCF8", "#1DC9A4")

# reshaping and cleaning data for table
data_table <-
    data_r %>% # using cleaned data_r object from get_data.R script
    left_join(flags, by = c("countryname" = "Country")) %>%
    ungroup() %>% 
    mutate(nat_scale = scales::rescale(nat_scale,c(0,1))) %>% 
    arrange(-nat_scale) %>% # ordering by nationalism scale
    slice(1:50) %>% # selecting top-50 parties
    select(
      "Party" = partyname,
      "flag_URL" = ImageURL,
      "Country" = countryname,
      "Year" = year,
      "Nationalism index" = nat_scale,
      "Nation positive" = scale_dep_nation,
      "Anti-immigration" = scale_dep_immigration,
      "Homogeneous culture" = scale_dep_cultural,
      "Law and Order" = scale_dep_law
    )

data_table %>%
  gt::gt() %>% # creating gt table
  gt::text_transform( 
    #Apply a function to a column
    locations = cells_body(c(flag_URL)),
    fn = function(x) {
      #Return an image of set dimensions
      web_image(
        url = x,
        height = 12
      )
    }
  ) %>% 
  #Hide column header flag_URL and reduce width
  cols_width(c(flag_URL) ~ px(30)) %>% 
  cols_label(flag_URL = "") %>% 
  tab_style(
    locations = cells_title(groups = "title"),
    style     = list(
      cell_text(weight = "bold", size = 24)
    )
  ) %>% 
  gtExtras::gt_theme_538() %>% 
  gt::fmt_number(columns = 5:9,
                 decimals = 2) %>% 
  data_color(columns = 5,
             colors = scales::col_numeric(
               palette = blue_palette,
               domain = c(0,1))
  )%>% 
  data_color(columns = 6:9,
             colors = scales::col_numeric(palette = green_palette,
                                          domain = c(0,1))) %>% 
  tab_header(title = "Top-50 most nationalistic parties based on nationalism index, 1920-2021") %>% 
  tab_source_note(source_note = "Data: Comparative Manifesto Data | Columns normalized to have max. value of 1 and min. value of 0. Nationalism Index = sum of normalized statment categories.") %>%
  opt_table_font(font = "Milo") 
