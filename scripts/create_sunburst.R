library(plotly)
library(tidyverse)
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

sunburst_data <- codes_data %>%
  dplyr::distinct() %>%
  left_join(select(demog_data, DEM02, id), by = c("casename" = "id"))



for (i in themes$themid) {
  sunburst_data$theme[sunburst_data$catid == i] <- themes$theme[themes$themid == i]
  sunburst_data$theme[sunburst_data$supercatid == i] <- themes$theme[themes$themid == i]
}
sunburst_data$theme <- replace_na(sunburst_data$theme, "Facing mental health challenges")

for (j in subthemes$subthemid) {
  sunburst_data$subtheme[sunburst_data$catid == j] <- subthemes$subtheme[subthemes$subthemid == j]
  sunburst_data$subtheme[sunburst_data$supercatid == j] <- subthemes$subtheme[subthemes$subthemid == j]
}

for (k in subsubthemes$subsubthemid) {
  sunburst_data$subsubtheme[sunburst_data$catid == k] <- subsubthemes$subsubtheme[subsubthemes$subsubthemid == k]
  sunburst_data$subsubtheme[sunburst_data$supercatid == k] <- subsubthemes$subsubtheme[subsubthemes$subsubthemid == k]
}


sunburst_themes <- sunburst_data |>
  select(label = theme, DEM02) |>
  count(label, DEM02) |>
  mutate(parents = NA) |>
  mutate(id = label)

sunburst_subthemes <- sunburst_data |>
  select(parents = theme, label = subtheme, DEM02)|>
  filter(!is.na(label)) |>
  unite("id", c(parents, label), sep = " - ", remove = FALSE, na.rm = TRUE) |>
  add_count(label, DEM02)|>
  distinct(.keep_all = TRUE)

sunburst_subsubthemes <- sunburst_data |>
  select(subtheme, label = subsubtheme, theme, DEM02)|>
  filter(!is.na(label)) |>
  unite("parents", c(theme, subtheme), sep = " - ", remove = TRUE, na.rm = TRUE)|>
  unite("id", c(parents, label), sep = " - ", remove = FALSE, na.rm = TRUE) |>
  add_count(label, DEM02) |>
  distinct(.keep_all = TRUE) 

sunburst_codes <- sunburst_data |>
  select(subtheme, subsubtheme, theme, label = codename, DEM02)|>
  filter(!is.na(label)) |>
  unite("parents", c(theme, subtheme, subsubtheme), sep = " - ", remove = TRUE, na.rm = TRUE)|>
  unite("id", c(parents, label), sep = " - ", remove = FALSE, na.rm = TRUE) |>
  add_count(label, DEM02) |>
  distinct(.keep_all = TRUE)

sunburst_T <- rbind(sunburst_themes, sunburst_subthemes, sunburst_subsubthemes, sunburst_codes) |>
  filter(DEM02 == "Transgenre")

sunburst_C <- rbind(sunburst_themes, sunburst_subthemes, sunburst_subsubthemes, sunburst_codes) |>
  filter(DEM02 == "Cisgenre")
  
sunburst_plot <- plot_ly() 
sunburst_plot <- sunburst_plot |>
  add_trace(
    ids =  sunburst_C$id,
    labels = sunburst_C$label,
    parents = sunburst_C$parents,
    type = 'sunburst',
    maxdepth = 3,
    domain = list(column = 0)
  ) 

sunburst_plot <- sunburst_plot |>
  add_trace(
    ids = sunburst_T$id,
    labels = sunburst_T$label,
    parents = sunburst_T$parents,
    type = 'sunburst',
    maxdepth = 3,
    domain = list(column = 1)
  ) 

sunburst_plot <- sunburst_plot |>
  layout(
    grid = list(columns =2, rows = 1),
    margin = list(l = 0, r = 0, b = 0, t = 0),
    sunburstcolorway = c(
      "#636efa","#EF553B","#00cc96","#ab63fa","#19d3f3",
      "#e763fa", "#FECB52","#FFA15A","#FF6692","#B6E880"
    ),
    extendsunburstcolors = TRUE)

sunburst_plot


