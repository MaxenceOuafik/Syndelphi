library(ConsRank)
wave3_cis <- wave3_data |>
    select(`Q31C[1]`:`Q31C[13]`) |>
    filter(!is.na(`Q31C[1]`))

wave3_cis <- wave3_cis |>
    rename_with(~ gsub("Q31C[", "", colnames(wave3_cis), fixed = TRUE)) |>
    rename_with(~ gsub("]", "", colnames(wave3_cis), fixed = TRUE))

wave3_cis_rang <- wave3_cis |>
    pivot_longer(everything(), names_to = "rang", values_to = "variables") |>
    mutate(rang = as.numeric(rang)) |>
    group_by(variables) |>
    summarize(rang_moy = round(mean(rang), digits = 1)) |>
    arrange(rang_moy)

wave3_trans <- wave3_data |>
    select(`Q31T[1]`:`Q31T[13]`) |>
    filter(!is.na(`Q31T[1]`))

wave3_trans <- wave3_trans |>
    rename_with(~ gsub("]", "", colnames(wave3_trans), fixed = TRUE)) |>
    rename_with(~ gsub("Q31T[", "", colnames(wave3_trans), fixed = TRUE))

wave3_trans_rang <- wave3_trans |>
    pivot_longer(everything(), names_to = "rang", values_to = "variables") |>
    mutate(rang = as.numeric(rang)) |>
    group_by(variables) |>
    summarize(rang_moy = round(mean(rang), digits = 1)) |>
    arrange(rang_moy)

tau_x(wave3_cis)
data(BU)
RD <- BU[, 1:3]
