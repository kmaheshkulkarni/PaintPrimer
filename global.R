# devtools::install_github("RinteRface/bs4Dash")
source("pkg.R")
# devtools::install_github("dreamRs/shinyWidgets")
# remotes::install_github("ericrayanderson/shinymaterial")
# #01111D (Background Color)
# #1DA1F2 

# .libPaths( c( "C:/Program Files/R/R-4.0.0/library" , .libPaths() ) )
# remotes::install_github("dreamRs/grillade")

###################  INDAIATUBA_ELEMENTS_Local #############################
# 
indi_data_con<-dbConnect(odbc::odbc(),
                         Driver="SQL Server",
                         Server ="FINDBZSQL1.jdnet.deere.com",
                         Database = "BZ_PAAP",
                         port ="1433",
                         UID = "A2Q6164",
                         PWD = "re8jfd33"
)

# # ############## Dubuque TrackSYS Database Connection Global #################
# 
tx_traksys_con<-dbConnect(odbc::odbc(),
                          Driver="SQL Server",
                          Server ="fdubtxparsec1.jdnet.deere.com",
                          Database = "EDB_TX01",
                          port ="1433",
                          UID = "ATX0610",
                          PWD = "udufx669"
)

teda_data_con<-dbConnect(
  odbc::odbc(),
  Driver="SQL Server",
  Server ="GFTIASQL1",
  Database = "TEDA_PAAP",
  port ="1434",
  UID = "tcw",
  PWD = "Paint_tcw%456"
)

Theoretical<- function(SurfArea = NULL, DFT= NULL, TransfEffi = NULL){
  SurfArea<- as.numeric(SurfArea)
  DFT<- as.numeric(DFT)
  TransfEffi<- as.numeric(TransfEffi)
  surfDFT<- SurfArea * DFT
  TransPer<- TransfEffi / 100
  calc1 <- 829.17
  Theore1 <- (surfDFT / calc1) * 3785.41
  Theorrtical<- Theore1 / TransPer
  return(Theorrtical)
}

job_part<- read.csv("Data/job_vs_part.csv")
# TEvent <- dbGetQuery(tx_traksys_con, "SELECT * from tEvent")
parameter_choices1<- setNames(as.character(job_part$Job_Number), job_part$Part_Decription)

# temp_data<- temp_data[temp_data$]

# print("surface")
# print(SurfaceArea)
# temp_data <- job_part[product_param$job_type_id == input$product_job, ]
# temp_data <- temp_data[temp_data$parameter_id == input$product_parameter, ]
# product_machine_choices = setNames(as.character(temp_data$machine_id),temp_data$machine_name)