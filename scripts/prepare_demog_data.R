# This script applies basic data manipulation operation in order to analyze demographic data from the survey

library(tidyverse)

## First, we start by a simple count of gender position data 
gender_data <- demog_data |>
  count(DEM02) |>
  mutate(DEM02 = ifelse(DEM02 == "Cisgenre", "Experts HSH cisgenres", "Experts HSH transgenres")) |>
  mutate(pct = scales::percent(n/sum(n))) 

## Then, we move to the Provinces data. Since many participants work in more than one province, there's one 
## column by province with boolean data. We thus need to tidy the data by pivoting the table, then we count the
## provinces

province_data <- demog_data |>
  select(1, 11:16) |>
  dplyr::rename("Hainaut" = "ASS04[Hainaut]",
                "Namur" = "ASS04[Namur]",
                "Liège" = "ASS04[Liege]",
                "Brabant Wallon" = "ASS04[BW]",
                "Luxembourg" = "ASS04[LUX]",
                "Bruxelles" = "ASS04[BXL]") |>
  pivot_longer(2:7, names_to = "province") |>
  filter(value == TRUE) |>
  count(province) |>
  mutate(province = fct_reorder(province, n, .desc = T))


## For the age class, we choose to separate values from cisgender and transgender experts, due to the 
## hypothetized age difference between the two groups 

age_data <- demog_data |>
  select(id, DEM02, DEM03) |>
  count(DEM02, DEM03) |>
  pivot_wider(names_from = "DEM02", values_from = "n")

## Finally, we performed the same kind of transformation for their tasks as for their provinces of action

task_data <- demog_data |>
  select(1, 5:7) |>
  dplyr::rename("Accueil" = "ASS02[Welcome]",
                "Santé communautaire" = "ASS02[ComHealth]",
                "Socialisation" = "ASS02[Social]") |>
  pivot_longer(2:4, names_to = "tâches") |>
  filter(value == TRUE) |>
  count(tâches) |>
  dplyr::mutate(percent = scales::percent(n/17))

.N_trans <- sum(demog_data$DEM02 == "Transgenre")