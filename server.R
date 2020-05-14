function(input, output, session){
  observeEvent(input$Getinsights,{
    if(is.null(input$Getinsights)||input$Getinsights==0)
    {
      returnValue()
    }
    else
    {
      temp_data <- job_part[job_part$Job_Number == input$part_desc, ]
      surft = setNames(as.numeric(temp_data$Surface_Area),temp_data$Surface_Area)
      
      qr<- paste0("Select capture01 as Job_Number, capture02 as paint_volume, 
                  date as Date_of_Paint from tEvent 
                  where eventdefinitionid = '",input$action_gun_select1,"' and 
                  capture01 = '",input$part_desc,"' and 
                  Date between '",input$TheDate[1],"' and '",input$TheDate[2],"'")
      print("Query")
      print(qr)
      
      spc_data<-dbGetQuery(tx_traksys_con,qr)
      
      if(nrow(spc_data) == 0){
        sendSweetAlert(session = session, title = "Error", text = "No Records Present", type = "error")
      }
      else
      {
        print("spc_data")
        print(spc_data)
        spc_data$paint_volume<- round(as.numeric(spc_data$paint_volume),2)
        
        spc_data$paintDiv<- ifelse(spc_data$Job_Number == 2 | spc_data$Job_Number == 13, (spc_data$paint_volume)/7, 
                              ifelse(spc_data$Job_Number == 46, (spc_data$paint_volume)/6,
                              ifelse(spc_data$Job_Number == 68 | spc_data$Job_Number == 76 | spc_data$Job_Number == 77 |
                                     spc_data$Job_Number == 84 | spc_data$Job_Number == 110 | spc_data$Job_Number == 160,
                                     (spc_data$paint_volume)/4,
                              ifelse(spc_data$Job_Number == 216, (spc_data$paint_volume)/5, (spc_data$paint_volume)/1))))
        spc_data$paintDiv<- as.numeric(spc_data$paintDiv)
        print("spc_data")
        print(spc_data)
        print(class(spc_data$Job_Number))
        # spc_data$paintDiv<- if(spc_data$Job_Number == "2" && spc_data$Job_Number == "13"){
        #   (spc_data$paint_volume)/7
        # } else{(spc_data$paint_volume)/1} 
        spc_data$paintDiv<- round(as.numeric(spc_data$paintDiv),2)
          # (spc_data$paintDiv)/7
        print("spc_data")
        print(spc_data)
        # spc_csv<- write.csv(spc_data, file = "Data/spc.csv")
        meanap<- round(mean(spc_data$paintDiv), 2)
        print("meanap")
        print(meanap)
        
        output$spc_plot<-renderPlotly({
          ichart_ly(spc_data, x = spc_data$Date_of_Paint, y = spc_data$paintDiv, xname = "Date", yname = "Paint Volume in CC")
        })
        
        output$MeanActConsm<- renderbs4ValueBox(
          bs4ValueBox(value = meanap, subtitle = "Mean Actual Consumption", status = "warning",
                      footer = "Unit in CC", icon = "database", width = 12)
        )
        
        
        UTransfer<- Theoretical(SurfArea = surft, DFT = 2.5, TransfEffi = 100)
        print(UTransfer)
        UTFr<- round(UTransfer,2)
        USL <- as.numeric(UTFr)
        
        output$USLV<- renderbs4ValueBox(
          bs4ValueBox(value = USL, subtitle = "USL", status = "warning",
                      footer = "Unit in CC", icon = "database", width = 12)
        )
        
        LTransfer<- Theoretical(SurfArea = surft, DFT = 1.5, TransfEffi = 100)
        print(LTransfer)
        LTFr<- round(LTransfer,2)
        LSL <- as.numeric(LTFr)
        
        output$LSLV<- renderbs4ValueBox(
          bs4ValueBox(value = LSL, subtitle = "LSL", status = "success",
                      footer = "Unit in CC", icon = "database", width = 12)
        )
        
        
        observeEvent(input$part_desc,{
          temp_data <- job_part[job_part$Job_Number == input$part_desc, ]
          surft = setNames(as.numeric(temp_data$Surface_Area),temp_data$Surface_Area)
          output$SurfaceArea<- renderbs4ValueBox(
            bs4ValueBox(value = round(as.numeric(surft),2), subtitle = "Surface Area", status = "success",
                        footer = "Unit in SQ.Ft", icon = "database", width = 12)
          )
          output$TheoPaint <- renderEcharts4r({
            Transfer<- Theoretical(SurfArea = surft, DFT = input$Edft,TransfEffi = input$TrnsfEfi)
            print(Transfer)
            Transfer<- round(Transfer,2)
            value <- as.numeric(Transfer)
            liqival <- value
            liquid <- data.frame(name= c(liqival, 0.5, 0.4, 0.2), color = c("#ffc107", "#195030"))
            liquid %>% 
              e_charts() %>% 
              e_liquid(
                serie = name, 
                color = color,
                outline= (
                  show= FALSE
                ),
                label = list(
                  fontSize = 35,
                  formatter = "{c}"
                )
              )%>%
              e_grid(width = "100%", left = "70%")
          })
          
          output$Delta <- renderEcharts4r({
            Transfer<- Theoretical(SurfArea = surft, DFT = input$Edft, input$TrnsfEfi)
            print(Transfer)
            print("Transfer")
            Transfer<- round(Transfer,2)
            TheDelta<- mean(spc_data$paintDiv) - Transfer
            TheDelta<- as.numeric(TheDelta)
            print("TheDelta")
            print(TheDelta)
            value <- round(TheDelta, 2)
            print("TheDelta")
            print(value)
            
            if(value <= 0){
              liquid <- data.frame(name= c(value, 0.5, 0.4, 0.2), color = c("#000000", "#ff0000"))
              liquid %>% 
                e_charts() %>% 
                e_liquid(
                  serie = name, 
                  color = color,
                  outline= (
                    show= FALSE
                  ),
                  label = list(
                    fontSize = 35,
                    formatter = "{c}"
                  )
                ) %>%
                e_grid(width = "100%", left = "70%")
            } else{
              liquid <- data.frame(name= c(value, 0.5, 0.4, 0.2), color = c("#ffc107", "#195030"))
              liquid %>% 
                e_charts() %>% 
                e_liquid(
                  serie = name, 
                  color = color,
                  outline= (
                    show= FALSE
                  ),
                  label = list(
                    fontSize = 35,
                    formatter = "{c}"
                  )
                ) %>%
                e_grid(width = "100%", left = "70%")
            }
            
            
          })
        })
        
        output$ActPaint <- renderEcharts4r({
          paint_v<- mean(spc_data$paintDiv)
          paint_v<- round(as.numeric(paint_v), 2)
          value<- paint_v
          print("paint_v")
          print(value)
          liquid <- data.frame(name= c(value, 0.5, 0.4, 0.2), color = c("#ffc107", "#195030"))
          liquid %>% 
            e_charts() %>% 
            e_liquid(
              serie = name, 
              color = color,
              outline= (
                show= FALSE
              ),
              label = list(
                fontSize = 35,
                formatter = "{c}"
              )
            ) %>%
            e_grid(width = "100%", left = "70%")
        })
      }
    }
  }
  )
}