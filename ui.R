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
                         leftUi = tagList(span(class = "logo-lg"),img(src = "logo.png", height= 40,
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
                column(1, pickerInput(
                  inputId = "action_gun_select1",
                  label = "Select Booth",
                  choices = c("LBH Primer Booth"=505,
                              "LBH Topcoat Booth"=506,
                              "LBH Touchup Booth"=507
                  ),
                  options = list(`live-search` = TRUE)
                )),
                column(2, pickerInput(
                  inputId = "part_desc",
                  label = "Select Part", 
                  choices = parameter_choices1,
                  options = list(`live-search` = TRUE)
                )),
                # column(1, textInput("SurfaceTxt", label = "Surface Area in Sq.Ft", value = "")),
                column(1, textInput("Edft", label = "DFT in mil", value = "")),
                column(2, textInput("TrnsfEfi", label = "Transfer Efficiency in %", value = "")),
                column(3, 
                       align="center",
                       dateRangeInput("TheDate","Select Date Range",
                                      start = Sys.Date()-7,
                                      end = Sys.Date(),
                                      max=Sys.Date(),
                                      format = "yyyy-mm-dd",width = "80%"
                       )
                ),
                column(1.5, align= "center", actionBttn(
                  inputId = "Getinsights",
                  label = "Get Insights",
                  style = "fill"
                )),
                column(1.5, align = "center",
                downloadButton('FlexD', label = " Get Report"))
                # column(1, align= "center", actionBttn(
                #   inputId = "reports",
                #   label = "Report",
                #   style = "fill"
                # )) 
              ),
              fluidRow(
              bs4Card(
                title = "Paint Volume Analytics (Units in CC)", width = 12, status = "danger",
                closable = FALSE, maximizable = TRUE, collapsible = FALSE, height = "500px",
                fluidRow(
                  column(4,h2("Theoretical Paint Consumption"), echarts4rOutput("TheoPaint") %>% withSpinner(color="#ffc107")),
                  
                  column(4,h2("Actual Paint Consumption"), echarts4rOutput("ActPaint") %>% withSpinner(color="#ffc107")),
                  
                  column(4,h2("Delta Paint Consumption"), echarts4rOutput("Delta") %>% withSpinner(color="#ffc107"))
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
                         height = "650px",
                         plotlyOutput("spc_plot", height = "550px")%>% withSpinner(color="#ffc107")
                       )
                ),
                column(4,
                       fluidRow(
                         bs4ValueBoxOutput(outputId = "USLV", width = 12)
                       ),
                       fluidRow(
                         bs4ValueBoxOutput(outputId = "LSLV", width = 12)
                         ),
                       fluidRow(
                         bs4ValueBoxOutput(outputId = "MeanActConsm", width = 12)
                       ),
                       fluidRow(
                         bs4ValueBoxOutput(outputId = "SurfaceArea", width = 12)
                         )
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
    copyrights = tagList(span(class = "logo-lg"),img(src = "Prilogo.png", height= 57, 
    style = 'vertical-align: initial;height: 65px;margin-left: -1px;margin-top: -2px;margin-bottom: -5px;')),
    right_text = tagList(span(class = "logo-lg"),img(src = "green.png", height= 63, style = 'vertical-align: initial;'))
      
      # tagList(span(class = "logo-lg"),img(src = "green.png", height= 63, style = 'vertical-align: initial;'))
  )
)