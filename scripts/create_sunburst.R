library(plotly)

sunburst_themes_fr <- codes_tidy_fr |>
  select(label = theme, DEM02) |>
  count(label, DEM02) |>
  mutate(parents = NA) |>
  mutate(id = label)

sunburst_subthemes_fr <- codes_tidy_fr |>
  select(parents = theme, label = subtheme, DEM02)|>
  filter(!is.na(label)) |>
  unite("id", c(parents, label), sep = " - ", remove = FALSE, na.rm = TRUE) |>
  add_count(label, DEM02)|>
  distinct(.keep_all = TRUE)

sunburst_subsubthemes_fr <- codes_tidy_fr |>
  select(subtheme, label = subsubtheme, theme, DEM02)|>
  filter(!is.na(label)) |>
  unite("parents", c(theme, subtheme), sep = " - ", remove = TRUE, na.rm = TRUE)|>
  unite("id", c(parents, label), sep = " - ", remove = FALSE, na.rm = TRUE) |>
  add_count(label, DEM02) |>
  distinct(.keep_all = TRUE) 

sunburst_codes <- codes_tidy_fr |>
  select(subtheme, subsubtheme, theme, label = codename, DEM02)|>
  filter(!is.na(label)) |>
  unite("parents", c(theme, subtheme, subsubtheme), sep = " - ", remove = TRUE, na.rm = TRUE)|>
  unite("id", c(parents, label), sep = " - ", remove = FALSE, na.rm = TRUE) |>
  add_count(label, DEM02) |>
  distinct(.keep_all = TRUE)

suburst_T_fr <- rbind(sunburst_themes_fr, sunburst_subthemes_fr, sunburst_subsubthemes_fr, sunburst_codes) |>
  filter(DEM02 == "Transgenre")

suburst_C_fr <- rbind(sunburst_themes_fr, sunburst_subthemes_fr, sunburst_subsubthemes_fr, sunburst_codes) |>
  filter(DEM02 == "Cisgenre")

sunburst_C_fr <- plot_ly(name = "Experts C-HSH",
                         ids =  suburst_C_fr$id,
                         labels = suburst_C_fr$label,
                         parents = suburst_C_fr$parents,
                         type = 'sunburst',
                         maxdepth = 3,
                         domain = list(column = 0),
                         textfont = list(size = 8),
                         insidetextorientation = "radial") |>
  layout(sunburstcolorway = c("#006F7D","#FFCF99","#DF302F","#E75836","#EE803C"),
         extendsunburstcolors = TRUE,
         title = "Thèmes des experts CHSH",
         margin = list(r = 0, l = 0, autoexpand = F))
  
sunburst_T_fr <- plot_ly(name = "Experts T-HSH",
                         ids = suburst_T_fr$id,
                         labels = suburst_T_fr$label,
                         parents = suburst_T_fr$parents,
                         type = 'sunburst',
                         maxdepth = 3,
                         domain = list(column = 1),
                         textfont = list(size = 8),
                         insidetextorientation = "radial") |>
  layout(sunburstcolorway = c("#FFCF99", "#006F7D","#E75836", "#DF302F","#EE803C"),
         extendsunburstcolors = TRUE,
         title = "Thèmes des experts THSH",
         margin = list(r = 0, l = 0, autoexpand = F))

rm(list = c("suburst_C_fr",
            "suburst_T_fr",
            "sunburst_codes",
            "sunburst_subsubthemes_fr",
            "sunburst_subthemes_fr",
            "sunburst_themes_fr"))

# And now the english version

sunburst_themes <- codes_tidy |>
  select(label = theme, DEM02) |>
  count(label, DEM02) |>
  mutate(parents = NA) |>
  mutate(id = label)

sunburst_subthemes <- codes_tidy |>
  select(parents = theme, label = subtheme, DEM02)|>
  filter(!is.na(label)) |>
  unite("id", c(parents, label), sep = " - ", remove = FALSE, na.rm = TRUE) |>
  add_count(label, DEM02)|>
  distinct(.keep_all = TRUE)

sunburst_subsubthemes <- codes_tidy |>
  select(subtheme, label = subsubtheme, theme, DEM02)|>
  filter(!is.na(label)) |>
  unite("parents", c(theme, subtheme), sep = " - ", remove = TRUE, na.rm = TRUE)|>
  unite("id", c(parents, label), sep = " - ", remove = FALSE, na.rm = TRUE) |>
  add_count(label, DEM02) |>
  distinct(.keep_all = TRUE) 

sunburst_codes <- codes_tidy |>
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


sunburst_C_plot <- plot_ly(name = "Cisgenres",
                         ids =  sunburst_C$id,
                         labels = sunburst_C$label,
                         parents = sunburst_C$parents,
                         type = 'sunburst',
                         maxdepth = 3,
                         domain = list(column = 0),
                         textfont = list(size = 8),
                         insidetextorientation = "radial") |>
  layout(sunburstcolorway = c("#006F7D","#FFCF99","#DF302F","#E75836","#EE803C"),
         extendsunburstcolors = TRUE,
         title = "Themes of cisgender experts")

sunburst_T_plot <- plot_ly(name = "Transgenres",
                         ids = sunburst_T$id,
                         labels = sunburst_T$label,
                         parents = sunburst_T$parents,
                         type = 'sunburst',
                         maxdepth = 3,
                         domain = list(column = 1),
                         textfont = list(size = 8),
                         insidetextorientation = "radial") |>
  layout(sunburstcolorway = c("#FFCF99", "#006F7D","#E75836", "#DF302F","#EE803C"),
         extendsunburstcolors = TRUE,
         title = "Themes of transgender experts")

rm(list = c("sunburst_C",
            "sunburst_T",
            "sunburst_codes",
            "sunburst_subsubthemes",
            "sunburst_subthemes",
            "sunburst_themes"))