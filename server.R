function(input, output, session){
  observeEvent(input$Getinsights,{
    if(is.null(input$Getinsights)||input$Getinsights==0)
    {
      returnValue()
    }
    else
    {
      qr<- paste0("Select capture01 as Job_Number, capture02 as paint_volume, date as Date_of_Paint from tEvent 
                   where eventdefinitionid = ",input$action_gun_select1," and capture01 = ",input$part_desc,"
                   and Date in ('",input$Getinsights[1],"' , '",input$Getinsights[2],"')")
      
      spc_data<-dbGetQuery(spc_data,qr)
      
      if(nrow(spc_data) == 0){
        sendSweetAlert(session = session, title = "Error", text = "No Records Present", type = "error")
      }
      else
      {
        print("spc_data")
        print(spc_data)
        output$spc_plot<-renderPlotly({
          # ichart_ly(spc_data, x = cars$speed, y = cars$dist, xname = "mpg", yname = "hp")
        })
      }
      observeEvent(input$part_desc,{
        temp_data <- job_part[job_part$Job_Number == input$part_desc, ]
        surft = setNames(as.numeric(temp_data$Surface_Area),temp_data$Surface_Area)
        output$SurfaceArea<- renderbs4ValueBox(
          bs4ValueBox(value = round(as.numeric(surft),2), subtitle = "Surface Area", status = "success",
                      footer = "Unit in SQ.Ft", icon = "database", width = 12),
          output$TheoPaint <- renderEcharts4r({
            Transfer<- Theoretical(SurfArea = surft, DFT = input$Edft, input$TrnsfEfi)
            value <- as.numeric(Transfer)
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
        )
      })
      
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
      # updateTextInput(session, 'SurfaceTxt', label = paste0("Surface Area in Sq.Ft"), surft)
      # updateSelectInput(session, 'product_parameter', label = paste0("Select Parameter"),
      #                   product_parameter_choices)
    }
  }
  )
}