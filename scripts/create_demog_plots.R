# This scripts aims to create appropriate plots for the various demographic data we collected in the survey
library(plotly)
## First, we create a pie chart for gender repartition of the experts
gender_pie <- plot_ly(gender_data,
                      labels = ~DEM02,
                      values = ~n,
                      type = "pie",
                      textinfo = "label+percent",
                      showlegend = F,
                      marker = list(colors = c("#5fa3b0", "#ee803c"))) |>
  layout(title = "Répartition des experts par mobilité de genre",
         margin = list(t=50))

gender_pie_doc <- ggplot(gender_data,
                         aes(x="", y=n, fill=DEM02)) +
  geom_bar(stat='identity', width = 1)+
  geom_label(aes(label = paste(n, "participants", "(",pct,")")),
            position = position_stack(vjust = 0.5),
            color = "white",
            size = 2.5,
            show.legend = FALSE)+
  coord_polar("y", start=0) +
  theme_void() + 
  labs(fill = "Mobilité de genre des experts") +
  scale_fill_manual(values = c("#5fa3b0", "#ee803c"))

## A bar chart for the province repartition 
province_bar <-  plot_ly(province_data,
                         x = ~province,
                         y = ~n,
                         type = "bar",
                         marker = list(color = "#5fa3b0")) |>
  layout(xaxis = list(categoryorder = "total descending",
                      title = "Provinces"),
         yaxis = list(title = "Nombre de participants"),
         title = "Répartition géographique des experts")

province_bar_plot <- ggplot(province_data,
                            aes(x = province, y = n)) +
  geom_bar(stat = "identity", 
           fill = "#5fa3b0") + 
  labs(x = "Provinces",
       y = "Nombre de participants") +
  scale_y_continuous(breaks = c(1,3,5,7,9))
  

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
       y = "% des répondants") +
  coord_flip()

# And a grouped bar plot for the age and gender repartition
age_bar <-plot_ly(age_data,
                  x = ~DEM03,
                  y = ~Cisgenre, 
                  type = 'bar',
                  marker = list(color = "#5fa3b0"),
                  name = "Experts HSH cisgenres",
                  text = paste(age_data$Cisgenre, "experts HSH cisgenres de", age_data$DEM03),
                  hoverinfo = 'text',
                  textposition = "none") |>
  add_trace(y = ~Transgenre,
            marker = list(color = "#ee803c"),
            name = "Experts HSH transgenres",
            text = paste(age_data$Transgenre, "experts HSH transgenres de", age_data$DEM03),
            hoverinfo = 'text',
            textposition = "none") |>
  layout(barmode = 'group',
         title = "Répartition des experts, par âge et mobilité de genre",
         xaxis = list(title = "Tranches d'âge"),
         yaxis = list(title = "Nombre d'experts"))
