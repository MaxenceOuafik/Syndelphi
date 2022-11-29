library(tidyverse)
# Since we had to give the feedback in French, the tidying of data is done twice : 
# one for the french data and one for the english version

themes_fr <- codes_data_fr |>
  filter(is.na(supercatid)) |>
  select(theme = categoryname, themid = catid) |>
  distinct(themid, .keep_all = TRUE)

subsubthemes_fr <- codes_data_fr |>
  filter(!is.na(supercatid) & !supercatid %in% themes_fr$themid) |>
  select(subsubtheme = categoryname, subsubthemid = catid)|>
  distinct(subsubthemid, .keep_all = TRUE)

subthemes_fr <- codes_data_fr |> 
  filter(!is.na(supercatid) & !catid %in% themes_fr$themid & !catid %in% subsubthemes_fr$subsubthemid)|>
  select(subtheme = categoryname, subthemid = catid) |>
  distinct(subthemid, .keep_all = TRUE)

codes_tidy_fr <- codes_data_fr |>
  dplyr::distinct() |>
  left_join(select(demog_data, DEM02, id), by = c("casename" = "id"))

for (i in themes_fr$themid) {
  codes_tidy_fr$theme[codes_tidy_fr$catid == i] <- themes_fr$theme[themes_fr$themid == i]
  codes_tidy_fr$theme[codes_tidy_fr$supercatid == i] <- themes_fr$theme[themes_fr$themid == i]
}
codes_tidy_fr$theme[codes_tidy_fr$catid == 4] <- themes_fr$theme[themes_fr$themid == 11]

for (j in subthemes_fr$subthemid) {
  codes_tidy_fr$subtheme[codes_tidy_fr$catid == j] <- subthemes_fr$subtheme[subthemes_fr$subthemid == j]
  codes_tidy_fr$subtheme[codes_tidy_fr$supercatid == j] <- subthemes_fr$subtheme[subthemes_fr$subthemid == j]
}

for (k in subsubthemes_fr$subsubthemid) {
  codes_tidy_fr$subsubtheme[codes_tidy_fr$catid == k] <- subsubthemes_fr$subsubtheme[subsubthemes_fr$subsubthemid == k]
  codes_tidy_fr$subsubtheme[codes_tidy_fr$supercatid == k] <- subsubthemes_fr$subsubtheme[subsubthemes_fr$subsubthemid == k]
}

codes_tidy_fr <- codes_tidy_fr |>
  select(casename, DEM02, theme, subtheme, subsubtheme, codename)

rm(list = c("codes_data_fr",
            "themes_fr",
            "subthemes_fr",
            "subsubthemes_fr"))

# And now the english version
themes <- codes_data |>
  filter(is.na(supercatid)) |>
  select(theme = categoryname, themid = catid) |>
  distinct(themid, .keep_all = TRUE)

subsubthemes <- codes_data |>
  filter(!is.na(supercatid) & !supercatid %in% themes$themid) |>
  select(subsubtheme = categoryname, subsubthemid = catid)|>
  distinct(subsubthemid, .keep_all = TRUE)

subthemes <- codes_data |> 
  filter(!is.na(supercatid) & !catid %in% themes$themid & !catid %in% subsubthemes$subsubthemid)|>
  select(subtheme = categoryname, subthemid = catid) |>
  distinct(subthemid, .keep_all = TRUE)

codes_tidy <- codes_data %>%
  dplyr::distinct() %>%
  left_join(select(demog_data, DEM02, id), by = c("casename" = "id"))



for (i in themes$themid) {
  codes_tidy$theme[codes_tidy$catid == i] <- themes$theme[themes$themid == i]
  codes_tidy$theme[codes_tidy$supercatid == i] <- themes$theme[themes$themid == i]
}
codes_tidy$theme <- replace_na(codes_tidy$theme, "Facing mental health challenges")

for (j in subthemes$subthemid) {
  codes_tidy$subtheme[codes_tidy$catid == j] <- subthemes$subtheme[subthemes$subthemid == j]
  codes_tidy$subtheme[codes_tidy$supercatid == j] <- subthemes$subtheme[subthemes$subthemid == j]
}

for (k in subsubthemes$subsubthemid) {
  codes_tidy$subsubtheme[codes_tidy$catid == k] <- subsubthemes$subsubtheme[subsubthemes$subsubthemid == k]
  codes_tidy$subsubtheme[codes_tidy$supercatid == k] <- subsubthemes$subsubtheme[subsubthemes$subsubthemid == k]
}

rm(list = c("codes_data",
            "themes",
            "subthemes",
            "subsubthemes",
            "i",
            "j",
            "k"))