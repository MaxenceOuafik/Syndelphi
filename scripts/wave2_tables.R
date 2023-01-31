source("./scripts/wave2_analysis.R", encoding = "UTF-8")
library(flextable)
library(webshot2)

wave2_data_cis_rep <- wave2_data_cis |>
    pivot_longer(cols = everything(), names_to = "variable", values_to = "answers") |>
    group_by(variable, answers) |>
    tally() |>
    spread(answers, n, fill = 0) |>
    select(variable, `Important`, `Très important`)

summary_table_cis <- wave2_data_cis_rank |>
    left_join(wave2_data_cis_rep, by = c("key" = "variable"))  |>
    mutate(value = cut(value, breaks = c(0, 1, 6, 7,  8, 9, 10), 
           labels = c("6ème place", "5ème place", "4ème place", "3ème place", "2ème place", "1ère place")))|>
    as_grouped_data(groups = c("value"), expand_single = TRUE) |>
    relocate(value, .after = key) |>
    flextable() |>
    bg(i = ~  key %in% variables_6080[["cisgender"]], bg = "#F3DE8A") |>
    bg(i = ~ key %in% variable_cisgender[["80%"]], bg = "#CAE7B9") |>
    bg(i = ~ key %in% variable_cisgender[["100%"]], bg = "#00A7E1") |>
    bold(i = ~ key %in% wave2_data_trans_rank$key) |>
    width(width = c(2.5, 1, 1, 1)) |>
    merge_h_range(i = c(2, 4:8, 10, 12:15), j1 = 1, j2 = 2) |>
    merge_h_range(j1 = 1, j2 = 2, part = "header") |>
    align(align = "center", i = c(1, 3, 9, 11, 16)) |>
    set_header_labels(key = "Problèmes retenus") |>
    bold(part = "header") |>
    footnote(i = 1, 
             j = 3:4, 
             part = "header",
             value = as_paragraph(c("Nombre de personnes ayant répondu que le problème était important",
                                    "Nombre de personnes ayant répondu que le problème était très important")), 
             ref_symbols = c("1", "2"))

wave2_data_trans_rep <- wave2_data_trans |>
    pivot_longer(cols = everything(), names_to = "variable", values_to = "answers") |>
    group_by(variable, answers) |>
    tally() |>
    spread(answers, n, fill = 0) |>
    select(variable, `Important`, `Très important`)

summary_table_trans <- wave2_data_trans_rank |>
    left_join(wave2_data_trans_rep, by = c("key" = "variable")) |>
    mutate(value = cut(value, breaks = c(0, 6, 8, 9, 10, 11, 12), 
           labels = c("6ème place", "5ème place", "4ème place", "3ème place", "2ème place", "1ère place"))) |>
    as_grouped_data(groups = c("value"), expand_single = TRUE) |>
    relocate(value, .after = key) |>
    flextable() |>
    bg(i = ~  key %in% variables_6080[["transgender"]], bg = "#F3DE8A") |>
    bg(i = ~ key %in% variable_transgender[["80%"]], bg = "#CAE7B9") |>
    bg(i = ~ key %in% variable_transgender[["100%"]], bg = "#00A7E1") |>
    bold(i = ~ key %in% wave2_data_cis_rank$key)|>
    width(width = c(2.5, 1, 1, 1)) |>
    merge_h_range(i = c(2, 4:6, 8:9, 11:12, 14:15, 17:19), j1 = 1, j2 = 2) |>
    merge_h_range(j1 = 1, j2 = 2, part = "header") |>
    align(align = "center", i = c(1, 3, 7, 10, 13, 16)) |>
    set_header_labels(key = "Problèmes retenus") |>
    bold(part = "header") |>
    footnote(i = 1, 
             j = 3:4, 
             part = "header",
             value = as_paragraph(c("Nombre de personnes ayant répondu que le problème était important",
                                    "Nombre de personnes ayant répondu que le problème était très important")), 
             ref_symbols = c("1", "2"))

save_as_image(summary_table_cis, path = "./docs/table_CHSH.png", webshot = "webshot2")
save_as_image(summary_table_trans, path = "./docs/table_THSH.png", webshot = "webshot2")