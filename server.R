function(input, output, session){
  output$ActPaint <- renderEcharts4r({
    value <- 618.19
    liquid <- data.frame(name= c(value, 0.5, 0.4, 0.2), color = c("#1DA1F2", "#333"))
    liquid %>% 
      e_charts() %>% 
      e_liquid(
        serie = name, 
        color = color,
        label = list(
          formatter = "{c}"
        )
      )
  })
  output$TheoPaint <- renderEcharts4r({
    value <- 818.19
    liquid <- data.frame(name= c(value, 0.5, 0.4, 0.2), color = c("#1DA1F2", "#333"))
    liquid %>% 
      e_charts() %>% 
      e_liquid(
        serie = name, 
        color = color,
        label = list(
          formatter = "{c}"
        )
      )
  })
  output$Delta <- renderEcharts4r({
    value <- 713.19
    liquid <- data.frame(name= c(value, 0.5, 0.4, 0.2), color = c("#1DA1F2", "#333"))
    liquid %>% 
      e_charts() %>% 
      e_liquid(
        serie = name, 
        color = color,
        label = list(
          formatter = "{c}"
        )
      )
  })
}