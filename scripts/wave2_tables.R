source("./scripts/wave2_analysis.R")
library(flextable)

# Intérêt de créer une table pour les variables retenues. La table devra comporter 
# - Le nom de la variable
# - Le nombre/pourcentage de personnes trouvant la variable importante
# - Le nombre/pourcentage de personnes trouvant la variable très importante
# - Le score de la variable 
# La ligne sera orange si 60% sont d'accord
# La ligne sera verte si 80% sont d'accord
# La ligne sera bleue si 100% sont d'accord
# La ligne sera en gras si les résultats sont communs entre cis et trans 

wave2_data_cis_rep <- wave2_data_cis |>
    pivot_longer(cols = everything(), names_to = "variable", values_to = "answers") |>
    group_by(variable, answers) |>
    tally() |>
    spread(answers, n, fill = 0) |>
    select(variable, `Important`, `Très important`)

summary_table_cis <- wave2_data_cis_rank |>
    left_join(wave2_data_cis_rep, by = c("key" = "variable")) |>
    flextable() |>
    bg(i = ~  key %in% variables_6080[["cisgender"]], bg = "#ffb300db") |>
    bg(i = ~ key %in% variable_cisgender[["80%"]], bg = "#05c361d1") |>
    bg(i = ~ key %in% variable_cisgender[["100%"]], bg = "#00ccff") |>
    bold(i = ~ key %in% common_variables[["60%"]]) |>
    width(width = c(2, 1, 1, 1))

wave2_data_trans_rep <- wave2_data_trans |>
    pivot_longer(cols = everything(), names_to = "variable", values_to = "answers") |>
    group_by(variable, answers) |>
    tally() |>
    spread(answers, n, fill = 0) |>
    select(variable, `Important`, `Très important`)

summary_table_trans <- wave2_data_trans_rank |>
    left_join(wave2_data_trans_rep, by = c("key" = "variable")) |>
    flextable() |>
    bg(i = ~  key %in% variables_6080[["transgender"]], bg = "#ffb300db") |>
    bg(i = ~ key %in% variable_transgender[["80%"]], bg = "#05c361d1") |>
    bg(i = ~ key %in% variable_transgender[["100%"]], bg = "#00ccff") |>
    bold(i = ~ key %in% common_variables[["60%"]])|>
    width(width = c(2, 1, 1, 1))