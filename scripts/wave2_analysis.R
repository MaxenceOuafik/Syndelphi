library(tidyverse)

.nc <- wave2_data |>
    select(1:45) |>
    na.omit() |>
    nrow()

for (i in 1:45){
    print(((sum(wave2_data[i] == "Important", na.rm = TRUE) + 
    sum(wave2_data[i] == "Très important", na.rm = TRUE)) >= (0.8 * .nc)))
}
