# Variable to ensure line is <80 characters long
filename <- paste0("https://github.com/melaniewalsh/Neat-Datasets/",
                  "blob/main/us-prison-jail-rates-1990.csv?raw=true")
data <- read.csv(
  filename,
  stringsAsFactors = FALSE
)