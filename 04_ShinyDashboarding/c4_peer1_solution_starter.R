library(shiny)
library(tidyverse)

#####Import Data

dat<-read_csv(url("https://www.dropbox.com/s/uhfstf6g36ghxwp/cces_sample_coursera.csv?raw=1"))
dat<- dat %>% select(c("pid7","ideo5"))
dat<-drop_na(dat)

ui<-fluidPage(
    fluidRow(
        column(width=12,
            sliderInput("slider", 
                        label=("Select Five Point Ideology (1=Very liberal, 5=Very conservative)"),
                min=1,
                max=5,
                value=3),
            plotOutput("plot")
        )
    )
)
  
server<-function(input,output){
  output$plot<-renderPlot({
      ideo_value<-input$slider
      ggplot(dat %>% filter(ideo5==ideo_value), aes(x=pid7)) + 
          geom_bar(stat="count") + 
          labs(x="7 Point Party ID, 1=Very D, 7=Very R", y="Count") + 
          scale_y_continuous(breaks=seq(0, 125, 25), limits=c(0, 125)) + 
          xlim(0, 8)
  })
}

shinyApp(ui,server)
