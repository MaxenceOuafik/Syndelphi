library(tidyverse)
library(ggplot2)

.N_cis <- sum(demog_data$DEM02 == "Cisgenre")
.N_trans <- sum(demog_data$DEM02 == "Transgenre")

.codesN1_fr <- codes_tidy_fr |>
  count(codename) |>
  filter(n > 1)

heatmap_code_fr <- codes_tidy_fr |>
  count(codename, DEM02) |>
  mutate(prop = ifelse(DEM02 == "Cisgenre", (n/.N_cis), (n/.N_trans))) |>
  filter(codename %in% .codesN1_fr$codename) |>
  ggplot(aes(codename, DEM02)) +
  geom_tile(aes(fill = prop)) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  scale_fill_gradient(low = "#ffcf56", high = "#ed6a5a") 

.codesN1 <- codes_tidy |>
  count(codename) |>
  filter(n > 1)

heatmap_code <- codes_tidy |>
  count(codename, DEM02) |>
  mutate(prop = ifelse(DEM02 == "Cisgenre", (n/.N_cis), (n/.N_trans))) |>
  filter(codename %in% .codesN1$codename) |>
  ggplot(aes(codename, DEM02)) +
  geom_tile(aes(fill = prop)) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  scale_fill_gradient(low = "#ffcf56", high = "#ed6a5a") 


