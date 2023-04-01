library(ConsRank)
wave3_cis <- wave3_data |>
    select(`Q31C[1]`:`Q31C[13]`) |>
    filter(!is.na(`Q31C[1]`))

wave3_cis_clean <- wave3_cis |>
    rename_with(~ gsub("Q31C[", "", colnames(wave3_cis), fixed = TRUE))

wave3_cis_clean <- wave3_cis_clean |>
    rename_with(~ gsub("]", "", colnames(wave3_cis_clean), fixed = TRUE))

wave3_cis_rang <- wave3_cis_clean |>
    pivot_longer(everything(), names_to = "rang", values_to = "variables") |>
    mutate(rang = as.numeric(rang)) |>
    group_by(variables) |>
    summarize(rang_moy = round(mean(rang), digits = 1)) |>
    arrange(rang_moy)

wave3_cis_rang <- wave3_cis_clean |>
    rowid_to_column() |>
    pivot_longer(`1`:`13`, names_to = "rang", values_to = "variables") |>
    mutate(rang = as.numeric(rang)) |>
    pivot_wider(names_from = "variables", values_from = "rang") |>
    select(-rowid)

wave3_trans <- wave3_data |>
    select(`Q31T[1]`:`Q31T[13]`) |>
    filter(!is.na(`Q31T[1]`))

wave3_trans_clean <- wave3_trans |>
    rename_with(~ gsub("]", "", colnames(wave3_trans), fixed = TRUE)) 
    
wave3_trans_clean <- wave3_trans_clean |>
    rename_with(~ gsub("Q31T[", "", colnames(wave3_trans_clean), fixed = TRUE))

wave3_trans_matrix <- as.matrix(wave3_trans_clean, ncol = 13, nrow = 7)

wave3_trans_rang <- wave3_trans_clean |>
    rowid_to_column() |>
    pivot_longer(`1`:`13`, names_to = "rang", values_to = "variables") |>
    mutate(rang = as.numeric(rang)) |>
    filter(!is.na(variables)) |>
    pivot_wider(names_from = "variables", values_from = "rang") |>
    select(-rowid)

wave3_trans_rang <- wave3_trans |>
    pivot_longer(everything(), names_to = "rang", values_to = "variables") |>
    mutate(rang = as.numeric(rang)) |>
    group_by(variables) |>
    summarize(rang_moy = round(mean(rang), digits = 1)) |>
    arrange(rang_moy)

library(RankAggreg)
cis_rank <- RankAggreg(wave3_cis_matrix,
            k = 13)

wave3_cis_matrix <- as.matrix(wave3_cis_clean,
ncol = 13, nrow = 6) 

trans_rank <- RankAggreg(wave3_trans_matrix, k = 13)

trans_rank$top.list
cis_rank$top.list


trans_consrank <- consrank(wave3_trans_rang)
library(ConsRank)
trans_consrank$Consensus
trans_consrank$Tau
max(trans_consrank$Tau)

cis_consrank <- consrank(wave3_cis_rang, ps = FALSE)
cis_consrank$Tau
cis_tau <- tau_x(wave3_cis_tau)

wave3_cis_tau <- as.matrix(wave3_cis_rang)

plot(cis_tau)
