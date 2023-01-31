source("./scripts/wave2_cleaning.R", encoding = "UTF-8")

# This function returns the name of the column wherever a number of respondents 
# equal or greather than the threshold have deemed the variable 
# important or very important. It will be our sorting function. µ

select_variables <- function(x, threshold) {
    if ((sum(x == "Important", na.rm = TRUE) + 
    sum(x == "Très important", na.rm = TRUE)) >= round(threshold * nrow(x))) {
        variablename <- colnames(x)
    } else {
       variablename <- NULL
    }
   return(variablename)
}

# Then we will use a loop function to pass the sorting function we created and create a list for different threshold values
variable_cisgender <- list()
for (i in 1:45){
    variable_cisgender[["100%"]][[i]] <- select_variables(wave2_data_cis[i], 
                                                         threshold = 1)
    variable_cisgender[["80%"]][[i]] <- select_variables(wave2_data_cis[i], 
                                                         threshold = 0.8)
    variable_cisgender[["60%"]][[i]] <- select_variables(wave2_data_cis[i], 
                                                         threshold = 0.6)
}

# To improve readibility, we will then remove null value to only keep the variables of interest
variable_cisgender[["100%"]] <- variable_cisgender[["100%"]][!sapply(variable_cisgender[["100%"]], 
                                                                   is.null)]
variable_cisgender[["80%"]] <- variable_cisgender[["80%"]][!sapply(variable_cisgender[["80%"]], 
                                                                   is.null)]
variable_cisgender[["60%"]] <- variable_cisgender[["60%"]][!sapply(variable_cisgender[["60%"]], 
                                                                   is.null)]

# We do the exact same thing for transgender respondents, keeping this time the 46th to 92nd columns

variable_transgender <- list()
for (i in 1:47){
    variable_transgender[["100%"]][[i]] <- select_variables(wave2_data_trans[i], 
                                                  threshold = 1)
    variable_transgender[["80%"]][[i]] <- select_variables(wave2_data_trans[i], 
                                                  threshold = 0.8)
    variable_transgender[["60%"]][[i]] <- select_variables(wave2_data_trans[i], 
                                                  threshold = 0.6)
}

variable_transgender[["100%"]] <- variable_transgender[["100%"]][!sapply(variable_transgender[["100%"]], 
                                                                         is.null)]
variable_transgender[["80%"]] <- variable_transgender[["80%"]][!sapply(variable_transgender[["80%"]], 
                                                                         is.null)]
variable_transgender[["60%"]] <- variable_transgender[["60%"]][!sapply(variable_transgender[["60%"]], 
                                                                         is.null)]

# To examine which variable we would left out if we chose a cutoff of 80% instead of 60%, we created a list
variables_6080 <- list()
variables_6080[["cisgender"]] <- variable_cisgender[["60%"]][!variable_cisgender[["60%"]] %in% variable_cisgender[["80%"]]]
variables_6080[["transgender"]] <- variable_transgender[["60%"]][!variable_transgender[["60%"]] %in% variable_transgender[["80%"]]]

# Finally, we have created a list to compare common variables between cisgender and transgender participants 
# at different thresholds
common_variables <- list()
common_variables[["60%"]] <- variable_cisgender[["60%"]][variable_cisgender[["60%"]] %in% variable_transgender[["60%"]]]
common_variables[["80%"]] <- variable_cisgender[["80%"]][variable_cisgender[["80%"]] %in% variable_transgender[["80%"]]]
common_variables[["100%"]] <- variable_cisgender[["100%"]][variable_cisgender[["100%"]] %in% variable_transgender[["100%"]]]

# To gain better insight into the relative importance of each variables, we have decided to rank each variable according to 
# the importance given by the respondents and have selected the variables with a score equal or greather thand the 3rd quartile
# among the variables that have reached the 60% threshold 

wave2_data_cis_rank <- wave2_data_cis |>
    mutate(across(everything(), ~ recode(., "Très important" = 2,
                                            "Important" = 1,
                                            "Neutre" = 0,
                                            "Peu important" = -1,
                                            "Aucune importance" = -2))) |>
    summarise_all(sum) |>
    gather() |>
    filter(value >= quantile(value, 0.75),
           key %in% variable_cisgender[["60%"]]) |>
    arrange(desc(value))

wave2_data_trans_rank <- wave2_data_trans |>
    mutate(across(everything(), ~ recode(., "Très important" = 2,
                                            "Important" = 1,
                                            "Neutre" = 0,
                                            "Peu important" = -1,
                                            "Aucune importance" = -2))) |>
    summarise_all(sum) |>
    gather() |>
    filter(value >= quantile(value, 0.75),
           key %in% variable_transgender[["60%"]]) |>
    arrange(desc(value))