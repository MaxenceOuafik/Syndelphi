library(readr)
demog_data <- read_delim("data/demographic_data.csv", 
                               delim = ";", 
                               escape_double = FALSE, 
                               col_types = cols(DEM02 = col_factor(levels = c("Cisgenre", 
                                                                              "Transgenre")), 
                                                DEM03 = col_factor(levels = c("18-29 ans",
                                                                              "30-39 ans", 
                                                                              "40-49 ans", 
                                                                              "50-59 ans",
                                                                              "60-69 ans")), 
                                                `ASS03[other]` = col_character(),
                                                ASS05 = col_number(), 
                                                ASS06 = col_factor(levels = c("Au moins une fois par mois",
                                                                              "Plusieurs fois par mois", 
                                                                              "Une fois par semaine ou plus",
                                                                              "Presque tous les jours"))), 
                               locale = locale(encoding = "ISO-8859-1"), 
                               trim_ws = TRUE)

codes_data <- read_csv("data/codes_cases_cat.csv")
