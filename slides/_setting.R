comma <- function(x, digits. = 2L) format(x, digits = digits., big.mark = ",")

# Load packages
library(here)
library(tidyverse)
theme_set(theme_classic() +
    theme(panel.grid.major.y = element_line(color = "grey92")))

# Global options
options(digits = 3)