function(input, output, session){
  observeEvent(input$part_desc,{
    temp_data <- job_part[job_part$Job_Number == input$part_desc, ]
    surft = setNames(as.numeric(temp_data$Surface_Area),temp_data$Surface_Area)
    output$SurfaceArea<- renderbs4ValueBox(
      bs4ValueBox(value = as.numeric(surft), subtitle = "Surface Area", status = "success",
                                footer = "Unit in SQ.Ft", icon = "database", width = 12)
    )
    # updateTextInput(session, 'SurfaceTxt', label = paste0("Surface Area in Sq.Ft"), surft)
    # updateSelectInput(session, 'product_parameter', label = paste0("Select Parameter"),
    #                   product_parameter_choices)
  })
  # output$SurfaceTxt<- renderText(
  #   temp_data <- job_part[job_part$Job_Number == input$part_desc, ],
  #   temp_data <- temp_data[temp_data$Surface_Area == temp_data$Job_Number, ],
  #   print(temp_data),
  #   temp_data$Surface_Area,
  #   # product_machine_choices = setNames(as.character(temp_data$machine_id),temp_data$machine_name)
  #   # print(temp_data),
  #   bs4ValueBox(value = as.numeric(SA), subtitle = "Surface Area", status = "success",
  #               footer = "Unit in SQ.Ft", icon = "database", width = 12)
  # )
 
  # print("surface")
  # # print(SurfaceArea)
  # print(input$part)

  output$ActPaint <- renderEcharts4r({
    value <- 618.19
    liquid <- data.frame(name= c(value, 0.5, 0.4, 0.2), color = c("#ffc107", "#195030"))
    liquid %>% 
      e_charts() %>% 
      e_liquid(
        serie = name, 
        color = color,
        label = list(
          formatter = "{c}"
        )
      ) %>% 
      e_grid(left= 20, top = 10, right = 0, bottom = 10, width = "400px")
  })
  output$TheoPaint <- renderEcharts4r({
    value <- 818.19
    liquid <- data.frame(name= c(value, 0.5, 0.4, 0.2), color = c("#ffc107", "#195030"))
    liquid %>% 
      e_charts() %>% 
      e_liquid(
        serie = name, 
        color = color,
        label = list(
          formatter = "{c}"
        )
      )  %>% 
      e_grid(left=30)
  })
  output$Delta <- renderEcharts4r({
    value <- 713.19
    liquid <- data.frame(name= c(value, 0.5, 0.4, 0.2), color = c("#ffc107", "#195030"))
    liquid %>% 
      e_charts() %>% 
      e_liquid(
        serie = name, 
        color = color,
        label = list(
          formatter = "{c}"
        )
      ) %>% 
      e_grid(left=30)
  })
  
  # output$surfArea <- renderEcharts4r({
  #   e_charts() %>% 
  #     e_gauge(41, "Sq.Ft") %>% 
  #     e_title("Gauge")
  # })
}