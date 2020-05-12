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
                         leftUi = tagList(span(class = "logo-lg"),img(src = "logo.png", height= 63,
                                                                      style = 'margin-left: -40px; margin-top: -1px;')),
                         rightUi = bs4UserMenu(
                           src = "Prilogo.png", 
                           name = "V0MG1UF",
                           title = "Real Time Paint Tracker",
                           subtitle = "Version 1.0",
                           status = "warning",
                           footer = NULL
                         )
  ),
  sidebar = bs4DashSidebar(disable = TRUE),
  body = bs4DashBody(
              fluidRow(column(1)),
              fluidRow(
                column(2, pickerInput(
                  inputId = "part_desc",
                  label = "Select Part", 
                  choices = parameter_choices1,
                  options = list(
                    `live-search` = TRUE)
                )),
                # column(1, textInput("SurfaceTxt", label = "Surface Area in Sq.Ft", value = "")),
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
                column(12, 
                       fluidRow(
                         bs4Card(
                           title = "Actual Paint in CC", 
                           width = 4,
                           status = "danger", 
                           closable = FALSE,
                           maximizable = TRUE, 
                           collapsible = FALSE,
                           echarts4rOutput("ActPaint")
                         ),
                         bs4Card(
                           title = "Theoretical Paint in CC", 
                           width = 4,
                           status = "danger", 
                           closable = FALSE,
                           maximizable = TRUE, 
                           collapsible = FALSE,
                           echarts4rOutput("TheoPaint", width = "400px")
                         ),
                         bs4Card(
                           title = "Delta in CC", 
                           width = 4,
                           status = "danger", 
                           closable = FALSE,
                           maximizable = TRUE, 
                           collapsible = FALSE,
                           echarts4rOutput("Delta")
                         )
                         # column(4, echarts4rOutput("ActPaint", width = "400px")),
                         # column(4, echarts4rOutput("TheoPaint", width = "400px")),
                         # column(4, echarts4rOutput("Delta", width = "400px"))
                       )
                       )
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
                         height = "600px"
                       )
                ),
                column(4,
                       fluidRow(
                         bs4ValueBox(value = 200, subtitle = "UCL", status = "warning",
                                     footer = "Unit in CC", icon = "database", width = 12)
                       ),
                       fluidRow(
                         bs4ValueBox(value = 121, subtitle = "LCL", status = "success",
                                     footer = "Unit in CC", icon = "database", width = 12)),
                       fluidRow(
                         bs4ValueBox(value = 200, subtitle = "Mean Actual Consumption", status = "warning",
                                     footer = "Unit in CC", icon = "database", width = 12)
                       ),
                       fluidRow(bs4ValueBoxOutput(outputId = "SurfaceArea", width = 12))
                       # fluidRow(bs4ValueBox(value = 200, subtitle = "Surface Area", status = "success",
                       #                      footer = "Unit in SQ.Ft", icon = "database", width = 12))
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
  footer = bs4DashFooter(
    fixed = TRUE,
    copyrights = tagList(span(class = "logo-lg"),img(src = "prilogo.png", height= 68, 
    style = 'vertical-align: initial;height: 65px;margin-left: -1px;margin-top: -2px;margin-bottom: -5px;')),
    right_text = tagList(span(class = "logo-lg"),img(src = "green.png", height= 63, style = 'vertical-align: initial;')),
      
      # tagList(span(class = "logo-lg"),img(src = "green.png", height= 63, style = 'vertical-align: initial;'))
  )
)