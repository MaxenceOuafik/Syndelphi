library(tidyverse)
wave2_c <- wave2_data |> 
    select(1:45) |>
    na.omit()
