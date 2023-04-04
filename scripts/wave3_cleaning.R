wave3_cis <- wave3_data |>
    select(`Q31C[1]`:`Q31C[13]`) |>
    filter(!is.na(`Q31C[1]`))

wave3_cis_clean <- wave3_cis |>
    rename_with(~ gsub("Q31C[", "", colnames(wave3_cis), fixed = TRUE))

wave3_cis_clean <- wave3_cis_clean |>
    rename_with(~ gsub("]", "", colnames(wave3_cis_clean), fixed = TRUE))

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

wave3_trans_rang <- wave3_trans_clean |>
    rowid_to_column() |>
    pivot_longer(`1`:`13`, names_to = "rang", values_to = "variables") |>
    mutate(rang = as.numeric(rang)) |>
    filter(!is.na(variables)) |>
    pivot_wider(names_from = "variables", values_from = "rang") |>
    select(-rowid)