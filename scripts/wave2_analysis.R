source("./scripts/wave2_cleaning.R")

# This function returns the name of the column wherever a number of respondents 
# equal or greather than the threshold have deemed the variable 
# important or very important. It will be our sorting function. µ

select_variables <- function(x, threshold) {
    if ((sum(x == "Important", na.rm = TRUE) + 
    sum(x == "Très important", na.rm = TRUE)) >= (threshold * nrow(x))) {
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
