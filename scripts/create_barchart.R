library(ggpubr)
library(ggplot2)

.N_cis <- sum(demog_data$DEM02 == "Cisgenre")
.N_trans <- sum(demog_data$DEM02 == "Transgenre")

barplot_T_fr <- codes_tidy_fr |>
  filter(DEM02 == "Transgenre") |>
  count(codename, DEM02) |>
  mutate(prop = (n/.N_trans)) |>
  filter(prop >= 0.3) |>
  mutate(codename = fct_reorder(codename, n, .desc = FALSE)) |>
  ggplot(aes(x=codename, y=prop)) +
  geom_bar(stat = "identity", width=0.45, aes(fill = DEM02), show.legend = FALSE) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) + 
  scale_y_reverse (labels=scales::percent) +
  scale_fill_manual(values = c("#ee803c")) +
  scale_x_discrete(position = "top") +
  labs(title = "Participants transgenres",
       x = "Codes",
       y = "% of resp.") +
  coord_flip()

barplot_C_fr <- codes_tidy_fr |>
  filter(DEM02 == "Cisgenre") |>
  count(codename, DEM02) |>
  mutate(prop = (n/.N_cis)) |>
  filter(prop >= 0.3) |>
  mutate(codename = fct_reorder(codename, n, .desc = FALSE)) |>
  ggplot(aes(x=codename, y=prop)) +
  geom_bar(stat = "identity", width=0.7, aes(fill = DEM02), show.legend = FALSE) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) + 
  scale_y_continuous (labels=scales::percent, limits = c(0,1)) +
  scale_fill_manual(values = c("#5fa3b0")) +
  labs(title = "Participants cisgenres",
       x = "Codes",
       y = "% of resp.") +
  coord_flip()

barplot_fr <- ggarrange(barplot_C_fr, barplot_T_fr,
                     ncol = 2,
                     nrow = 1,
                     common.legend = TRUE)


barplot_T <- codes_tidy |>
  filter(DEM02 == "Transgenre") |>
  count(codename, DEM02) |>
  mutate(prop = (n/.N_trans)) |>
  filter(prop >= 0.3) |>
  mutate(codename = fct_reorder(codename, n, .desc = FALSE)) |>
  ggplot(aes(x=codename, y=prop)) +
  geom_bar(stat = "identity", width=0.45, aes(fill = DEM02), show.legend = FALSE) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) + 
  scale_y_reverse (labels=scales::percent) +
  scale_fill_manual(values = c("#ee803c")) +
  scale_x_discrete(position = "top") +
  labs(title = "Main subthemes of transgender respondents",
       x = "Codes",
       y = "% of resp.") +
  coord_flip()

barplot_C <- codes_tidy |>
  filter(DEM02 == "Cisgenre") |>
  count(codename, DEM02) |>
  mutate(prop = (n/.N_cis)) |>
  filter(prop >= 0.3) |>
  mutate(codename = fct_reorder(codename, n, .desc = FALSE)) |>
  ggplot(aes(x=codename, y=prop)) +
  geom_bar(stat = "identity", width=0.7, aes(fill = DEM02), show.legend = FALSE) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) + 
  scale_y_continuous (labels=scales::percent, limits = c(0,1)) +
  scale_fill_manual(values = c("#5fa3b0")) +
  labs(title = "Main subthemes of cisgender respondents",
       x = "Codes",
       y = "% of resp.") +
  coord_flip()

barplot <- ggarrange(barplot_C, barplot_T,
          ncol = 2,
          nrow = 1,
          common.legend = TRUE)
