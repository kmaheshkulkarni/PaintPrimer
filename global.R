# devtools::install_github("RinteRface/bs4Dash")
source("pkg.R")
# devtools::install_github("dreamRs/shinyWidgets")
# remotes::install_github("ericrayanderson/shinymaterial")
# #01111D (Background Color)
# #1DA1F2 

# .libPaths( c( "C:/Program Files/R/R-4.0.0/library" , .libPaths() ) )
# remotes::install_github("dreamRs/grillade")
job_part<- read.csv("Data/job_vs_part.csv")
# TEvent <- dbGetQuery(tx_traksys_con, "SELECT * from tEvent")
parameter_choices1<- setNames(as.character(job_part$Job_Number), job_part$Part_Decription)