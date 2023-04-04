cis_rank_table <- cis_rank_final |>
    mutate(key = rownames(cis_rank_final))

rownames(cis_rank_table) <- NULL

cis_rank_table[4, 2] <- "Difficultés liées à la migration"
cis_rank_table[13, 2] <- "Faible soutien social"
cis_rank_table[5, 2] <- "Hypersexualisation intra-communautaire"
cis_rank_table[6, 2] <- "Hétéronormativité"
cis_rank_table[3, 2] <- "Pressions patriarcales sur la masculinité"
cis_rank_table[9, 2] <- "Problèmes d'usage de substance"

wave3_table_cis <- wave2_data_cis_rank |>
    left_join(wave2_data_cis_rep, by = c("key" = "variable")) |>
    select(-value) |>
    left_join(cis_rank_table) |>
    arrange(`cis_consrank$Consensus[5, ]`) |>
    flextable() |>
    bg(i = ~  key %in% variables_6080[["cisgender"]], bg = "#F3DE8A") |>
    bg(i = ~ key %in% variable_cisgender[["80%"]], bg = "#CAE7B9") |>
    bg(i = ~ key %in% variable_cisgender[["100%"]], bg = "#00A7E1") |>
    bold(i = ~ key %in% wave2_data_trans_rank$key) |>
    width(width = c(2.5, 1, 1, 1)) |>
    set_header_labels(key = "Problèmes retenus",
                      `cis_consrank$Consensus[5, ]` = "Classement") |>
    bold(part = "header") |>
    footnote(i = 1, 
             j = 2:4, 
             part = "header",
             value = as_paragraph(c("Nombre de personnes ayant répondu que le problème était important dans la deuxième vague",
                                    "Nombre de personnes ayant répondu que le problème était très important dans la deuxième vague",
                                    "Classement consensuel à l'issu de la troisième vague")), 
             ref_symbols = c("1", "2", "3"))

trans_rank_table <- trans_rank_final |>
    mutate(key = rownames(trans_rank_final))

rownames(trans_rank_table) <- NULL
trans_rank_table[11, 2] <- "Cisnormativité"
trans_rank_table[7, 2] <- "Difficulté à accéder à des soins"
trans_rank_table[1, 2] <- "Comportements et/ou tentatives de suicide"
trans_rank_table[8, 2] <- "Faible soutien social"
trans_rank_table[13, 2] <- "Hétéronormativité"
trans_rank_table[5, 2] <- "Méconnaissance sur les transidentités ; incompréhension"
trans_rank_table[6, 2] <- "Non-reconnaissance de l'identité (deadname, mégenrage)"

wave3_table_trans <- wave2_data_trans_rank |>
    left_join(wave2_data_trans_rep, by = c("key" = "variable")) |>
    select(-value) |>
    left_join(trans_rank_table) |>
    arrange(`trans_consrank$Consensus[2, ]`) |>
    flextable() |>
    bg(i = ~  key %in% variables_6080[["transgender"]], bg = "#F3DE8A") |>
    bg(i = ~ key %in% variable_transgender[["80%"]], bg = "#CAE7B9") |>
    bg(i = ~ key %in% variable_transgender[["100%"]], bg = "#00A7E1") |>
    bold(i = ~ key %in% wave2_data_cis_rank$key)|>
    width(width = c(2.5, 1, 1, 1)) |> 
    set_header_labels(key = "Problèmes retenus",
                      `trans_consrank$Consensus[2, ]` = "Classement") |>
    bold(part = "header") |>
    footnote(i = 1, 
             j = 2:4, 
             part = "header",
             value = as_paragraph(c("Nombre de personnes ayant répondu que le problème était important dans la deuxième vague",
                                    "Nombre de personnes ayant répondu que le problème était très important dans la deuxième vague",
                                    "Classement consensuel à l'issu de la troisième vague")), 
             ref_symbols = c("1", "2", "3"))

save_as_image(wave3_table_cis, path = "./docs/table_CHSH_wave3.png", webshot = "webshot2")
save_as_image(wave3_table_trans, path = "./docs/table_THSH_wave3.png", webshot = "webshot2")