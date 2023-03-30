library(readr)
# Wave 1 data (open-ended questions coded in QualCoder3)
demog_data <- read_delim(here::here("data/demographic_data.csv"), 
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

codes_data <- read_csv(here::here("data/codes_cases_cat.csv"))

codes_data_fr <- read_csv(here::here("data/codes_cases_cat_fr.csv"),
                          locale = locale(encoding = "UTF-8"))

# Wave 2 data (likert-type questions directly from LimeSurvey)

wave2_data <- read_delim(here::here("data/wave2.csv"),
                               delim = ",",
                               escape_double = FALSE,
                               col_types = cols(id = col_skip(),
                                                submitdate = col_skip(),
                                                lastpage = col_skip(),
                                                startlanguage = col_skip(),
                                                seed = col_skip(),
                                                token = col_skip()))
wave2_data <- as.data.frame(unclass(wave2_data), 
                            stringsAsFactors = TRUE)
                            
wave3_data <- read_delim(here::here("data/wave3.csv"))