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
  layout(title = "Répartition des experts",
         margin = list(t=50))

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
         title = "Répartition des experts, par âge et positionnement de genre",
         xaxis = list(title = "Tranches d'âge"),
         yaxis = list(title = "Nombre d'experts"))
