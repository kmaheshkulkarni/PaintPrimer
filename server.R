function(input, output, session){
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