source("./scripts/wave2_cleaning.R")

# This function returns the name of the column wherever >= 80% of respondents have deemed the variable 
# important or very important. It will be our sorting function. 
select_variables <- function(x) {
    if ((sum(x == "Important", na.rm = TRUE) + 
    sum(x == "Très important", na.rm = TRUE)) >= (0.8 * nrow(x))) {
        variablename <- colnames(x)
    } else {
       variablename <- NULL
    }
   return(variablename)
}

# Then we will use a loop function to pass the sorting function we created and create a list
variable_cisgender <- list()
for (i in 1:45){
    variable_cisgender[[i]] <- select_variables(wave2_data_cis[i])
}

# To improve readibility, we will then remove null value to only keep the variables of interest
variable_cisgender <- variable_cisgender[!sapply(variable_cisgender, is.null)]


# We do the exact same thing for transgender respondents, keeping this time the 46th to 92nd columns

variable_transgender <- list()
for (i in 1:47){
    variable_transgender[[i]] <- select_variables(wave2_data_trans[i])
}

variable_transgender <- variable_transgender[!sapply(variable_transgender, is.null)]
