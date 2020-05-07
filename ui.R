bs4DashPage(
  sidebar_mini = FALSE,
  sidebar_collapsed = FALSE,
  enable_preloader = TRUE,
  loading_duration = 3,
  loading_background = "#273443",
  setBackgroundColor(color = "#273443"),
  navbar = bs4DashNavbar(sidebarIcon = NULL,
                         skin = "dark",
                         controlbarIcon = NULL,
                         fixed = TRUE,
                         leftUi = tagList(span(class = "logo-lg"),img(src = "logoo.png", height= 60,
                                   style = 'margin-left: -40px; margin-top: -10px;')),
                         rightUi = bs4UserMenu(
                           src = "Primerr.png", 
                           name = "V0MG1UF",
                           subtitle = "Author",
                           footer = p("Version 1.0", class = "text-center")
                         )
                         ),
  sidebar = bs4DashSidebar(disable = TRUE),
  body = bs4DashBody(
    fluidRow(column(1)),
    fluidRow(
      column(1),
      column(2, pickerInput(
        inputId = "part",
        label = "Select Part", 
        choices = parameter_choices1,
        options = list(
          `live-search` = TRUE)
      )),
      column(2, textInput("Edft", label = "Enter DFT in ml", value = "")),
      column(2, textInput("TrnsfEfi", label = "Enter Transfer Efficiency", value = "")),
      column(3, 
             align="center",
             dateRangeInput("TheDate","Select Date Range",
                            start = Sys.Date()-7,
                            end = Sys.Date(),
                            max=Sys.Date(),
                            format = "yyyy-mm-dd",width = "80%"
             )
      ),
      column(2, align= "center", actionBttn(
        inputId = "Getinsights",
        label = "Get Insights",
        style = "fill"
      ))      
    ),
    fluidRow(
      column(4, echarts4rOutput("ActPaint")),
      column(4,echarts4rOutput("TheoPaint")),
      column(4,echarts4rOutput("Delta")),
      # bs4ValueBox(value = 10.13, subtitle = "Surface Area", status = "success", 
      #             footer = "Unit in Sq.Ft", icon = "cogs", width = 3),
      # bs4ValueBox(value = 10.13, subtitle = "Actual Paint Consumption", status = "warning", 
      #             footer = "Unit in CC", icon = "database", width = 3),
      # bs4ValueBox(value = 10.13, subtitle = "Theoretical Paint Consumption", status = "primary", 
      #             footer = "Unit in CC", icon = "cogs", width = 3),
      # bs4ValueBox(value = 10.13, subtitle = "Delta", status = "info",
      #             footer = "Unit in CC", icon = "database", width = 3)
    ),
    fluidRow(
      column(8,
             bs4Card(
               inputId = "spc",
               title = "SPC Chart", 
               width = 12,
               status = "danger", 
               closable = FALSE,
               maximizable = TRUE, 
               collapsible = TRUE,
               height = "500px"
             )
             ),
      column(4,
             fluidRow(
               bs4ValueBox(value = 200, subtitle = "UCL", status = "primary",
                           footer = "Unit in CC", icon = "database", width = 12)
             ),
             fluidRow(
               bs4ValueBox(value = 121, subtitle = "LCL", status = "primary",
                          footer = "Unit in CC", icon = "database", width = 12)),
             fluidRow(
               bs4ValueBox(value = 200, subtitle = "Mean Actual Consumption", status = "primary",
                           footer = "Unit in CC", icon = "database", width = 12)
             )
             )
      
    )
    
  ),
  tags$head(
    tags$link(
      rel = "stylesheet",
      type = "text/css",
      href = "primer.css"
    )
  ),
)