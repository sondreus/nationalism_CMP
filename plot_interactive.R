# required packages loaded in get_data.R script

# creating Economist-themed palette
economist_red <- "#F6423C"
blue <- "#141F52"
green <- "#1DC9A4"
yellow <- "#FBD051"
grey <- "#333333"

palette <- c(blue,economist_red,yellow,grey)


# defining plot 

plot <-
  data_r %>% 
  pivot_longer(
    cols = starts_with("dep"),
    names_to = "vars",
    values_to = "value"
  ) %>% 
  mutate("Type of statement" = factor(vars,
                                      levels = c("dep_nation",
                                                 "dep_immigration",
                                                 "dep_law",
                                                 "dep_cultural"),
                                      labels = c("National Way of Life: Positive", 
                                                 "Immigration: Negative",
                                                 "Law and Order: Positive",
                                                 "Multiculturalism: Negative"))) %>%
  ggplot(aes(x = year, y = value, fill = `Type of statement`)) +
  geom_point_interactive(aes(data_id = htmltools::htmlEscape(party_lab, TRUE), # escaping single quotes
                             tooltip = htmltools::htmlEscape(party_lab, TRUE)),
                         hover_nearest = TRUE,
                         size = 3,
                         alpha = .6,
                         shape = 21,
                         color = "white"
  ) +
  scale_fill_manual(values = palette) +
  theme_minimal(base_size = 15) +
  labs(x = NULL,
       y = "Share of quasi-sentences",
       title = str_wrap("Prevalence of nationalism-related statements in party manifestos over time, 1920-2021", width = 50),
       #caption = caption
       caption = "Notes: Data from Comparative Manifesto Project | Figure by Sean Bock "
  ) +
  scale_x_continuous(breaks = seq(1920,2020,20)) +
  facet_wrap_interactive(~`Type of statement`) +
  theme(text = element_text(family = "Milo"),
        legend.position = "none",
        plot.caption = element_text(hjust = 0),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.major.y = element_line(color = "#D9D9D9"),
        panel.spacing.x = unit(1, "cm"))

# initializing interactive plot 
girafe(ggobj = plot) 