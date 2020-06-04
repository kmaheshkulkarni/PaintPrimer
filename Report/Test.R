dropdownButton(
  
  tags$h3("List of Inputs"),
  
  selectInput(inputId = 'xcol',
              label = 'X Variable',
              choices = names(iris)),
  
  selectInput(inputId = 'ycol',
              label = 'Y Variable',
              choices = names(iris),
              selected = names(iris)[[2]]),
  
  sliderInput(inputId = 'clusters',
              label = 'Cluster count',
              value = 3,
              min = 1,
              max = 9),
  
  circle = TRUE, status = "danger",
  icon = icon("gear"), width = "300px",
  
  tooltip = tooltipOptions(title = "Click to see inputs !")
)

# path<- tempdir()
# print("File path")
# print(path)
# pathd= "../Report"
# dfile <- file.info(list.files(path = pathd, full.names = T))
# print("File path")
# print(dfile)
# PTfile<- rownames(dfile)[which.max(dfile$mtime)]
# # File = load(paste(PTfile))
# print("Mail File")
# print(PTfile)

# shejawalamola@johndeere.com

# creds(user = NULL, provider = NULL, host = NULL, port = NULL, use_ssl = TRUE)