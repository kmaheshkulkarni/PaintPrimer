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
        meanap<<- round(mean(spc_data$paintDiv), 2)
        print("meanap")
        print(meanap)
        IChart<- ichart_ly(spc_data, x = spc_data$Date_of_Paint, y = spc_data$paintDiv, 
                             xname = "Date", yname = "Paint Volume in CC")
        output$spc_plot<-renderPlotly({
          IChart
        })
        
        MeanActConsmBox<- bs4ValueBox(value = meanap, subtitle = "Mean Actual Consumption", status = "warning",
                                      footer = "Unit in CC", icon = "database", width = 12)
        output$MeanActConsm<- renderbs4ValueBox(
          MeanActConsmBox
        )
        
        
        UTransfer<- Theoretical(SurfArea = surft, DFT = 2.5, TransfEffi = 100)
        print(UTransfer)
        UTFr<- round(UTransfer,2)
        USL <<- as.numeric(UTFr)
        USLBox<- bs4ValueBox(value = USL, subtitle = "USL", status = "warning",
                             footer = "Unit in CC", icon = "database", width = 12)
        output$USLV<- renderbs4ValueBox(
          USLBox
        )
        
        LTransfer<- Theoretical(SurfArea = surft, DFT = 1.5, TransfEffi = 100)
        print(LTransfer)
        LTFr<- round(LTransfer,2)
        LSL <<- as.numeric(LTFr)
        LSLBox<- bs4ValueBox(value = LSL, subtitle = "LSL", status = "success",
                             footer = "Unit in CC", icon = "database", width = 12)
        output$LSLV<- renderbs4ValueBox(
          LSLBox
        )
        
        
        observeEvent(input$part_desc,{
          temp_data <- job_part[job_part$Job_Number == input$part_desc, ]
          surft <- setNames(as.numeric(temp_data$Surface_Area),temp_data$Surface_Area)
          surft <<- round(as.numeric(surft),2)
          
          ######################################## Theoretical Paint Plot ####################################
          Transfer<- Theoretical(SurfArea = surft, DFT = input$Edft,TransfEffi = input$TrnsfEfi)
          print("Transfer")
          print(Transfer)
          Transfer<<- round(Transfer,2)
          value <- as.numeric(Transfer)
          liqival <- round(Transfer,2)
          Theoliquid <- data.frame(name= c(liqival, 0.5, 0.4, 0.2), color = c("#ffc107", "#195030"))
          TheorPlot<<- Theoliquid %>% 
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
              ),
              radius = "90%"
            )
          
          output$TheoPaint <- renderEcharts4r({
            TheorPlot
          })
          
          ######################### Delta Plot #######################
          # Transfer<- Theoretical(SurfArea = surft, DFT = input$Edft,TransfEffi = input$TrnsfEfi)
          
          # Transfer<- round(Transfer,2)
          TheDelta<- mean(spc_data$paintDiv) - Transfer
          TheDelta<- as.numeric(TheDelta)
          print("TheDelta")
          print(TheDelta)
          Deltavalue <- round(TheDelta, 2)
          print("Deltavalue")
          print(Deltavalue)
          Redliquid <- data.frame(name= c(Deltavalue, 0.5, 0.4, 0.2), color = c("#000000", "#ff0000"))
          print("RedLiquid")
          print(Redliquid)
          RedPlot<- Redliquid %>% 
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
              ),
              radius = "90%"
            )
          
          Greenliquid <- data.frame(name= c(Deltavalue, 0.5, 0.4, 0.2), color = c("#ffc107", "#195030"))
          
          Greenplot<- Greenliquid %>% 
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
              ),
              radius = "90%"
            )
          
          DeltaPlot<<-if(Deltavalue <= 0) RedPlot else Greenplot # ifelse(Deltavalue <= 0, "RedPlot", Greenplot)
          DeltaPlot
          output$Delta <- renderEcharts4r({
            DeltaPlot
          })
          
          
        
        })
        
        
        SurfBox<<- bs4ValueBox(value = round(as.numeric(surft),2), subtitle = "Surface Area", status = "success",
                              footer = "Unit in SQ.Ft", icon = "database", width = 12)
        output$SurfaceArea<- renderbs4ValueBox(
          SurfBox
        )
        
        
        ######################### Act Point #######################
        paint_v<- mean(spc_data$paintDiv)
        paint_v<- as.numeric(paint_v)
        APvalue<- paint_v 
        APvalue<- round(APvalue, 2)
        print("APvalue")
        print(APvalue)
        liquid <- data.frame(name= c(APvalue, 0.5, 0.4, 0.2), color = c("#ffc107", "#195030"))
        
        ActPlot<<- liquid %>% 
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
            ),
            radius = "90%"
          ) 
        
        output$ActPaint <- renderEcharts4r({
          ActPlot
        })
        
        output$FlexD <- downloadHandler(
          filename = function(){
            paste('Report', Sys.time(), '.html', sep = '')
          },
          content = function(file) {
            params <- list(AP= ActPlot, DelPlot = DeltaPlot, TheoPaintPlot = TheorPlot, SurfaceAreaBox = surft, 
                           LSLVBox = LSL , USLVBox = USL, MeanActConsmVBox= meanap, spcplot = IChart)
            src <- normalizePath('FlexD.Rmd')
            owd <- setwd('Report')
            on.exit(setwd(owd))
            file.copy(src, 'FlexD.Rmd', overwrite = TRUE)
            out <- rmarkdown::render('FlexD.Rmd', output_format = flexdashboard::flex_dashboard(),
                                     output_dir = "~/Report")
            file.rename(out, file)
            # Get a nicely formatted date/time string
          }
        )
      }
    }
  }
  )
  volumes <- c(Home = fs::path_home(), "R Installation" = R.home(), getVolumes()())
  shinyFileChoose(input, "file", roots = volumes, session = session)
  observe({
    cat("\ninput$file value:\n\n")
    path <- parseFilePaths(volumes, input$file)
    print( path$name)
  })
  
  observeEvent(input$smail,{
    if(is.null(input$smail)||input$smail==0)
    {
      returnValue()
    }
    else
    {
      
      
      path <- parseFilePaths(volumes, input$file)
      # tryCatch(
      #   {
      date_time <- add_readable_time()
      
      email <- compose_email(body = md("Hi Team
                                       PFA"), 
                             footer = md(c("Email sent on ", date_time, "."))
                             )
      # setwd("../PaintPrimer")
      print("Email Msg")
      print(email)
      
      file<- path
      path <- parseFilePaths(volumes, input$file)
      attach<- add_attachment(
        email = email,
        file = path$datapath,
        content_type = mime::guess_type(file),
        filename = basename(file)
      )
      
      
      
      # Sending email by SMTP using a credentials file
      attach %>%
        smtp_send(
          to = "kulkarni.mahesh320@gmail.com",
          from = "vmk80555@outlook.com",
          subject ="Daily Report",
          credentials = creds_file("email_creds")
        )
      
      #   },
      #   error = function(e){
      #     shinyalert(
      #       title = "Mail No Sent",closeOnEsc = TRUE,closeOnClickOutside = FALSE,html = TRUE,
      #       type = "error",showConfirmButton = TRUE,showCancelButton = FALSE,confirmButtonText = "OK",
      #       confirmButtonCol = "#ffc107",timer = 0,imageUrl = "",animation = TRUE
      #     )
      #   },
      #   finally = shinyalert(
      #     title = "Mail Successfully Sent",closeOnEsc = TRUE,closeOnClickOutside = FALSE,html = TRUE,
      #     type = "success",showConfirmButton = TRUE,showCancelButton = FALSE,confirmButtonText = "OK",
      #     confirmButtonCol = "#195030",timer = 0,imageUrl = "",animation = TRUE
      #   )
      # )
      
    }
  }
  )
}